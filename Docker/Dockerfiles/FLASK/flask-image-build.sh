#! /bin/bash
#
# Script for building Flask demo Docker Image
#
# Author: John Tutert
# 
# Based on default flash demo https://hackmd.io/@pmanzoni/r1uWcTqfU
#
# For Personal or educational use only 
#
#
if [ $(id -u) -eq 0 ]; then
   echo "This script NOT be started with sudo !"
   exit 1
fi 
#
echo Verwijderen eventueel aanwezige flash demo image
docker rmi flask-demo:latest
#
docker build -f /home/$USER/demos/Docker/Dockerfiles/Flask/flask-demo-dkr-file -t flask-demo:latest .
# docker build -f $PWD/flask-demo-dkr-file-V2 -t flask-demo:v100 .
#
#
# Meerdere talen demo 
# docker build -f ./flask-demo-dkr-file-de -t flask-demo-de:v100 .
# docker build -f ./flask-demo-dkr-file-fr -t flask-demo-fr:v100 .
# docker build -f ./flask-demo-dkr-file-it -t flask-demo-it:v100 .
# docker build -f ./flask-demo-dkr-file-nl -t flask-demo-nl:v100 .
# docker build -f ./flask-demo-dkr-file-uk -t flask-demo-uk:v100 .
#
#
echo 'Nieuwe image pushen naar lokale registry'
docker tag flask-demo 127.0.0.1:9105/flask-demo
docker push 127.0.0.1:9105/flask-demo