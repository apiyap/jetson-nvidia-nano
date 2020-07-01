#!/bin/bash
set -e
sudo mv /usr/share/phpmyadmin/ /usr/share/phpmyadmin.bak
sudo mkdir /usr/share/phpmyadmin/
cd /usr/share/phpmyadmin/


sudo wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-all-languages.tar.gz
sudo tar xzf phpMyAdmin-5.0.2-all-languages.tar.gz
ls
sudo mv phpMyAdmin-5.0.2-all-languages/* /usr/share/phpmyadmin

#Edit vendor_config.php
sudo nano /usr/share/phpmyadmin/libraries/vendor_config.php
#define('TEMP_DIR', '/var/lib/phpmyadmin/tmp/');
#define('CONFIG_DIR', '/etc/phpmyadmin/');

