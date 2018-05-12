#!/usr/bin/env bash

sudo rm -rf libfreenect2/build
git submodule add --force https://github.com/OpenKinect/libfreenect2.git
git submodule add --force https://github.com/shiffman/OpenKinect-for-Processing.git
git submodule add -b Processing_3.3.6 --force https://github.com/totovr/SimpleOpenni.git
git submodule update --init --recursive
cd libfreenect2



brew update
brew install libusb
brew tap homebrew/versions
brew install glfw3

brew install pkg-config
brew install jpeg-turbo
brew install cmake

brew tap brewsci/science
brew install openni2
export OPENNI2_REDIST=/usr/local/lib/ni2
export OPENNI2_INCLUDE=/usr/local/include/ni2


sudo rm -rf build
mkdir build && cd build
cmake ..
make
make install


sudo make install-openni2


LIBFREENECT2_PIPELINE='cl'

# back up to where the scripts CWD started
cd -
sudo cp -rf SimpleOpenni/SimpleOpenni "$HOME/Documents/Processing/libraries"

echo "TESTING LIBFREENECT"
cd libfreenect2
sudo ./build/bin/Protonect

cd -

# echo "TESTING OPENNI2"
# cd `brew --prefix`/share/openni2/tools
# echo "NI VIEWER DOESN'T DISPLAY ANYTHING"
# sudo ./NiViewer
# cd -
