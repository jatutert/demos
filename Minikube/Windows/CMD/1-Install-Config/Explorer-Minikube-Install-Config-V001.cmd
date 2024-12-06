:: 
::	Minikube on Windows
::
::	Installer
::
::	Date Oktober 28 2024
::
::	Script author John Tutert
::
::
::	START DIT SCRIPT VANUIT WINDOWS VERKENNER EN NIET VANUIT TERMINAL
::
::
::	STEP 1 Administrator Privileges Check
::
@NET SESSION >nul 2>&1
@IF %ERRORLEVEL% EQU 0 (
    @ECHO Administrator PRIVILEGES Detected! 
) ELSE (
    @ECHO Script NIET gestart met Adminstrator rechten ! 
    @PAUSE
    @EXIT 1
)
::
::	STEP 2	Stopping 
::
@minikube stop --all
::
::
::	STEP 3	Remove complete contents of Minikube directory
::
@minikube delete --all --purge
::
::
::	STEP 4	REMOVE Minikube
::
@winget update
@winget uninstall Kubernetes.minikube --nowarn --force
@winget uninstall Kubernetes.kubectl --nowarn --force
::
::	STEP 5	REMOVE DIRECTORIES
::
@rmdir %USERPROFILE%\.minikube /S /Q
@rmdir %MINIKUBE_HOME%\.minikube /S /Q
@rmdir %MINIKUBE_HOME%\Minikube /S /Q
::
@rmdir %USERPROFILE%\.kube /S /Q
::
::	STEP 6	INSTALL MiniKube
::
@winget update
@winget install --id Kubernetes.minikube --accept-package-agreements --accept-source-agreements 
@winget install --id Kubernetes.kubectl --accept-package-agreements --accept-source-agreements 
::
::	STEP 7	Set Environment
::
Setx /M MINIKUBE_IN_STYLE "false"
Setx /M MINIKUBE_HOME "D:\Virtual-Machines\VMware-Workstation-PRO\Linux\Minikube"
::
::	STEP 7	Configure Minikube
::
@minikube config set memory 8192
@minikube config set cpus 4 
::	@minikube config set driver virtualbox 
@minikube config set driver vmware 
@minikube config set WantUpdateNotification true
@minikube config set WantBetaUpdateNotification true
@minikube config set WantVirtualBoxDriverWarning false
@minikube config view
::
exit