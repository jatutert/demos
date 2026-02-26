::
::
::  Kubernetes MicroK8S Minikube demo deployment NGINX stap 1
::  Stap 1 is deployment van omgeving met NGINX versie 14
::
echo Stap 1 Deployment NGINX versie 14 gestart ...
::
:: Deployment aanmaken
kubectl apply -f ./1-deployment.yml
::  Deployment verbinden met de buitenwereld via NodePort
kubectl expose deployment nginx-deployment --type=NodePort
::  kubectl expose deployment nginx-deployment --type=NodePort --port=9302 --target-port=80
::
::  Geef detailinformatie over de uitgevoerde deployment
kubectl describe deployment nginx-deployment
kubectl get pods -l app=nginx
::
:: Minikube Container netwerk verbinden met netwerk locale host
minikube service --all
