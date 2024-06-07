#! /bin/bash
# 
# default
# https://hackmd.io/@pmanzoni/r1uWcTqfU
# docker run -p 8888:5000 -d --name flaskdemo flask-demo:v100
# meerdere talen demo 
docker run -p 9001:5000 -d --name flask-demo-de flask-demo-de:v100
docker run -p 9002:5000 -d --name flask-demo-fr flask-demo-fr:v100
docker run -p 9003:5000 -d --name flask-demo-it flask-demo-it:v100
docker run -p 9004:5000 -d --name flask-demo-nl flask-demo-nl:v100
docker run -p 9005:5000 -d --name flask-demo-uk flask-demo-uk:v100
#
ip_address=$(ip addr show eth1 | grep 'inet\b' | awk '{print $2}' | cut -d/ -f1)
echo "Deutsch op poort 9001" $ip_address
echo "Francais op poort 9002" $ip_address
echo "Italiano op poort 9003" $ip_address
echo "Nederlands op poort 9004" $ip_address
echo "English op poort 9005" $ip_address
