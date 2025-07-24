#! /bin/bash
#
# Script for starting multiple demo docker images 
#
# Author: John Tutert
#
# Based on default flash demo https://hackmd.io/@pmanzoni/r1uWcTqfU
#
# For Personal or educational use only 
#
if [ $(id -u) -eq 0 ]; then
   echo "This script NOT be started with sudo !"
   exit 1
fi 
#
echo Verwijderen eventueel aanwezige Flask demo 
#
echo Website One of Five
docker stop website-one > /dev/null 2>&1
docker rm website-one --force > /dev/null 2>&1
#
echo Website Two of Five
docker stop website-two > /dev/null 2>&1
docker rm website-two --force > /dev/null 2>&1
#
echo Website Three of Five
docker stop website-three > /dev/null 2>&1
docker rm website-three --force > /dev/null 2>&1
#
echo Website Four of Five
docker stop website-four > /dev/null 2>&1
docker rm website-four --force > /dev/null 2>&1
#
echo Website Five of Five
docker stop website-five > /dev/null 2>&1
docker rm website-five --force > /dev/null 2>&1
#
# 22 juli 2025 Poorten aangepast LUCT 4 1 B9 
#
echo Starten Flask demo omgeving 
echo Website One of Five on Port 9205
docker run -p 9205:5000 -d --name website-one   flask-demo:latest
echo Website Two of Five on Port 9206
docker run -p 9206:5000 -d --name website-two   flask-demo:latest
echo Website Three of Five on Port 9207
docker run -p 9207:5000 -d --name website-three flask-demo:latest
echo Website Four of Five on Port 9208
docker run -p 9208:5000 -d --name website-four  flask-demo:latest
echo Website Five of Five on Port 9209
docker run -p 9209:5000 -d --name website-five  flask-demo:latest
#
# meerdere talen demo 
# docker run -p 9001:5000 -d --name flask-demo-de flask-demo-de:v100
# docker run -p 9002:5000 -d --name flask-demo-fr flask-demo-fr:v100
# docker run -p 9003:5000 -d --name flask-demo-it flask-demo-it:v100
# docker run -p 9004:5000 -d --name flask-demo-nl flask-demo-nl:v100
# docker run -p 9005:5000 -d --name flask-demo-uk flask-demo-uk:v100
#
# Ophalen IP address
ip_address=$(ip addr show eth1 | grep 'inet\b' | awk '{print $2}' | cut -d/ -f1)
ip_address=$(ip addr show ens33 | grep 'inet\b' | awk '{print $2}' | cut -d/ -f1)
#
echo "Website One at port 9205" $ip_address
# echo "Deutsch op poort 9001" $ip_address
echo "Website Two at port 9206" $ip_address
# echo "Francais op poort 9002" $ip_address
echo "Website Three at port 9207" $ip_address
# echo "Italiano op poort 9003" $ip_address
echo "Website Four at port 9208" $ip_address
# echo "Nederlands op poort 9004" $ip_address
echo "Website Five at port 9209" $ip_address
# echo "English op poort 9005" $ip_address