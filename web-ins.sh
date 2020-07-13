#!/bin/bash
set -e
RESET='\e[0m'
BIBla='\e[1;90m';
BIRed='\e[1;91m';
BIGre='\e[1;92m'; 
BIYel='\e[1;93m';
BIBlu='\e[1;94m';
BIPur='\e[1;95m';
BICya='\e[1;96m';  
BIWhi='\e[1;97m';
export PROJECT_ROOT=$HOME/public_web/web004
export PROJECT_NAME=dev01
sudo apt install composer
sudo apt install php-intl
sudo phpenmod mbstring
sudo phpenmod intl
sudo service apache2 restart

cd ${PROJECT_ROOT}
echo -e "${BIRed}Create Codeigniter 4 project in directory ${PROJECT_NAME}${RESET}"
composer create-project codeigniter4/appstarter ${PROJECT_NAME}
cd ${PROJECT_ROOT}/${PROJECT_NAME}
php builds release
composer update
echo -e "${BIGre}Install codeigniter4/translations to ${PROJECT_NAME}${RESET}"
composer require codeigniter4/translations
echo -e "${BIYel}Install bshaffer/oauth2-server-php to ${PROJECT_NAME}${RESET}"
composer require bshaffer/oauth2-server-php "^1.10"
echo -e "${BIYel}Install AdminLTE to ${PROJECT_NAME}${RESET}"
composer require "almasaeed2010/adminlte=~3.0"

composer update
cp env .env
#Modify .env file
sed -i -e 's/# CI_ENVIRONMENT = production/CI_ENVIRONMENT = development/g' .env
chmod 777 -R writable
