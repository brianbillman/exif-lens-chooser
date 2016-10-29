#!/usr/bin/env bash

options=(\
   'Nikkor-N·C Auto 28 mm f/2.0' \
   'Nikkor 28 mm f/2.8 AIS' \
   'Vivitar 28 mm f/2.0 MC Close Focus' \
   'Nikkor-N·C Auto 35 mm f/1.4' \
   'Nikkor-O Auto 35 mm f/2.0' \
   'Nikkor-S Auto 50 mm f/1.4' \
   'Nikon 50 mm f/1.8 Series E' \
   'Nikkor 50 mm f/1.8 AI' \
   'Nikkor 50 mm f/2.0' \
   'Micro-Nikkor Auto 55 mm f/3.5' \
   'Micro-Nikkor 55 mm f/3.5 AI' \
   'Nikkor 105 mm f/2.5 AI' \
   'Micro-Nikkor 105 mm f/4 AIS' \
   'Nikkor 135 mm f/2.0 AI' \
   'Nikkor 200 mm f/4.0 AI' \
   'Nikkor 400 mm f/5.6 ED-IF' \
   'Nikkor 50-135 mm f/3.5 AIS' \
   'Nikon 75-150 mm f/3.5 Series E' \
   'Vivitar Series 1 28-90 mm f/2.8-3.5' \
   'Nikkor 28 mm f/2.0 AIS' \
   'Nikkor H Auto 28 mm f/3.5' \
)

function show_prompt()
{
    echo ""
    echo "Lens Options:"

    PS3='
    Enter choice: '

    lens_name=""

    select opt in "${options[@]}"
    do
        echo ""

        # if not an integer, <= 0, or > number of options, abort
        if [ "${REPLY//[0-9]}" != "" ] || [ "$REPLY" -le 0 ] || [ "$REPLY" -gt "${#options[@]}" ]
        then
            echo "Enter a valid number from menu above"
        else
            lens_name="$opt"
            break
        fi
    done

    echo "    Selected lens: $lens_name"
    echo ""
}

show_prompt

while true
do
    read -r -p "    Proceeed with selected lens? (y)es, (n)o, or (q)uit: " choice
    case "$choice" in
        y|Y|yes|YES|Yes) break;;
        n|N|no|NO|No) show_prompt;;
        q|Q|quit|QUIT|Quit) exit;;
    esac
done

lens_params=''

# for primes
focal_length=''
max_aperture=''

# for zooms
focal_length_min=''
focal_length_max=''
max_aperture_at_min_fl=''
max_aperture_at_max_fl=''


