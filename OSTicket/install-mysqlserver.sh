#!/bin/bash

#install mysql server
apt update
apt install mysql-server -y

#setup mysql server
#accept sql queries from all hosts (0.0.0.0)
cd /etc/mysql/mysql.conf.d
sed -i 's/127.0.0.1/0.0.0.0/g' mysqld.cnf
cd ~

# create database for osticket
mysql -e "CREATE DATABASE osticket;"
mysql -e "CREATE USER 'admin'@'%' IDENTIFIED BY 'password';"
mysql -e "GRANT ALL PRIVILEGES ON osticket.* TO 'admin'@'%';"
mysql -e "FLUSH PRIVILEGES;"

systemctl restart mysql