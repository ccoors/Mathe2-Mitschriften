#!/usr/bin/env bash

echo "PDF 1 => PNG"
pdftocairo -png $1 ifirst
echo "PDF 2 => PNG"
pdftocairo -png $2 isecond
for i in $(ls ifirst*.png); do
    image_number=$(echo $i | sed 's/[^0-9]//g')
    second_param="isecond-$image_number.png"
    output_param="diff-$image_number.png"
    echo "Comparing $i and $second_param..."
    compare $i $second_param $output_param
done
echo "Writing diff to $3..."
convert diff-*.png $3
echo "Cleaning up..."
rm -rfv ifirst* isecond* diff-*
echo "Done."
