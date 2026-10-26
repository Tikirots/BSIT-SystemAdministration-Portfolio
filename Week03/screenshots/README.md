# Installation screenshot checklist

No installation screenshots have been supplied yet. Capture these on the actual lab VMs and embed them in the relevant guide sections. Combine/split captures as needed, keeping the filenames descriptive.

| Suggested filename | What it must show |
| --- | --- |
| 01-vm-settings.png | Ubuntu VM name, memory, CPUs, 40 GB disk, NAT and firmware |
| 02-language-keyboard.png | English and English (US) keyboard; two images are fine |
| 03-network.png | Installer interface and actual DHCP address |
| 04-storage-summary.png | Actual partition plan and virtual disk before writing |
| 05-profile.png | server01 and virina; keep password hidden |
| 06-ssh-selection.png | OpenSSH Server selected |
| 07-install-complete.png | Completed installation and reboot stage |
| 08-login.png | Successful login and shell prompt |
| 09-hostname.png | hostname returns server01 |
| 10-ip-address.png | ip addr shows the assigned address |
| 11-internet.png | ping -c 4 google.com and its real summary |
| 12-apt-update.png | sudo apt update finishes without unresolved repository errors |
| 13-apt-upgrade.png | sudo apt upgrade -y result; record remaining/deferred updates |
| 14-ssh-status.png | systemctl status ssh after SSH is running |
| 15-storage-firmware.png | lsblk, partition table and boot-mode checks |
| 16-ssh-login.png | Windows PowerShell SSH session to virina@server01 |
| 17-windows-vm.png | Separate Windows Server VM settings |
| 18-windows-installer.png | Chosen evaluation edition and installation stage |
| 19-windows-login.png | Successful Windows Server desktop/login |
| 20-windows-hostname.png | WIN-SERVER01 shown after rename and restart |

Keep passwords and private keys out of all images. Use readable captures with the VM/command context; do not fabricate output. Record only failures and fixes that really occurred.
