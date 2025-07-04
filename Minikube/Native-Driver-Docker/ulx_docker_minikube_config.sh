ram=\$(free --mega | grep 'Mem' | awk '{print \$7/4}')
minikube config set memory \$ram
#
cpu_aantal=\$(nproc)
minikube config set cpus \$cpu_aantal
#
minikube config set driver docker
#
minikube config view