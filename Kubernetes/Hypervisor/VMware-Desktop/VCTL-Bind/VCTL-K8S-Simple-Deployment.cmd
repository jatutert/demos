::
::
::	Naslag
::
::	https://kind.sigs.k8s.io/docs/user/quick-start/
::
::
kubectl create deployment alpinedemo --image=alpine:latest
kubectl create deployment nginxdemo --image=nginx:latest
::
kubectl expose deployment nginxdemo --type="NodePort" --port 9010
::
kubectl describe deployment alpinedemo
kubectl describe deployment nginxdemo
::
kubectl get svc alpinedemo
kubectl get svc nginxdemo