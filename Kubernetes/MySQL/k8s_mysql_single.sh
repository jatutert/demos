#! /bin/bash
#
# Kubernetes MicroK8S Minikube demo MySQL 
# mysql-pv is persistant volume
# mysql-deployment is deployment van mysql met gebruik van persistant volume claim 
#
kubectl apply -f $PWD/mysql-pv.yaml
kubectl apply -f $PWD/mysql-deployment.yaml
kubectl describe deployment mysql
kubectl describe pvc mysql-pv-claim
kubectl get pods -l app=mysql
