#!/bin/sh

set -e

KCOV_VERSION=34

CWD="$PWD"

KWD="$HOME/.cache/cargo-make/kcov-$KCOV_VERSION"

mkdir -p $HOME/.cache/cargo-make
cd $HOME/.cache/cargo-make

if [ ! -d $KWD/build ]
then
    sudo apt-get install cmake gcc
    sudo rm -rf $KWD v$KCOV_VERSION.zip
    wget https://github.com/SimonKagstrom/kcov/archive/v$KCOV_VERSION.zip
    unzip v$KCOV_VERSION.zip
    rm -rf v$KCOV_VERSION.zip*
    cd kcov-$KCOV_VERSION

    mkdir build
fi

cd $KWD/build
cmake ..
make
sudo make install
cd $CWD

for OWD in $HOME/.cache/cargo-make/kcov-*
do
    test "$OWD" = "$KWD" || rm -rf "$OWD"
done
