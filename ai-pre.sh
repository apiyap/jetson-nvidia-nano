#!/bin/bash
set -e
RESET='\e[0m'
# Regular           Bold                Underline           High Intensity      BoldHigh Intens     Background          High Intensity Backgrounds
Bla='\e[0;30m';     BBla='\e[1;30m';    UBla='\e[4;30m';    IBla='\e[0;90m';    BIBla='\e[1;90m';   On_Bla='\e[40m';    On_IBla='\e[0;100m';
Red='\e[0;31m';     BRed='\e[1;31m';    URed='\e[4;31m';    IRed='\e[0;91m';    BIRed='\e[1;91m';   On_Red='\e[41m';    On_IRed='\e[0;101m';
Gre='\e[0;32m';     BGre='\e[1;32m';    UGre='\e[4;32m';    IGre='\e[0;92m';    BIGre='\e[1;92m';   On_Gre='\e[42m';    On_IGre='\e[0;102m';
Yel='\e[0;33m';     BYel='\e[1;33m';    UYel='\e[4;33m';    IYel='\e[0;93m';    BIYel='\e[1;93m';   On_Yel='\e[43m';    On_IYel='\e[0;103m';
Blu='\e[0;34m';     BBlu='\e[1;34m';    UBlu='\e[4;34m';    IBlu='\e[0;94m';    BIBlu='\e[1;94m';   On_Blu='\e[44m';    On_IBlu='\e[0;104m';
Pur='\e[0;35m';     BPur='\e[1;35m';    UPur='\e[4;35m';    IPur='\e[0;95m';    BIPur='\e[1;95m';   On_Pur='\e[45m';    On_IPur='\e[0;105m';
Cya='\e[0;36m';     BCya='\e[1;36m';    UCya='\e[4;36m';    ICya='\e[0;96m';    BICya='\e[1;96m';   On_Cya='\e[46m';    On_ICya='\e[0;106m';
Whi='\e[0;37m';     BWhi='\e[1;37m';    UWhi='\e[4;37m';    IWhi='\e[0;97m';    BIWhi='\e[1;97m';   On_Whi='\e[47m';    On_IWhi='\e[0;107m';

echo -e "${On_Pur}Install system-level dependencies${RESET}"
sudo apt-get install -y git cmake
sudo apt-get install -y libatlas-base-dev gfortran
sudo apt-get install -y libhdf5-serial-dev hdf5-tools
sudo apt-get install -y python3-dev

sudo apt-get install -y libfreetype6-dev python3-setuptools
sudo apt-get install -y protobuf-compiler libprotobuf-dev openssl
sudo apt-get install -y libssl-dev libcurl4-openssl-dev
sudo apt-get install -y cython3
sudo apt-get install -y libxml2-dev libxslt1-dev
echo -e "${On_Pur}Update CMake${RESET}"
wget http://www.cmake.org/files/v3.13/cmake-3.13.0.tar.gz
tar xpvf cmake-3.13.0.tar.gz cmake-3.13.0/

cd cmake-3.13.0/
./bootstrap --system-curl
make -j4
echo 'export PATH=/home/$USER/cmake-3.13.0/bin/:$PATH' >> ~/.bashrc
source ~/.bashrc
echo -e "${BIPur}Install OpenCV system-level dependencies and other development dependencies${RESET}"
sudo apt-get install -y build-essential pkg-config
sudo apt-get install -y libtbb2 libtbb-dev
sudo apt-get install -y libavcodec-dev libavformat-dev libswscale-dev
sudo apt-get install -y libxvidcore-dev libavresample-dev
sudo apt-get install -y libtiff-dev libjpeg-dev libpng-dev
sudo apt-get install -y python-tk libgtk-3-dev
sudo apt-get install -y libcanberra-gtk-module libcanberra-gtk3-module
sudo apt-get install -y libv4l-dev libdc1394-22-dev
echo "${BIPur}Python virtual environments${RESET}"
wget https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py
rm get-pip.py
sudo pip install virtualenv virtualenvwrapper
echo '# virtualenv and virtualenvwrapper' >> ~/.bashrc
echo 'export WORKON_HOME=$HOME/.virtualenvs' >> ~/.bashrc
echo 'export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3' >> ~/.bashrc
echo 'source /usr/local/bin/virtualenvwrapper.sh' >> ~/.bashrc
source ~/.bashrc
echo -e "${BIPur}Create your ‘py3cv4’ virtual environment${RESET}"
mkvirtualenv py3cv4 -p python3
workon py3cv4
deactivate
echo -e "${BIPur}Install the Protobuf Compiler${RESET}"
wget https://raw.githubusercontent.com/jkjung-avt/jetson_nano/master/install_protobuf-3.6.1.sh
sudo chmod +x install_protobuf-3.6.1.sh
./install_protobuf-3.6.1.sh

workon py3cv4 # if you aren't inside the environment
cd ~
cp -r ~/src/protobuf-3.6.1/python/ .
cd python
python setup.py install --cpp_implementation

deactivate