case "$lens_name" in

    'Nikkor-N·C Auto 28 mm f/2.0')
       focal_length='28'
       max_aperture='2.0'
       lens_params="\
                -AFAperture='$max_aperture' \
                -DNGLensInfo='$lens_name' \
                -EffectiveMaxAperture='$max_aperture' \
                -FocalLength='$focal_length' \
                -Lens='$lens_name' \
                -LensFStops='7.00' \
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

   'Nikkor 28 mm f/2.8 AIS')
      focal_length='28'
      max_aperture='2.8'
      lens_params="\
               -AFAperture='$max_aperture' \
               -DNGLensInfo='$lens_name' \
               -EffectiveMaxAperture='$max_aperture' \
               -FocalLength='$focal_length' \
               -Lens='$lens_name' \
               -LensFStops='6.00' \
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

   'Vivitar 28 mm f/2.0 MC Close Focus')
      focal_length='28'
      max_aperture='2.0'
      lens_params="\
               -AFAperture='$max_aperture' \
               -DNGLensInfo='$lens_name' \
               -EffectiveMaxAperture='$max_aperture' \
               -FocalLength='$focal_length' \
               -Lens='$lens_name' \
               -LensFStops='6.00' \
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

   'Nikkor-N·C Auto 35 mm f/1.4')
      focal_length='35'
      max_aperture='1.4'
      lens_params="\
               -AFAperture='$max_aperture' \
               -DNGLensInfo='$lens_name' \
               -EffectiveMaxAperture='$max_aperture' \
               -FocalLength='$focal_length' \
               -Lens='$lens_name' \
               -LensFStops='8.00' \
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

   'Nikkor-O Auto 35 mm f/2.0')
      focal_length='35'
      max_aperture='2.0'
      lens_params="\
               -AFAperture='$max_aperture' \
               -DNGLensInfo='$lens_name' \
               -EffectiveMaxAperture='$max_aperture' \
               -FocalLength='$focal_length' \
               -Lens='$lens_name' \
               -LensFStops='6.00' \
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

   'Nikkor-S Auto 50 mm f/1.4')
      focal_length='50'
      max_aperture='1.4'
      lens_params="\
               -AFAperture='$max_aperture' \
               -DNGLensInfo='$lens_name' \
               -EffectiveMaxAperture='$max_aperture' \
               -FocalLength='$focal_length' \
               -Lens='$lens_name' \
               -LensFStops='7.00' \
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

   'Nikon 50 mm f/1.8 Series E')
      focal_length='50'
      max_aperture='1.8'
      lens_params="\
               -AFAperture='$max_aperture' \
               -DNGLensInfo='$lens_name' \
               -EffectiveMaxAperture='$max_aperture' \
               -FocalLength='$focal_length' \
               -Lens='$lens_name' \
               -LensFStops='7.33' \
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

   'Nikkor 50 mm f/1.8 AI')
      focal_length='50'
      max_aperture='1.8'
      lens_params="\
               -AFAperture='$max_aperture' \
               -DNGLensInfo='$lens_name' \
               -EffectiveMaxAperture='$max_aperture' \
               -FocalLength='$focal_length' \
               -Lens='$lens_name' \
               -LensFStops='7.33' \
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

   'Nikkor 50 mm f/2.0')
      focal_length='50'
      max_aperture='2.0'
      lens_params="\
               -AFAperture='$max_aperture' \
               -DNGLensInfo='$lens_name' \
               -EffectiveMaxAperture='$max_aperture' \
               -FocalLength='$focal_length' \
               -Lens='$lens_name' \
               -LensFStops='6.00' \
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

   'Micro-Nikkor Auto 55 mm f/3.5')
      focal_length='55'
      max_aperture='3.5'
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

   'Micro-Nikkor 55 mm f/3.5 AI')
      focal_length='55'
      max_aperture='3.5'
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

   'Micro-Nikkor 105 mm f/4 AIS')
      focal_length='105'
      max_aperture='4.0'
      lens_params="\
               -AFAperture='$max_aperture' \
               -DNGLensInfo='$lens_name' \
               -EffectiveMaxAperture='$max_aperture' \
               -FocalLength='$focal_length' \
               -Lens='$lens_name' \
               -LensFStops='6.00' \
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

   'Nikkor 135 mm f/2.0 AI')
      focal_length='135'
      max_aperture='2.0'
      lens_params="\
               -AFAperture='$max_aperture' \
               -DNGLensInfo='$lens_name' \
               -EffectiveMaxAperture='$max_aperture' \
               -FocalLength='$focal_length' \
               -Lens='$lens_name' \
               -LensFStops='7.00' \
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

   'Nikkor 200 mm f/4.0 AI')
      focal_length='200'
      max_aperture='4.0'
      lens_params="\
               -AFAperture='$max_aperture' \
               -DNGLensInfo='$lens_name' \
               -EffectiveMaxAperture='$max_aperture' \
               -FocalLength='$focal_length' \
               -Lens='$lens_name' \
               -LensFStops='6.00' \
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

   'Nikkor 400 mm f/5.6 ED-IF')
      focal_length='400'
      max_aperture='5.6'
      lens_params="\
               -AFAperture='$max_aperture' \
               -DNGLensInfo='$lens_name' \
               -EffectiveMaxAperture='$max_aperture' \
               -FocalLength='$focal_length' \
               -Lens='$lens_name' \
               -LensFStops='5.00' \
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

   'Nikkor 50-135 mm f/3.5 AIS')
      focal_length_min='50'
      focal_length_max='135'
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
               -MaxApertureValue='$max_aperture_min_fl' \
               -MaxFocalLength='$focal_length_max' \
               -MinFocalLength='$focal_length_min' \
               -LensSpecification='$focal_length_min, $focal_length_max, $max_aperture_at_min_fl, $max_aperture_at_max_fl' \
               -LensID='$lens_name' \
               -AutoFocus='Off' \
               -DepthOfField='' \
               -HyperfocalDistance='' \
               -ExitPupilPosition='0' \
               -FieldOfView='' \
               -FocusMode='Manual' \
               -LensIDNumber='0' \
               -PhaseDetectAF='Off' \
               "
   ;;

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

   'Vivitar Series 1 28-90 mm f/2.8-3.5')
      focal_length_min='28'
      focal_length_max='90'
      max_aperture_at_min_fl='2.8'
      max_aperture_at_max_fl='3.5'
      lens_params="\
               -AFAperture='$max_aperture_at_min_fl' \
               -DNGLensInfo='$lens_name' \
               -EffectiveMaxAperture='$max_aperture_at_max_fl' \
               -FocalLength='$focal_length_min' \
               -Lens='$lens_name' \
               -LensFStops='5.00' \
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



   # old lenses I no longer have:

   'Nikkor 28 mm f/2.0 AIS')
      focal_length='28'
      max_aperture='2.0'
      lens_params="\
               -AFAperture='$max_aperture' \
               -DNGLensInfo='$lens_name' \
               -EffectiveMaxAperture='$max_aperture' \
               -FocalLength='$focal_length' \
               -Lens='$lens_name' \
               -LensFStops='7.00' \
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

   'Nikkor H Auto 28 mm f/3.5')
      focal_length='28'
      max_aperture='3.5'
      lens_params="\
               -AFAperture='$max_aperture' \
               -DNGLensInfo='$lens_name' \
               -EffectiveMaxAperture='$max_aperture' \
               -FocalLength='$focal_length' \
               -Lens='$lens_name' \
               -LensFStops='4.33' \
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


