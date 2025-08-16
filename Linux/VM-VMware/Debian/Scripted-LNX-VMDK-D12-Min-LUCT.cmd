:: Download script
vmrun -T ws -gu debian -gp debian runProgramInGuest "D:\Virtual-Machines\VMware-Workstation-PRO\Linux\Debian\OMV\D12-BKW-M-DEMO-001.vmx" "/bin/wget" -O /home/debian/luctv41.sh https://edu.nl/n7faw
:: Script chmod
vmrun -T ws -gu debian -gp debian runProgramInGuest "D:\Virtual-Machines\VMware-Workstation-PRO\Linux\Debian\OMV\D12-BKW-M-DEMO-001.vmx" "/bin/sudo" chmod +x /home/debian/luctv41.sh
:: Voer LUCT uit in de virtuele machine
:: Dit wil niet 
:: vmrun -T ws -gu ubuntu -gp ubuntu runProgramInGuest "D:\Virtual-Machines\VMware-Workstation-PRO\Linux\Ubuntu\Docker\U24-LTS-S-DKR-001.vmx" -activewindow "/bin/sudo" /home/ubuntu/luctv4.sh docker