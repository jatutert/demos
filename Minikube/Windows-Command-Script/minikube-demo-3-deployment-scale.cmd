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
::
::	DEEL 1 =============================================================
::	::	[1]	Updaten Deployment NGINX bijwerken van versie 14 naar versie 16 
::	::
::	::	kubectl apply -f https://k8s.io/examples/application/deployment-update.yaml
::	::
::	kubectl apply -f %HOMEPATH%\minikube-demo\nginx\2-deployment-update\deployment-update.yml 
::	kubectl describe deployment nginx-deployment
::	kubectl get pods -l app=nginx
::
::	DEEL 1 =============================================================
::
::
::	[2] Scaling the application by increasing the replica count (van 2 naar 4 stuks) 
::
kubectl apply -f %HOMEPATH%\minikube-demo\nginx\3-deployment-scale\deployment-scale.yml
kubectl describe deployment nginx-deployment
kubectl get pods -l app=nginx
