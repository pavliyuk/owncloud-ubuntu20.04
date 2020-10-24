#!/bin/bash
sudo apt update -y && sudo apt upgrade -y
sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:ondrej/php -y
sudo apt install -y apache2 libapache2-mod-php7.2 openssl php-imagick php7.2-common php7.2-curl php7.2-gd php7.2-imap php7.2-intl php7.2-json php7.2-ldap php7.2-mbstring php7.2-mysql php7.2-pgsql php-smbclient php-ssh2 php7.2-sqlite3 php7.2-xml php7.2-zip
sudo dpkg -l apache
sudo systemctl start apache2
sudo systemctl enable apache2
sudo apt install -y mariadb-server
cd /tmp
wget https://download.owncloud.org/community/owncloud-10.5.0.zip 
sudo apt install -y unzip
unzip owncloud-10.5.0.zip 
sudo mv owncloud /var/www/owncloud
sudo chown -R www-data:www-data /var/www/owncloud/
sudo chmod -R 755 /var/www/owncloud/
sudo touch /etc/apache2/conf-available/owncloud.conf
sudo chmod 777 /etc/apache2/conf-available/owncloud.conf
sudo echo "Alias /owncloud "/var/www/owncloud/"
<Directory /var/www/owncloud/>
  Options +FollowSymlinks
  AllowOverride All
 <IfModule mod_dav.c>
  Dav off
 </IfModule>
 SetEnv HOME /var/www/owncloud
 SetEnv HTTP_HOME /var/www/owncloud
</Directory>" >  /etc/apache2/conf-available/owncloud.conf
sudo a2enconf owncloud
sudo a2enmod rewrite
sudo a2enmod headers
sudo a2enmod env
sudo a2enmod dir
sudo a2enmod mime
sudo systemctl restart apache2


#SsL
sudo add-apt-repository ppa:certbot/certbot
sudo atp -y install python3-certbot-apache
sudo certbot --apache -d example.com

# кожного дня в час ночі
0 1 * * * /root/backupscript.sh

