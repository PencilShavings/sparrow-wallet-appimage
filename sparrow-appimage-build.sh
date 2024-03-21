#!/bin/bash

WORKDIR="/tmp/sparrow-wallet-appimage-${RANDOM}"
mkdir -v ${WORKDIR}
cd ${WORKDIR}

VERSION='1.8.4'
APPDIR='Sparrow.AppDir'
TARFILE="sparrow-${VERSION}-x86_64.tar.gz"

# Download appimagetool
curl -L -o appimagetool "https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-x86_64.AppImage"
chmod a+x appimagetool

# Setup AppDir
mkdir -v ${APPDIR}
cd ${APPDIR}

# Download Sparrow
curl -L -O "https://github.com/sparrowwallet/sparrow/releases/download/${VERSION}/${TARFILE}"

# Validate Download
# curl -L -O "https://github.com/sparrowwallet/sparrow/releases/download/${VERSION}/sparrow-${VERSION}-manifest.txt.asc"
curl -L -O "https://github.com/sparrowwallet/sparrow/releases/download/${VERSION}/sparrow-${VERSION}-manifest.txt"
sha256sum --check sparrow-1.8.4-manifest.txt --ignore-missing

if [ "$?" = "0" ]; then
    echo "Checksum PASSED"
    rm sparrow-${VERSION}-manifest.txt
else
    echo "Checksum FAILED, Exiting..."
    cd
    rm -rf ${WORKDIR}
    exit 1
fi

# Extract & remove un-needed files
tar -xzf ${TARFILE} --strip 1 -C .
rm -v ${TARFILE}

# Link Icon
ln -sr ./lib/Sparrow.png Sparrow.png

# Generate AppRun
echo -e '#!/bin/bash
cd "$(dirname "$0")"
./bin/Sparrow -d $HOME/.sparrow' > AppRun
chmod +x AppRun

# Generate .desktop launcher
echo -e '[Desktop Entry]
Version=1.0
Type=Application
Name=Sparrow Wallet
Icon=Sparrow
Exec=AppRun
Comment=Financial self sovereignty
Categories=Finance;Office;
Terminal=false' > Sparrow.desktop

# Build AppImage
cd ..
ARCH=x86_64 ./appimagetool ./${APPDIR} Sparrow-${VERSION}.AppImage
mv -v Sparrow-${VERSION}.AppImage ~/Documents

cd
rm -rf ${WORKDIR}

