#! /bin/bash
#
# Kubernetes MicroK8S Minikube demo deployment NGINX stap 1
# Stap 1 is deployment van omgeving met NGINX versie 14
#
echo 'Stap 1 Deployment NGINX versie 14 gestart ...'
#
kubectl apply -f $PWD/1-deployment.yml
kubectl expose deployment nginx-deployment --type=NodePort --port=9302
kubectl describe deployment nginx-deployment
kubectl get pods -l app=nginx
minikube service --all
