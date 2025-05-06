::	DEMO Kubernetes Minikube
::	Auteur: John Tutert
::	2023
::
::	Stap 4 / Verwijderen deployment
:: 
@kubectl delete deployment nginx-deployment
::
@kubectl delete service nginx-deployment
:: 
@kubectl describe deployment nginx-deployment
::
:: @minikube service --all