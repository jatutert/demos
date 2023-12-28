:: Opschonen 
minikube stop
minikube delete 
:: Starten 
minikube start 
:: 
::	[0]	Initiele Deployment 
::
::	kubectl apply -f https://k8s.io/examples/application/deployment.yaml
:: 
kubectl apply -f %HOMEPATH%\minikube-demo\nginx\1-deployment\deployment.yml
kubectl describe deployment nginx-deployment
kubectl get pods -l app=nginx
:: 
minikube service --all 