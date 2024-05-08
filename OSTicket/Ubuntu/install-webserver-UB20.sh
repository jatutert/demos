#!/bin/bash

# Ubuntu 22.04 LTS
# Ubuntu Server 22.04 LTS 
# Version of Script 

apt update
apt install apache2 -y
apt install php libapache2-mod-php -y
apt install php-{gd,imap,xml,json,mbstring,mysql,intl,apcu,zip} -y

#install and setup osTicket
mkdir osticket
cd osticket
#
# git clone for Ubuntu 20 
#
# git clone https://github.com/osTicket/osTicket -b 1.15.x --single-branch
#
# git clone for Ubuntu 22 
#
# https://github.com/osTicket/osTicket
# git clone https://github.com/osTicket/osTicket
#
git clone https://github.com/osTicket/osTicket
#
# https://github.com/osTicket/osTicket
# cd osTicket
# php manage.php deploy --setup /var/www/htdocs/osticket/
#
cd osTicket
php manage.php deploy --setup /var/www/html/osticket

cd /var/www/html/osticket/include
cp ost-sampleconfig.php ost-config.php
chmod 0666 ost-config.php
cd ~

mkdir -p -v /etc/skel/public_html
a2enmod userdir
echo "Restarting apache2 webserver..."
systemctl restart apache2