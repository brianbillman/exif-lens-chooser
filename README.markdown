# EXIF Lens Chooser

When images are dropped onto the app, a dialog appears with a list of (user defined) lenses.  Select a lens, choose *OK*, and the EXIF data associated with that option will be written into all the dropped image files using [exiftool](http://www.sno.phy.queensu.ca/~phil/exiftool/index.html), which must be installed on the system.  When the processing is complete, a growl message with the results is given.


## Prerequisites

Before using this application, you must first download and install [exiftool](http://www.sno.phy.queensu.ca/~phil/exiftool/index.html).

The application also assumes Growl's [growlnotify](http://growl.info/extras.php#growlnotify) is installed, as it provides a message when the processing is complete.

## Installation

[Download](https://github.com/brianbillman/exif-lens-chooser/zipball/master) the zip file, and move  *EXIF Lens Chooser.app* to your `/Applications/` directory.

## How I Use It

I use Lightroom as my image library.  After importing images into Lightroom, I use the library filters to limit by lens (*0.0mm f/0.0* for photos without a lens defined) and then focal length (since my camera allows me to set partial EXIF information, such as focal length and aperture) and select all the remaining photos.  Then I explicitly save the metadata to the files (*Metadata → Save Metadata to File* or ⌘S), and drag and drop the photos from the Lightroom grid onto the application.  It's important to not edit the selected files in Lightroom.  After files are updated by the app, I select them again (normally they are still selected) and choose *Metadata → Read Metadata from File*.  Lightroom then refreshes the files and you can see the new EXIF info for the selected images.

## How to Customize

Open the app in Automator, and you should see 6 collapsable sections.  The ones the modify are the second and sixth sections.

### Run AppleScript (show prompt for lens selection)

 1. Expand section
 2. The double quoted values between the `{` and `}` are the items that appear in the list.  The number at the beginning of each quoted string (example: `1. Nikon…`) is the unique id that will be referenced later, and the rest is just a descriptive label (after the period).  Separate each item with a comma, and make sure double quotes surround each item's text.

### Run Shell Script (modify EXIF to files based using exiftool)
 1. Expand section
 2. Inside the `case` statement, the `1.*)`, `2.*)`, etc. correspond to the numbers at the beginning of each quoted string in the previous section.  These must match up, or else the lens you select from the dialog won't set the correct lens info.
 3. Edit the values within the `lens_params` string for each lens for what you want to set into the image's EXIF data.  Specific examples are given below for prime and zoom lenses.  The `Lens` value is the description that appears in Lightroom; this can be as generic or as verbose as you'd like.  I tried to keep mine similar to what other CPU lenses I use report.
 4. Additional EXIF fields fields are described in this [exiftool documentation](http://www.sno.phy.queensu.ca/~phil/exiftool/TagNames/EXIF.html).  Some fields of possible interest: `LensMake`, `LensModel`, `LensSerialNumber`.
 5. If you wish to remove the Growl notification, put a `#` in front of the last line that starts with `/usr/local/bin/growlnotify`.

**Prime lens example:**

	lens_params="\
	            -Lens='105 mm f/2.5' \
	            -FocalLength='105' \
	            -FocalLengthIn35mmFormat='157.5' \
	            -LensType='MF' \
	            -EffectiveMaxAperture='2.5' \
	            "

**Zoom lens example:**

    lens_params="\
                -Lens='75-150 mm f/3.5' \
                -LensType='MF' \
                -MinFocalLength='75' \
                -MaxApertureAtMinFocal='3.5' \
                -MaxFocalLength='150' \
                -MaxApertureAtMaxFocal='3.5' \
                -EffectiveMaxAperture='3.5' \
                "

## Testing

You can see all the EXIF info any image file has by running in Terminal (useful for before/after comparisons to validate your changes, and to compare with other CPU lenses to see what the camera sets for them):

    $ exiftool path/to/file/image.jpg

If you filter the output to only show certain text, you can run:

    $ exiftool path/to/file/image.jpg | grep -i "TextToFind"        

## Other 

If you have any ideas for how to improve this app, please create a ticket github issue for it and I'll take a look (or fork it and do it yourself!) 