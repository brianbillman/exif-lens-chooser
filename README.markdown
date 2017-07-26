# EXIF Lens Chooser

When images are passed to the script as arguments, a prompt appears with a list of (user defined) lenses.  Select a lens by entering it's corresponding number, press *Enter*, and the EXIF data associated with that option will be written into all the image files using [exiftool](http://www.sno.phy.queensu.ca/~phil/exiftool/index.html), which must be installed on the system.  When the processing is complete, a notification with the summary of results is given, and a more detailed text file is created at `~/exif-lens-chooser.txt` if there are any problems.


## Prerequisites

Before using this application, you must first download and install [exiftool](http://www.sno.phy.queensu.ca/~phil/exiftool/index.html).

The application also assumes that you are on OS X 10.8 or higher in order to use the built-in notifications.  If you happen to have [terminal-notifier](https://github.com/alloy/terminal-notifier) installed, you will get a nicer notification.

## Installation

[Download](https://github.com/brianbillman/exif-lens-chooser/zipball/master) the zip file, and move the *exif-lens-chooser* directory to your `/Applications/` directory, and set proper permissions to make it executable.  It is easiest to then create a symbolic link in `/usr/local/bin/` (assuming it is in your `PATH`) to point to `exif-lens-chooser.sh`), as follows:

```
# set permissions
chmod  755 /Applications/exif-lens-chooser/exif-lens-chooser.sh

# create symbolic link to a location on your PATH to run from anywhere
ln -s /Applications/exif-lens-chooser/exif-lens-chooser.sh /usr/local/bin/exif-lens-chooser.sh
```

IF you run into permissions issues, you will need to put `sudo` in front of the above commands and enter your Mac's password when prompted.

## How I Use It

I use Lightroom as my image library.  After importing images into Lightroom, I use the library filters to limit by lens (*0.0mm f/0.0* or *Unknown Lens* for photos without a lens defined) and then focal length (since my camera allows me to set partial EXIF information, such as focal length and aperture) and select all the remaining photos.  Then I explicitly save the metadata to the files (*Metadata → Save Metadata to File* or ⌘S).  Next I open Terminal, type out `exif-lens-chooser.sh ` (with a space after it), and drag and drop the photos from the Lightroom grid into the Terminal window.  The full path to all the files will then appear in Terminal, and once it has finished, hit enter to get a prompt to select a lens.  I recommend not editing the selected files in Lightroom before setting the correct lens info.  After thescript finishes, I select them again in Lightroom (normally they are still selected) and choose *Metadata → Read Metadata from File*.  Lightroom then refreshes the files and you can see the new EXIF info for the selected images.  If you have multiple lenses to do this with, you can open multiple Terminal windows, and repeat this process for each lens, so they can run concurrently.

### Virtual Copies

You may notice that if any virtual copies existed for those files, the lens information does not get updated (within the virtual copies), only in the master photos.

The easiest solution is to:

1. Make sure the virtual copy and master file have snapshots saved.  Also note the rating and color label of the virtual copy.
1. While in the Library module, select the virtual copy, then choose from the menu bar: *Photo* → *Set Copy as Master*.  This will make the virtual copy the master file, and the previous master a virtual copy.
1. Choose from the menu bar *Metadata* → *Read Metadata from File*.  This will cause the current master (and what was a virtual copy) to be an exact match of the old master (develop settings, rating, color label).
1. Right click on the master (the old virtual copy), and choose *Develop Settings*, and then choose the appropriate snapshot.
1. Set the rating and color label back to their original values.
1. Select the virtual copy (what was the master before), and choose from the menu bar: *Photo* → *Set Copy as Master*.  From my experience the original settings will be reapplied (if not, re-apply the original master's snapshot).  Bonus: the virtual copy's original *Copy Name* will still be set correctly.

The big benefits of this method include:

* If the virtual copies are in any publish collections, just their metadata will be updated, and you don't be prompted to remove the image from the publish collection like the old way.
* Less switching between modules, therefore is faster.

Of course, it's still much easier to change the EXIF data *before* you create any virtual copies, but if you can't avoid it, this appears to be the best way to handle it for now.


Alternatively, you can also do the following, but it will cause problems if the virtual copies are in any Publish Collections:

1. In the Develop module, create a snapshot of the settings for the virtual copy (also make note of the copy name if one exists under Library → Metadata Panel).
1. Delete the virtual copy with incorrect EXIF info.
1. Create a new virtual copy from master photo.
1. Apply the snapshot you just created to the new virtual copy, and set the copy name back to original value, if necessary.

The new virtual copy should have the updated lens info.


## How to Customize

Open `exif-lens-chooser.sh` in your favorite text editor.

 1. At the top is an `options` array with a list of lens names in it,
 2. Inside the `case` statement , the lens names in single quotes correspond to the lens names defined in `options` above.  These must match exactly, or else the lens you select from the dialog won't set the correct lens info.
 3. Edit the values underneath the lens name for each lens for what you want to set into the image's EXIF data.  Specific examples are given below for prime and zoom lenses.  The `Lens` value is the description that appears in Lightroom; this can be as generic or as verbose as you'd like.  I decided to make mine an accurate description of the lenses, even if the format doesn't match what's reported for the autofocus/CPU lenses I have.
 4. Additional EXIF fields fields are described in this [exiftool documentation](http://www.sno.phy.queensu.ca/~phil/exiftool/TagNames/EXIF.html).  Some fields of possible interest: `LensMake`, `LensModel`, `LensSerialNumber`.
 5. Feel free to add or remove lenses as desired, but they need to have a corresponding entry in the earlier `options` section.
 6. If you wish to remove the notification, find the `# Show notification` section of code, and change the next line `if true` to `if false`.  In either case, if there are any problems updating a photo, a text file will be created at `~/exif-lens-chooser.txt` for further review.  If there are no issues, the file will not exist.  The file will be be overwritten if it already exists whenever the application is run.

#### Examples

Here is an example of the code block for a prime and a zoom lens.  The only values you should need to change are:

* the name (to match the value from the AppleScript list)
* the focal length(s)
* the aperture(s)
* the number of F-stops between the maximum and minimum aperture of the lens

**Prime lens example:**

      'Nikkor 105 mm f/2.5 AI')
         focal_length='105'
         max_aperture='2.5'
         lens_params="\
                  -AFAperture='$max_aperture' \
                  -DNGLensInfo='$lens_name' \
                  -EffectiveMaxAperture='$max_aperture' \
                  -FocalLength='$focal_length' \
                  -Lens='$lens_name' \
                  -LensFStops='6.33' \
                  -LensInfo='$lens_name' \
                  -LensModel='$lens_name' \
                  -LensType='MF' \
                  -MaxApertureAtMaxFocal='$max_aperture' \
                  -MaxApertureAtMinFocal='$max_aperture' \
                  -MaxApertureValue='$max_aperture' \
                  -MaxFocalLength='$focal_length' \
                  -MinFocalLength='$focal_length' \
                  "
      ;;

**Zoom lens example:**
*Note that the minimum focal length (`focal_length_min`) is what will be used as the focal length of the photo (the `FocalLength` field), since there's no way to know what the actual value used was; you can add in `focal_length` to the top of the block and set to whatever value you want if you want a different value used.*

      'Nikon 75-150 mm f/3.5 Series E')
         focal_length_min='75'
         focal_length_max='150'
         max_aperture_at_min_fl='3.5'
         max_aperture_at_max_fl='3.5'
         lens_params="\
                  -AFAperture='$max_aperture_at_min_fl' \
                  -DNGLensInfo='$lens_name' \
                  -EffectiveMaxAperture='$max_aperture_at_max_fl' \
                  -FocalLength='$focal_length_min' \
                  -Lens='$lens_name' \
                  -LensFStops='6.33' \
                  -LensInfo='$lens_name' \
                  -LensModel='$lens_name' \
                  -LensType='MF' \
                  -MaxApertureAtMaxFocal='$max_aperture_at_max_fl' \
                  -MaxApertureAtMinFocal='$max_aperture_at_min_fl' \
                  -MaxApertureValue='$max_aperture_at_min_fl' \
                  -MaxFocalLength='$focal_length_max' \
                  -MinFocalLength='$focal_length_min' \
                  "
      ;;

## Testing

You can see all the EXIF info any image file has by running in Terminal (useful for before/after comparisons to validate your changes, and to compare with other CPU lenses to see what the camera sets for them):

```
$ exiftool path/to/file/image.jpg
```

If you filter the output to only show certain text, you can run:

```
$ exiftool path/to/file/image.jpg | grep -i "TextToFind"
```

## Other

If you have any ideas for how to improve this, please create a ticket github issue for it and I'll take a look (or fork it and do it yourself!)
