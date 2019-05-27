#!/bin/sh

set -e
set -x

KCOV_VERSION=34

CWD="$PWD"

KWD="$HOME/.cache/cargo-make/kcov.$KCOV_VERSION"
mkdir -p $KWD
cd $KWD

ls

if [ ! -d build ]
then
    sudo apt-get install cmake gcc
    wget https://github.com/SimonKagstrom/kcov/archive/v$KCOV_VERSION.zip
    unzip v$KCOV_VERSION.zip
    rm v$KCOV_VERSION.zip*
    cd kcov-$KCOV_VERSION

    mkdir build
fi

cd ./build
cmake ..
make
sudo make install

cd $CWD

for OWD in $HOME/.cache/cargo-make/kcov.*
do
    test "$OWD" = "$KWD" || rm -rf "$OWD"
done
