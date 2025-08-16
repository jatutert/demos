#! /bin/bash
minikube stop
minikube delete
#   Verwijder worker node 
rm -rf /home/$USER/.minikube
