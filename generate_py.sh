#!/bin/bash

# Install dependency
pip install opentypesvg

# Download font
echo "Downloading font ..."
font=materialdesignicons-webfont.ttf
version=7.2.96
rm $font
wget -O $font https://cdn.jsdelivr.net/npm/@mdi/font@$version/fonts/$font?v=$version

# Get svgs from font
echo "Generating svg files ..."
tmpfolder=mdi-tmp
mkdir -p $tmpfolder
fonts2svg -c ABC123 -o $tmpfolder $font

# Generate python file
echo "Generating file ..."
echo "class MDI:" > mdi.py
echo "    \"\"\"Material Design Icons\"\"\"" >> mdi.py
echo "    font = '$font'" >> mdi.py
echo "    icons = {" >> mdi.py

# Read names and svg contents
for f in $tmpfolder/*.svg ; do
  filename=$(basename -- "$f")
  filename="${filename%.*}"
  content=$(<$f)
  echo "        '$filename': '${content//[$'\t\r\n']}'," >> mdi.py
done;

echo "    }" >> mdi.py
echo "" >> mdi.py
echo "    @staticmethod" >> mdi.py
echo "    def get_icon(name: str, color: str = '#000') -> str:" >> mdi.py
echo "        \"\"\"Get a mdi icon by name\"\"\"" >> mdi.py
echo "        icon = MDI.icons.get(name, '')" >> mdi.py
echo "        return icon.replace('fill=\"#ABC123\"', f'fill=\"{color}\"')" >> mdi.py

# Put generated file in directory
mv -f mdi.py mdi/mdi.py

# Cleanup
echo "Cleanup"
rm $font
rm -r $tmpfolder