esac

#######################

# function to calculate "35mm  Effective Focal Length"
function calc35mmFocalLength()
{
   local fileName="$1"
   local focalLength="$2"

   local camera=$(exiftool -UniqueCameraModel "$fileName" | cut -d : -f 2 | sed 's/^ *//')

   case "$camera" in

	   # APS-C / DX
       'Nikon D70S' | 'Nikon D300' | 'Nikon D7000' | 'Nikon D7100' | 'Nikon D7200')
         local conversionFactor='1.5'
       ;;

	   # Full Frame
       'Nikon D700' | 'Nikon D3' | 'Nikon D3S' | 'Nikon D600' | 'Nikon D610' | 'Nikon D800' | 'Nikon D800E' | 'Nikon DF' | 'Nikon D810' | 'Nikon D750')
         local conversionFactor='1.0'
       ;;
	   
	   # Micro 4/3
       'Olympus E-M10')
         local conversionFactor='2.0'
       ;;

   esac

   local focalLength35mm=$(echo "$conversionFactor * $focalLength" | bc -l)

   echo $focalLength35mm
}


# need to have "$@" properly escaped!
# loop over each file
RESULT=""


for file in "$@"
do
   focalLength35mmParam=""

   # if a zoom defines a min focal length, use that as effective focal length
   #  can be overridden if focal_length is still defined in block
   if [ "$focal_length" == "" -a "$focal_length_min" != "" ]
   then
      focal_length="$focal_length_min"
   fi

   if [ "$focal_length" != "" ]
   then
      focalLength35mm=$(calc35mmFocalLength "$file" "$focal_length")
      focalLength35mmParam="-FocalLengthIn35mmFormat='$focalLength35mm'"
   fi

   cmd="exiftool -overwrite_original $lens_params $focalLength35mmParam \"$file\" 2>&1"
   cmd="exiftool -overwrite_original $lens_params $focalLength35mmParam $nonNikonParam \"$file\" 2>&1"

   # update the EXIF info in file(s)
   RESULT="$RESULT $file = $(eval $cmd)\n"
done



# Write output and gather stats

EXIF_FILE='exif-lens-chooser.txt'
EXIF_PATH_DISPLAY='~'
EXIF_PATH="/Users/$(id -un)"
EXIF_FULL_PATH="$EXIF_PATH/$EXIF_FILE"


echo -e "$RESULT" > "$EXIF_PATH/$EXIF_FILE"

NUM_GOOD=$(grep -c '1 image files updated' "$EXIF_FULL_PATH" )
NUM_BAD=$(grep -c '0 image files updated' "$EXIF_FULL_PATH" )


if [ "$NUM_BAD" -gt "0" ]
then
   # couldn't update some files
   SUBTITLE_TEXT="Updated: $NUM_GOOD, NOT Updated: $NUM_BAD"
   MESSAGE_TEXT="See $EXIF_PATH_DISPLAY/$EXIF_FILE"
else
   # all files updated, remove file
   #rm "$EXIF_FULL_PATH"
   SUBTITLE_TEXT="Success!"
   MESSAGE_TEXT="Files updated: $NUM_GOOD"
fi

TITLE_TEXT="EXIF Update Complete"
SOUND="Hero"

echo ""
echo "$TITLE_TEXT"
echo "$SUBTITLE_TEXT"
echo "$MESSAGE_TEXT"

# Show notification
if true
then
   if type terminal-notifier > /dev/null
   then
      terminal-notifier -message "$MESSAGE_TEXT" -title "$TITLE_TEXT" -subtitle "$SUBTITLE_TEXT" -sound "$SOUND" -sender "com.apple.automator.EXIF Lens Chooser"
   else
      osascript -e "display notification \"$MESSAGE_TEXT\" with title \"$TITLE_TEXT\" subtitle \"$SUBTITLE_TEXT\" sound name \"$SOUND\" "
   fi
fi

