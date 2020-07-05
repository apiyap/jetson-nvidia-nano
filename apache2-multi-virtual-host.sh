#!/bin/bash
set -e

mkdir -p $HOME/public_web/web000/html
mkdir -p $HOME/public_web/web001/html
mkdir -p $HOME/public_web/web002/html
mkdir -p $HOME/public_web/web003/html
mkdir -p $HOME/public_web/web004/html


#Listen 8080        //type port no. here or change over 80 or add new port numbers
sudo nano /etc/apache2/ports.conf

# add an existing user named $USER to group Apache group www-data
sudo adduser $USER www-data

##Add a new user to the www-data group
#sudo useradd -g www-data vivek
### set the password for vivek user ###
#sudo passwd vivek

##Add a existing user to www-data group
sudo usermod -a -G www-data  $USER
id $USER
groups $USER


sudo ln -s $HOME/public_web/web000/html/ web000.com
sudo ln -s $HOME/public_web/web001/html/ web001.com
sudo ln -s $HOME/public_web/web002/html/ web002.com
sudo ln -s $HOME/public_web/web003/html/ web003.com
sudo ln -s $HOME/public_web/web004/html/ web004.com

sudo chmod -R 755 /var/www

sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/web000.com.conf
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/web001.com.conf
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/web002.com.conf
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/web003.com.conf
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/web004.com.conf


#<VirtualHost *:80>                                                //change the port number here by default its #running on 80
#	ServerAdmin webmaster@localhost
#	ServerName	sourabh.com                                // Give server name here 
#	DocumentRoot /var/www/sourabh.com/public_html/            // give Document root path here 
#	<Directory />
#		Options FollowSymLinks
#		AllowOverride None
#	</Directory>
#	<Directory /var/www/>
#		Options Indexes FollowSymLinks MultiViews
#		AllowOverride None
#		Order allow,deny
#		allow from all
#	</Directory>
#
#	ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
#	<Directory "/usr/lib/cgi-bin">
#		AllowOverride None
#		Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
#		Order allow,deny
#		Allow from all
#	</Directory>
#
#	ErrorLog ${APACHE_LOG_DIR}/error.log
#
#	# Possible values include: debug, info, notice, warn, error, crit,
#	# alert, emerg.
#	LogLevel warn
#
#	CustomLog ${APACHE_LOG_DIR}/access.log combined
#
#    Alias /doc/ "/usr/share/doc/"
#    <Directory "/usr/share/doc/">
#        Options Indexes MultiViews FollowSymLinks
#        AllowOverride None
#        Order deny,allow
#        Deny from all
#        Allow from 127.0.0.0/255.0.0.0 ::1/128
#    </Directory>
#
#</VirtualHost>

sudo nano /etc/apache2/sites-available/web000.com.conf
#sudo nano /etc/apache2/sites-available/web001.com.conf
#sudo nano /etc/apache2/sites-available/web002.com.conf
#sudo nano /etc/apache2/sites-available/web003.com.conf
#sudo nano /etc/apache2/sites-available/web004.com.conf

sudo a2ensite web000.com
sudo a2ensite web001.com
sudo a2ensite web002.com
sudo a2ensite web003.com
sudo a2ensite web004.com

#<ip>    hostname
#172.16.1.12    web000.com
#172.16.1.12    web001.com

sudo nano /etc/hosts

WEB='web000.com'
HTML="<html>
  <head>
    <title>${WEB}</title>
  </head>
  <body>
    <h1>${WEB}</h1>
  </body>
</html>"
echo $HTML > /var/www/web000.com/index.html
WEB='web001.com'
HTML="<html>
  <head>
    <title>${WEB}</title>
  </head>
  <body>
    <h1>${WEB}</h1>
  </body>
</html>"
echo $HTML > /var/www/web001.com/index.html

WEB='web002.com'
HTML="<html>
  <head>
    <title>${WEB}</title>
  </head>
  <body>
    <h1>${WEB}</h1>
  </body>
</html>"
echo $HTML > /var/www/web002.com/index.html

WEB='web003.com'
HTML="<html>
  <head>
    <title>${WEB}</title>
  </head>
  <body>
    <h1>${WEB}</h1>
  </body>
</html>"
echo $HTML > /var/www/web003.com/index.html

WEB='web004.com'
HTML="<html>
  <head>
    <title>${WEB}</title>
  </head>
  <body>
    <h1>${WEB}</h1>
  </body>
</html>"
echo $HTML > /var/www/web004.com/index.html


sudo service apache2 restart


