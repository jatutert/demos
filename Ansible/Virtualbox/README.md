# Ansible DEMO using Oracle VM VirtualBox

Script for running virtual machines within Oracle VM VirtualBox for Ansible Demo. 

Download script from the folder Windows and run it within the Windows Terminal (CMD.EXE).

Script installs cURL, Oracle VM VirtualBOX en cygWIN if not present. After that it downloads virtual machine image and extracts this image. Three virtual machines are automatically created within Oracle VM VirtualBox (no user actions or input needed). 

Virtual machines:
- Ansible Controller
- Ansible Host 010 (controlled by the Ansible Controller) 
- Ansible Host 011 (controlled by the Ansible Controller)

On the Host 010 Docker Community Edition (CE) is installed by the Playbook located on the Ansible Controller. 

The Ansible Playbook is located at the /home/ubuntu/playbooks directory. 
When created the virtual machine it is downloaded from this GitHub Repository. 

Username / Password for the virtual machines: Ubuntu/Ubuntu 

The virtual machines images are downloaded from https://www.linuxvmimages.com/
The image used is Ubuntu (server) 22.04 LTS. 