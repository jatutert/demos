:: Download script
vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest "D:\Virtual-Machines\VMware-Workstation-PRO\Linux\Ubuntu\Docker\U24-LTS-S-DKR-001.vmx" "/bin/curl" -L -o /home/ubuntu/luctv4.sh https://edu.nl/treah
:: Script chmod
vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest "D:\Virtual-Machines\VMware-Workstation-PRO\Linux\Ubuntu\Docker\U24-LTS-S-DKR-001.vmx" "/bin/sudo" chmod +x /home/ubuntu/luctv4.sh
:: Voer LUCT uit in de virtuele machine
:: Dit wil niet 
:: vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest "D:\Virtual-Machines\VMware-Workstation-PRO\Linux\Ubuntu\Docker\U24-LTS-S-DKR-001.vmx" -activewindow "/bin/sudo" /home/ubuntu/luctv4.sh docker