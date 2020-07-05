#!/bin/bash
set -e
sudo apt update
sudo apt-get install linux-headers-$(uname -r)
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget http://developer.download.nvidia.com/compute/cuda/11.0.1/local_installers/cuda-repo-ubuntu1804-11-0-local_11.0.1-450.36.06-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu1804-11-0-local_11.0.1-450.36.06-1_amd64.deb
sudo apt-key add /var/cuda-repo-ubuntu1804-11-0-local/7fa2af80.pub
sudo apt-get update
sudo apt-get -y install cuda
sudo apt install nvidia-cuda-toolkit
echo "export PATH=/usr/local/cuda-11.0/bin\${PATH:+:\${PATH}}" >> ~/.bashrc
#32
#export LD_LIBRARY_PATH=/usr/local/cuda-11.0/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
#64 bit
echo "export LD_LIBRARY_PATH=/usr/local/cuda-11.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}" >> ~/.bashrc
nvidia-smi
nvcc -V
cuda-install-samples-11.0.sh ~
cd ~/NVIDIA_CUDA-11.0_Samples/5_Simulations/nbody
make
./nbody
