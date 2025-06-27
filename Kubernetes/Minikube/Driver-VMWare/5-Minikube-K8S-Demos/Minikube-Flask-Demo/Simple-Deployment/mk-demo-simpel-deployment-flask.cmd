::
::	https://thenewstack.io/kubernetes-101-deploy-your-first-application-with-microk8s/
::	
::
:: 	Demo Simpele deployment van NGINX
:: 
:: 
:: Eerst minikube-start uitvoeren voordat deze commandfile kan worden uitgevoerd
::
::
minikube ssh "curl -o /home/docker/ubuntu-config-V3-latest.sh https://raw.githubusercontent.com/jatutert/Ubuntu-Config/main/ubuntu-config-V3-latest.sh"
minikube ssh "sudo chmod +x /home/docker/ubuntu-config-V3-latest.sh"
minikube ssh "sudo /home/docker/ubuntu-config-V3-latest.sh minikube"
::
:: Maken Flask Demo Image en hierna uitvoeren 
minikube ssh "/home/docker/docker/flask-demo/flask-image-build.sh"
minikube ssh "/home/docker/docker/flask-demo/flask-demo-run.sh"
:: 
::
::	https://kubernetes.io/docs/reference/kubectl/
::
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
kubectl create deployment flask-demo --image=flask-demo:latest
:: kubectl expose deployment flask-demo --type="NodePort" --port 80
kubectl expose deployment flask-demo --type="NodePort" --port 9010
pause 
::
kubectl describe deployment flask-demo
::	kubectl get services/svc nginx-webserver
kubectl get svc flask-demo
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
