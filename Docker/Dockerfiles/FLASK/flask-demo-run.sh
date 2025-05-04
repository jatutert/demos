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
echo Starten Flaks demo omgeving 
echo Website One of Five on Port 9001
docker run -p 9001:5000 -d --name website-one   flask-demo:latest
echo Website Two of Five on Port 9002
docker run -p 9002:5000 -d --name website-two   flask-demo:latest
echo Website Three of Five on Port 9003
docker run -p 9003:5000 -d --name website-three flask-demo:latest
echo Website Four of Five on Port 9004
docker run -p 9004:5000 -d --name website-four  flask-demo:latest
echo Website Five of Five on Port 9005
docker run -p 9005:5000 -d --name website-five  flask-demo:latest
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
#
echo "Website One at port 9001" $ip_address
# echo "Deutsch op poort 9001" $ip_address
echo "Website Two at port 9002" $ip_address
# echo "Francais op poort 9002" $ip_address
echo "Website Three at port 9003" $ip_address
# echo "Italiano op poort 9003" $ip_address
echo "Website Four at port 9004" $ip_address
# echo "Nederlands op poort 9004" $ip_address
echo "Website Five at port 9005" $ip_address
# echo "English op poort 9005" $ip_address