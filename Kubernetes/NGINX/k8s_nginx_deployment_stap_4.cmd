::
::  Kubernetes MicroK8S Minikube demo deployment NGINX stap 3
::  Stap 3 is replicatecount van 2 naar 4 bijwerken 
::
echo Stap 4 Verwijderen
::
kubectl delete deployment,svc nginx-deployment
::
kubectl get pods -o wide
kubectl get svc -o wide
::