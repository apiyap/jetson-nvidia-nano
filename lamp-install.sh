
set -e
sudo apt-get install apache2
sudo service apache2 status

sudo ufw app list
sudo ufw app info "Apache Full"

sudo apt-get install -y mysql-server
sudo apt-get install -y php libapache2-mod-php php-mysql 

echo "Add index.php in dir.conf"
sudo nano /etc/apache2/mods-enabled/dir.conf

sudo systemctl restart apache2
sudo apt-get install php-cli

sudo apt-get install -y phpmyadmin 

sudo service apache2 restart 
sudo mysql
#CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';
#GRANT ALL PRIVILEGES ON * . * TO 'newuser'@'localhost';
#FLUSH PRIVILEGES;

