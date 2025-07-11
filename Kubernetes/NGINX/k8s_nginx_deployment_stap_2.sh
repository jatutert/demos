#! /bin/bash
#
# Kubernetes MicroK8S Minikube demo deployment NGINX stap 2
# Stap 2 is updaten van NGINX van versie 14 naar versie 16
#
echo 'Stap 2 Updaten NGiNX van versie 14 naar versie 16 gestart ...'
#
kubectl apply -f $PWD/deployment-update.yml
kubectl describe deployment nginx-deployment
kubectl get pods -l app=nginx
minikube service --all

