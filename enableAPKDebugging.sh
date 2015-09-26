#!/bin/bash

# Get the directory for the script
SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Current Dir
PWD=$(pwd)

# Output Dir
OUTDIR=$SCRIPTDIR/output

# Check number of arguments
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <app.apk to enable debugging for>"
    exit 1
fi


path_to_executable=$(which name_of_executable)
if [ ! -x $(which java) ] ; then
    echo "Error: You need java in your path."
    exit 1
fi

# Save the apk name
APKName=$(echo $(basename $1) | cut -d . -f 1)

# Clear out output dir
rm -rf $OUTDIR 2>/dev/null
#mkdir $OUTDIR

# Enable debugging
echo "Decoding apk"

$SCRIPTDIR/apktool/apktool d -d -o $OUTDIR $1

# Build apk with debug info
echo "Building APK in debug mode"

$SCRIPTDIR/apktool/apktool b -d $OUTDIR

# Sign it

echo "Signging with default key"

java -jar $SCRIPTDIR/SignApk/signapk.jar $SCRIPTDIR/SignApk/testkey.x509.pem $SCRIPTDIR/SignApk/testkey.pk8 $OUTDIR/dist/${APKName}.apk $OUTDIR/dist/${APKName}_debugging.apk

# Align it
echo "Aligning APK"

$SCRIPTDIR/zipalign/zipalign 4 $OUTDIR/dist/${APKName}_debugging.apk $PWD/${APKName}_debugging.apk
