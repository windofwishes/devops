#!/bin/bash

echo "* Install Software ..."
sudo apt update
sudo apt upgrade -y
sudo apt install apache2

echo "* Start HTTP ..."
sudo systemctl enable apache2
sudo systemctl start apache2

echo "* Firewall - open port 80 ..."
sudo ufw enable
sudo ufw allow 80

echo "* Install Mariadb ..."
sudo apt upgrade -y
sudo apt install -y mariadb-server mariadb-client

echo "* Start Mariadb ..."
sudo systemctl enable mariadb
sudo systemctl start mariadb

echo "* Firewall - open port 3306 ..."
sudo ufw allow 3306

echo "* Secure-MySql ..."
sudo mysql_secure_installation

echo "* Install-add ..."
sudo apt install software-properties-common
sudo add-apt-repository ppa:ondrej/php

echo "* Install Php ..."
sudo apt install -y php php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip php-cli php-mysql php8.0-common php8.0-opcache php-gmp php-imagick

echo "* Set Php value..."
sed -i "s/;date.timezone.*/date.timezone = Europe\/\Sofia/" /etc/php/*/apache2/php.ini
sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/*/apache2/php.ini
sudo systemctl restart apache2
sudo systemctl enable apache2
sudo systemctl status apache2