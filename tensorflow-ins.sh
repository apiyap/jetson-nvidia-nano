#!/bin/bash
set -e

sudo apt install -y git \
cmake \
libatlas-base-dev \
 gfortran \
python3-dev \
python3-pip \
libhdf5-serial-dev \
hdf5-tools

echo "export PATH=$PATH:/$HOME/.local/bin" >> .bashrc
echo "alias python=python3" >> .bashrc
echo "alias pip=pip3" >> .bashrc
source .bashrc

cd ~
wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
rm get-pip.py

echo "Install tensorflow"
TF_VERSION=2.1.0  #2.1.0 , 1.15.2
NV_VERSION=20.04  
pip3 install -U pip setuptools --user
pip3 install --user numpy
pip3 install --user --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v44 tensorflow==$TF_VERSION+nv$NV_VERSION
pip3 install --user keras
pip3 install --user jupyter
pip3 install --user pillow

sudo apt-get install -y libfreetype6-dev pkg-config
pip3 install --user matplotlib
pip3 install --user gym

echo "Check python"
python3 -c 'import numpy; print(numpy.__version__)'
python3 -c 'import tensorflow; print(tensorflow.VERSION)'
#python3 -c 'import keras; print(keras.__version__)'
python3 -c 'import jupyter; print(jupyter.__version__)'
python3 -c 'import PIL; print(PIL.__version__)'
python3 -c 'import matplotlib; print(matplotlib.__version__)'
python3 -c 'import tensorflow.compat.v2 as tf; import tensorflow.compat.v2.keras as keras; print(tf.__version__); print(keras.__version__)'
python3 -c 'import gym; print(gym.__version__)'

echo "Install JET Cam"
git clone https://github.com/NVIDIA-AI-IOT/jetcam
cd jetcam
pip3 install ./ --user

#Point the PYTHONPATH variable to OpenCV installation directory.
export PYTHONPATH="$PYTHONPATH:/usr/local/python/cv2/python-3.6/"
echo "export PYTHONPATH=$PYTHONPATH:/usr/local/python/cv2/python-3.6/" >> ~/.bashrc
source ~/.bashrc


