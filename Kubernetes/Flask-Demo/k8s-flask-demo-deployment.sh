#! /bin/bash
#
# Kubernetes MicroK8S Minikube demo MySQL 
# mysql-pv is persistant volume
# mysql-deployment is deployment van mysql met gebruik van persistant volume claim 
#
kubectl apply -f $PWD/Flask-demo-deployment
kubectl describe flask-demo
kubectl get pods -l app=flask-demo
