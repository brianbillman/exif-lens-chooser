# EXIF Lens Chooser

When images are dropped onto the app, a dialog appears with a list of (user defined) lenses.  Select a lens, choose *OK*, and the EXIF data associated with that option will be written into all the dropped image files using [exiftool](http://www.sno.phy.queensu.ca/~phil/exiftool/index.html), which must be installed on the system.  When the processing is complete, a growl message with the results is given.


## Prerequisites

Before using this application, you must first download and install [exiftool](http://www.sno.phy.queensu.ca/~phil/exiftool/index.html).

The application also assumes Growl's [growlnotify](http://growl.info/extras.php#growlnotify) is installed, as it provides a message when the processing is complete.

## Installation

[Download](https://github.com/brianbillman/exif-lens-chooser/zipball/master) the zip file, and move  *EXIF Lens Chooser.app* to your `/Applications/` directory.

## How I Use It

I use Lightroom as my image library.  After importing images into Lightroom, I use the library filters to limit by lens (*0.0mm f/0.0* for photos without a lens defined) and then focal length (since my camera allows me to set partial EXIF information, such as focal length and aperture) and select all the remaining photos.  Then I explicitly save the metadata to the files (*Metadata → Save Metadata to File* or ⌘S), and drag and drop the photos from the Lightroom grid onto the application.  I recommend not editing the selected files in Lightroom before setting the correct lens info.  After files are updated by the app, I select them again (normally they are still selected) and choose *Metadata → Read Metadata from File*.  Lightroom then refreshes the files and you can see the new EXIF info for the selected images.

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

* If the virtual copies are in any publish collections, just their metadata wil be updated, and you don't be prompted to remove the image from the publish collection like the old way.  
* Less switching between modules, therefore is faster.

Of course, it's still much easier to change the EXIF data *before* you create any virtual copies, but if you can't avoid it, this appears to be the best way to handle it for now.


Alternatively, you can also do the following, but it will cause problems if the virtual copies are in any Publish Collections:

1. In the Develop module, create a snapshot of the settings for the virtual copy (also make note of the copy name if one exists under Library → Metadata Panel).
1. Delete the virtual copy with incorrect EXIF info.
1. Create a new virtual copy from master photo.
1. Apply the snapshot you just created to the new virtual copy, and set the copy name back to original value, if necessary.

The new virtual copy should have the updated lens info.


## How to Customize

Open the app in Automator, and you should see 6 collapsable sections.  The ones to modify are the second and sixth sections.

### Run AppleScript (show prompt for lens selection)

 1. Expand section
 2. The double quoted values between the `{` and `}` are the items that appear in the list.  The number at the beginning of each quoted string (example: `1. Nikon…`) is the unique id that will be referenced later, and the rest is just a descriptive label (after the period).  Separate each item with a comma, and make sure double quotes surround each item's text.  Add or remove lenses as desired.

### Run Shell Script (modify EXIF to files based using exiftool)
 1. Expand section
 2. Inside the `case` statement, the `1.*)`, `2.*)`, etc. correspond to the numbers at the beginning of each quoted string in the previous section.  These must match up, or else the lens you select from the dialog won't set the correct lens info.
 3. Edit the values within the `lens_params` string for each lens for what you want to set into the image's EXIF data.  Specific examples are given below for prime and zoom lenses.  The `Lens` value is the description that appears in Lightroom; this can be as generic or as verbose as you'd like.  I decided to make mine an accurate description of the lenses, even if the format doesn't match what's reported for the autofocus/CPU lenses I have.
 4. Additional EXIF fields fields are described in this [exiftool documentation](http://www.sno.phy.queensu.ca/~phil/exiftool/TagNames/EXIF.html).  Some fields of possible interest: `LensMake`, `LensModel`, `LensSerialNumber`.
 5. Feel free to add or remove lenses as desired, but they need to have a corresponding entry in the *Run AppleScript* section.
 6. If you wish to remove the Growl notification, put a `#` in front of the last line that starts with `/usr/local/bin/growlnotify`.

**Prime lens example:**

    lens_info='Nikkor 105 mm f/2.5 AI'
    lens_params="\
                -AFAperture='2.5' \
                -DNGLensInfo='$lens_info' \
                -EffectiveMaxAperture='2.5' \
                -FocalLength='105' \
                -FocalLengthIn35mmFormat='157.5' \
                -Lens='$lens_info' \
                -LensFStops='6.33' \
                -LensInfo='$lens_info' \
                -LensModel='$lens_info' \
                -LensType='MF' \
                -MaxApertureAtMaxFocal='2.5' \
                -MaxApertureAtMinFocal='2.5' \
                -MaxApertureValue='2.5' \
                -MaxFocalLength='105' \
                -MinFocalLength='105' \
                "

**Zoom lens example:**

    lens_info='Nikon 75-150 mm f/3.5 Series E'
    lens_params="\
                -AFAperture='3.5' \
                -DNGLensInfo='$lens_info' \
                -EffectiveMaxAperture='3.5' \
                -Lens='$lens_info' \
                -LensFStops='6.33' \
                -LensInfo='$lens_info' \
                -LensModel='$lens_info' \
                -LensType='MF' \
                -MaxApertureAtMaxFocal='3.5' \
                -MaxApertureAtMinFocal='3.5' \
                -MaxApertureValue='3.5' \
                -MaxFocalLength='150' \
                -MinFocalLength='75' \
                "

## Testing

You can see all the EXIF info any image file has by running in Terminal (useful for before/after comparisons to validate your changes, and to compare with other CPU lenses to see what the camera sets for them):

    $ exiftool path/to/file/image.jpg

If you filter the output to only show certain text, you can run:

    $ exiftool path/to/file/image.jpg | grep -i "TextToFind"        


## Make it Look Good

Once you have saved the Automator application, why not [change the application's icon](http://superuser.com/questions/37811/how-can-i-change-an-application-icon-in-mac-os-x/37813#37813) with one of these [nice looking options](http://designrshub.com/2012/01/realistic-examples-of-high-quality-camera-lens-icons.html)?



## Other 

If you have any ideas for how to improve this app, please create a ticket github issue for it and I'll take a look (or fork it and do it yourself!) 
