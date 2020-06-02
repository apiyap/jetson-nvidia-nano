#!/bin/bash
set -e
patch -N src/vision_opencv/cv_bridge/CMakeLists.txt patchs/00e0ca81522ce0928f96ce1805abc833ac2de4f7.patch
patch -N -d src/vision_opencv/cv_bridge/src/ < patchs/d8c7bd7717d4348848ef9443c560669d51a5ecf7.patch
#patch -N -d src/vision_opencv/cv_bridge/src/ < patchs/cdbfe885ad0c55a2a78d103f01893d1a15e22ce8.patch
patch -N -d src/vision_opencv/cv_bridge/src/ < patchs/1bab9c83385bf28629a7b244dfa35cd233d8b799.patch

