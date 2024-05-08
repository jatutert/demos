#!/bin/bash

if [ ! -f /etc/ssh/sshd_config_old ];
then

echo "Configuring SFTP Server"
groupadd sftpgroup
useradd -m -s /usr/sbin/nologin -G sftpgroup -p $(openssl passwd sftpuser) sftpuser
chmod 755 /home/sftpuser
chown root:root /home/sftpuser

apt update
apt install openssh-server -y

cp /etc/ssh/sshd_config /etc/ssh/sshd_config_old
sed -i 's/^Subsystem	sftp/# &/' /etc/ssh/sshd_config

cat <<'endconf' >> /etc/ssh/sshd_config

Subsystem sftp internal-sftp
Match Group sftpgroup
	ChrootDirectory %h
	X11Forwarding no
	AllowTcpForwarding no
	ForceCommand internal-sftp -d /public_html
endconf

systemctl restart ssh

else
echo "WARNING !!!"
echo "if you say YES then the original ssh configuration is restored..."
mv -i /etc/ssh/sshd_config_old /etc/ssh/sshd_config
systemctl restart ssh
fi