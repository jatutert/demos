# Kubernetes MicroK8S Minikube demo MySQL 
    # mysql-pv is persistant volume
    # mysql-deployment is deployment van mysql met gebruik van persistant volume claim 
    echo '#! /bin/bash'> /home/$SUDO_USER/demos/kubernetes/applicaties/mysql/k8s_mysql_single.sh
    echo 'cd /home/$USER' >> /home/$SUDO_USER/demos/kubernetes/applicaties/mysql/k8s_mysql_single.sh
    echo 'clear' >> /home/$SUDO_USER/demos/kubernetes/applicaties/mysql/k8s_mysql_single.sh
    echo 'kubectl apply -f /home/$USER/yaml/kubernetes/mysql/mysql-pv.yaml' >> /home/$SUDO_USER/demos/kubernetes/applicaties/mysql/k8s_mysql_single.sh
    echo 'kubectl apply -f /home/$USER/yaml/kubernetes/mysql/mysql-deployment.yaml' >> /home/$SUDO_USER/demos/kubernetes/applicaties/mysql/k8s_mysql_single.sh
    echo 'kubectl describe deployment mysql' >> /home/$SUDO_USER/demos/kubernetes/applicaties/mysql/k8s_mysql_single.sh
    echo 'kubectl describe pvc mysql-pv-claim' >> /home/$SUDO_USER/demos/kubernetes/applicaties/mysql/k8s_mysql_single.sh
    echo 'kubectl get pods -l app=mysql' >> /home/$SUDO_USER/demos/kubernetes/applicaties/mysql/k8s_mysql_single.sh
    chmod +x /home/$SUDO_USER/demos/kubernetes/applicaties/mysql/k8s_mysql_single.sh