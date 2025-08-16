#! /bin/bash
#
kubectl create deployment nginx-webserver --image=nginx
kubectl expose deployment nginx-webserver --type="NodePort" --port 9301
kubectl describe deployment nginx-webserver
kubectl get svc nginx-webserver
minikube service --all
