::
::	DEEL 0 =============================================================
::
::	:: Opschonen 
::	minikube stop
::	minikube delete 
::	:: Starten 
::	minikube start 
::	:: 
::	::	[0]	Initiele Deployment 
::	::
::	::	kubectl apply -f https://k8s.io/examples/application/deployment.yaml
::	:: 
::	kubectl apply -f %HOMEPATH%\minikube-demo\nginx\1-deployment\deployment.yml
::	kubectl describe deployment nginx-deployment
::	kubectl get pods -l app=nginx
::	:: 
::
::	DEEL 0 =============================================================
:: 
::	[1]	Updaten Deployment NGINX bijwerken van versie 14 naar versie 16 
::
::	kubectl apply -f https://k8s.io/examples/application/deployment-update.yaml
::
@ECHO Updaten Deployment NGINIX van versie 14 naar versie 16 gestart ...
kubectl apply -f %HOMEPATH%\minikube-demo\nginx\2-deployment-update\deployment-update.yml 
kubectl describe deployment nginx-deployment
kubectl get pods -l app=nginx
