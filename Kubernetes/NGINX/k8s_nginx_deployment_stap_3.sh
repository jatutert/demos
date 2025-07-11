#! /bin/bash
#
# Kubernetes MicroK8S Minikube demo deployment NGINX stap 3
# Stap 3 is replicatecount van 2 naar 4 bijwerken 
#
echo 'Stap 3 Aanpassen aantal replicas van 2 naar 4 gestart ...'
#
kubectl apply -f $PWD/deployment-scale.yaml
kubectl describe deployment nginx-deployment
kubectl get pods -l app=nginx
minikube service --all

