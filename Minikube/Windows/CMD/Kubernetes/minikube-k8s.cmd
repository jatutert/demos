::
:: Minikube KUBERNETES / K8S 
:: 
:: https://minikube.sigs.k8s.io/docs/faq/
:: https://minikube.sigs.k8s.io/docs/handbook/config/
:: 
:: Versie 1 | 26 maart 2024
:: Auteur: John Tutert
::
@ECHO OFF
@CLS
::  
:: Stoppen eventueel draaiende omgeving
@minikube stop
::
:: Verwijderen eventueel aanwezige omgeving
@minikube delete
::
:: Minikube starten zonder Kubernetes 
:: @minikube start --no-vtx-check --container-runtime=docker --host-dns-resolver
@minikube start --no-vtx-check --container-runtime=docker
::
@minikube service list
:: 