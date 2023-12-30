::
::	https://kubernetes.io/docs/tasks/run-application/run-single-instance-stateful-application/
::
minikube stop
minikube delete
::
minikube start
::
kubectl get nodes --show-labels
pause
::
kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/main/content/en/examples/application/mysql/mysql-pv.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/website/main/content/en/examples/application/mysql/mysql-deployment.yaml
pause
::
cls 
kubectl describe deployment mysql
kubectl get pods -l app=mysql
kubectl describe pvc mysql-pv-claim
pause
:: 
:: This command creates a new Pod in the cluster running a MySQL client and connects it to the server through the Service. If it connects, you know your stateful MySQL database is up and running.
::
kubectl run -it --rm --image=mysql:5.6 --restart=Never mysql-client -- mysql -h mysql -ppassword
::
kubectl delete deployment,svc mysql
kubectl delete pvc mysql-pv-claim
kubectl delete pv mysql-pv-volume
kubectl describe deployment mysql
kubectl describe pvc mysql-pv-claim
::
minikube stop
minikube delete
minikube status 