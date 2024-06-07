::
::	DEMO Kubernetes / Minikube
::	Gemaakt door John Tutert
::	2023
::
:: 
::	Stap 1	Deployment NGINX versie 14  
::
:: 
@kubectl apply -f "D:\OneDrive - Saxion\Eigen-Scripts\GIT-jatutert-VagrantFile\k8s-demo\YAML\NGINX"\deployment.yml
@kubectl expose deployment nginx-deployment --type="NodePort" --port 80
@kubectl describe deployment nginx-deployment
@PAUSE
@CLS
@ECHO Overzicht actieve omgeving   
@kubectl get nodes 
@kubectl get services -A
@kubectl get deployments -A 
:: @kubectl get pods -l app=nginx
@kubectl get pods 
@PAUSE
:: 
@minikube service --all 