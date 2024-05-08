#!/bin/bash

#delete current network configuration
cd /etc/netplan
rm *.yaml
cd ~

#setup three network cards
cat <<'endconf' > /etc/netplan/router.yaml
network:
  ethernets:
    ens33:
      dhcp4: true
    ens37:
      dhcp4: no
      addresses:
      - 192.168.2.254/24
    ens38:
      dhcp4: no
      addresses:
      - 192.168.200.254/24
  version: 2
endconf

netplan apply

#enable forwarding
sed -i '/net.ipv4.ip_forward=1/s/^#//' /etc/sysctl.conf
sysctl -p

#setup the DNS servers
systemctl stop systemd-resolved
systemctl disable systemd-resolved
rm /etc/resolv.conf
cat <<'endconf' > /etc/resolv.conf
nameserver 1.1.1.1
nameserver 1.0.0.1
nameserver 145.76.6.198
nameserver 145.76.6.199
endconf

#Turn on Masquerade
iptables -t nat -A POSTROUTING -j MASQUERADE

#Install iptables-persistent to save configuration
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | sudo debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | sudo debconf-set-selections

apt update
apt install iptables-persistent -y