::
::	Eerst VCTL Start Script uitvoeren !
::
::
kind create cluster --config kind-example-config.yaml
::
::	Default name voor cluster is kind
:: 	@kind create cluster --name demo
@kind get clusters
::
@kind get nodes
::	@kind get nodes --name demo
::
@kubectl get nodes 