::
::	https://thenewstack.io/kubernetes-101-deploy-your-first-application-with-microk8s/
::	
::
:: 	Demo Simpele deployment van NGINX
:: 
minikube stop
minikube delete
::
minikube start
pause 
::
::	https://kubernetes.io/docs/reference/kubectl/
::
:: kubectl get cluster-info 
kubectl config view
kubectl get nodes 
pause 
kubectl get pods -A
kubectl get deployments -A 
kubectl get services -A
minikube service --all
pause 
::
::	create - Create one or more resources from a file or stdin. 
::
kubectl create deployment nginx-webserver --image=nginx
kubectl expose deployment nginx-webserver --type="NodePort" --port 80
pause 
::
kubectl describe deployment nginx-webserver
::	kubectl get services/svc nginx-webserver
kubectl get svc nginx-webserver
::
pause 
::
minikube service --all
::
pause
::
minikube stop
minikube delete 
::  
