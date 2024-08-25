::	DEMO Kubernetes Minikube
::	Auteur: John Tutert
::	2023
::
::	Stap 5 // Opschonen
::
@ECHO OFF
@CLS
@ECHO Stoppen eventueel actieve minikube 
@minikube stop
@ECHO Verwijderen eventueel aanwezige minikube virtuele machine 
minikube delete
:: 