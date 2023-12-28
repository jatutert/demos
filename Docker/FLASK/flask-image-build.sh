#! /bin/bash
# default flash demo 
# https://hackmd.io/@pmanzoni/r1uWcTqfU
# docker build -f ./flask-demo-dkr-file -t flask-demo:v100 .
# Meerdere talen demo 
docker build -f ./flask-demo-dkr-file-de -t flask-demo-de:v100 .
docker build -f ./flask-demo-dkr-file-fr -t flask-demo-fr:v100 .
docker build -f ./flask-demo-dkr-file-it -t flask-demo-it:v100 .
docker build -f ./flask-demo-dkr-file-nl -t flask-demo-nl:v100 .
docker build -f ./flask-demo-dkr-file-uk -t flask-demo-uk:v100 .