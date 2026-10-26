# ProfessionalInstallationManual

## Professional Installation Manual

### Ubuntu Server Deployment Runbook

Jaymark Viriña | BSIT
ITEP 414 - System Administration and Maintenance
Week 3 | 26 October 2026

Lab preparation copy - installation and screenshot evidence still pending

### Scope

A repeatable classroom procedure for Ubuntu-Server-Week03: installation, initial configuration, verification, remote access, troubleshooting and handover.

### Read with

InstallationGuide.pdf contains the complete assignment guide, Windows Server instructions and OS comparison. BIOS_vs_UEFI.pdf explains the firmware comparison. BootProcessFlowchart.pdf shows the required eight boot stages. START_HERE_Taglish.md explains the work in simpler terms.

## Table of contents

| Section | Page |
| --- | --- |
| Introduction and deployment record | 3 |
| Ubuntu installation runbook | 4 |
| Initial server configuration | 5 |
| Server verification and acceptance | 6 |
| Remote administration from Windows | 7 |
| Troubleshooting and recovery | 8 |
| Best practices and handover | 9 |
| Selected references | 10 |

Page numbers refer to this PDF. The command blocks are intended to be typed in the installed VM unless they are labeled as Windows host commands.

## Introduction and deployment record

Purpose: repeat a clean Ubuntu Server installation in VirtualBox, verify the baseline and hand it over with evidence. This manual is a runbook, not a completed deployment log. Use Lab_Results.md for observed values and InstallationGuide.pdf for the Windows activity and comparison reports.

| Item | Target |
| --- | --- |
| VM name | Ubuntu-Server-Week03 |
| Operating system | Ubuntu Server 26.04.1 LTS, amd64 / 64-bit [1] |
| Memory | 4096 MB (4 GB) |
| Processors | 2 virtual CPUs |
| Disk | 40 GB dynamically allocated VDI |
| Networking | Adapter 1: NAT; cable connected; DHCP |
| Firmware | UEFI enabled before installation; record actual mode |
| Hostname / user | server01 / virina (non-root administrative account) |

### Pre-installation check

- Record host capacity and software/ISO versions.

- Verify the ISO checksum against the official release checksum.

- Use a new virtual disk; keep Ubuntu and Windows disks separate.

- Set the firmware mode before installing; leave it unchanged afterward.

- Create private passwords locally and keep them out of screenshots.

## Ubuntu installation runbook

| Order | Action | Completion check |
| --- | --- | --- |
| 1 | Create the VM; skip unattended setup. | 4096 MB RAM, 2 CPUs, 40 GB VDI, NAT and UEFI. |
| 2 | Boot Ubuntu Server ISO. | English; English (US) keyboard. |
| 3 | Keep DHCP; no proxy unless required. | Installer gets an address; mirror check works. |
| 4 | Guided entire virtual disk; no LVM in this baseline. | Review real partitions before confirming. |
| 5 | Set profile and server name. | Jaymark Viriña; server01; username virina. |
| 6 | Install OpenSSH Server. | SSH checkbox selected; no optional featured snaps. |
| 7 | Finish, reboot and eject ISO if prompted. | Installed disk boots to login prompt. |
| 8 | Log in as virina. | Interactive shell opens; save screenshot. |

### Storage note

The guided installer decides exact partition sizes. Capture its summary and check lsblk and fdisk afterward. Do not claim an EFI/FAT32 or ext4 layout until it is observed. If the instructor chooses LVM or a different firmware mode, record that variation rather than forcing this example. [2,3]

### Screenshot checkpoints

Capture setup, keyboard, DHCP, storage, profile, OpenSSH selection, completion and login. Use screenshots/README.md for filenames. Never interrupt a working installation only to repeat a screenshot.

## Initial server configuration

### Confirm the account and name

```text
whoami
hostname
hostnamectl
id
```

Expected user: virina. Expected hostname: server01. If the name is wrong, use sudo hostnamectl set-hostname server01 and check any matching old entry in /etc/hosts; then log in again.

### Record storage, network and boot mode

```text
cat /etc/os-release
ip -brief addr
ip route
lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINTS
```

```text
if [ -d /sys/firmware/efi ]; then echo UEFI; else echo BIOS; fi
```

### Update the installed system

```text
sudo apt update
sudo apt upgrade -y
```

Run sudo apt update, then sudo apt upgrade -y. The first refreshes package indexes; the second installs available upgrades without asking for routine yes/no confirmation. Wait for each to finish and read errors. If /var/run/reboot-required exists, reboot with sudo reboot and repeat the hostname, network and SSH checks. Do not run a release upgrade for this exercise. Record deferred/phased packages separately rather than claiming that every package was upgraded. [6]

Do not install database, web or file-sharing packages in this clean OS exercise. A production deployment would add those only after separate planning and approval.

## Server verification and acceptance

| Required check | Command | Accept when |
| --- | --- | --- |
| Login | whoami | virina after a successful console login |
| Hostname | hostname | server01 |
| IP address | ip addr | Non-loopback interface has a DHCP address |
| Connectivity | ping -c 4 google.com | Successful replies; record actual packet loss |
| Package index | sudo apt update | Repositories reached; no unresolved errors |
| Upgrades | sudo apt upgrade -y | Command completes; record any deferred packages |
| SSH service | systemctl status ssh | active (running) after starting/triggering SSH |

### SSH service nuance

Recent Ubuntu installations may use ssh.socket activation. Inspect systemctl status ssh ssh.socket --no-pager. If the daemon is idle, trigger a real connection or run sudo systemctl start ssh, then capture active (running). Check listening sockets and complete the host login test; do not treat an idle socket-activated service as automatic failure.

### Optional evidence helper

scripts/verify-server.sh can collect timestamped local observations after installation. It does not install packages, run upgrades or create successful results. Run it in the Ubuntu VM with bash, review the output and keep the required screenshots. Copying the script into the VM can be done through an already verified SSH session.

```text
bash verify-server.sh
```

Acceptance remains pending until real outputs and screenshots are added. Reboot after updates if needed, then repeat critical checks.

## Remote administration from Windows

| VirtualBox NAT rule | Value |
| --- | --- |
| Name | ssh |
| Protocol | TCP |
| Host IP / port | 127.0.0.1 / 2222 |
| Guest IP / port | Leave Guest IP blank / 22 |

Power off the Ubuntu VM cleanly. In its VirtualBox Network settings, open Adapter 1 / NAT / Port Forwarding. Add the rule below. Binding the host side to 127.0.0.1 limits it to this host.

Start Ubuntu, log in and run systemctl status ssh. If the service is inactive but ssh.socket is listening, make an SSH connection or run sudo systemctl start ssh, then check again. Use sudo sshd -t to test configuration if a service will not start. [5]

On Windows, open PowerShell and run ssh -p 2222 virina@127.0.0.1. On the guest console, sudo ssh-keygen -lf /etc/ssh/ssh_host_ed25519_key.pub shows the public host-key fingerprint. Compare it with the first-connection prompt before trusting the host.

Enter the guest account password privately. Run whoami and hostname in the remote session, capture the successful session and type exit to disconnect. A service status check alone does not prove remote login works. For production, set up key authentication and test it before disabling passwords.

```text
ssh -p 2222 virina@127.0.0.1
```

### If OpenSSH was missed during installation

```text
sudo apt install openssh-server
sudo sshd -t
sudo systemctl start ssh
systemctl status ssh --no-pager
```

With an existing UFW policy, permit SSH only from the intended lab path before testing; do not disable the firewall as a shortcut. This guide does not enable or change UFW automatically.

## Troubleshooting and recovery

| Symptom | Diagnostic check | Action |
| --- | --- | --- |
| 64-bit guest unavailable or VM will not start | Check host CPU virtualization and available memory. Confirm a supported VirtualBox/host combination. | Record the actual error first. Enable VT-x/AMD-V only if needed; ask for help before changing other host security settings. |
| Installer starts again after reboot | The ISO is still first in the boot order. | Eject the ISO from the virtual optical drive, retain the VDI and boot the installed disk. |
| No guest address | Check Adapter 1 NAT, Cable Connected, ip -brief addr and ip route. | Reconnect the virtual cable or correct the VM adapter, then obtain a DHCP lease again. |
| Address works but google.com fails | Run getent hosts google.com and check resolvectl status if available. | Fix the DNS path. If ICMP is filtered, document that separately; do not label ping as successful. |
| SSH connection refused | Check systemctl status ssh and ssh.socket; check sudo ss -ltnp. | Install openssh-server if missing, validate with sudo sshd -t and start the service. Recheck NAT rule and port. |
| SSH times out from Windows | Check host port 2222 and the loopback-only forwarding rule. | Use 127.0.0.1 on the host, not an assumed NAT guest IP. Change host port if already used. |
| APT lock or download error | Check whether unattended updates are running and read the exact error. | Let the active updater finish. Fix networking/mirror problems and retry; do not delete lock files while a package manager runs. |
| Hostname remains wrong | Compare hostname, hostnamectl and /etc/hostname. | Run sudo hostnamectl set-hostname server01; review any old hostname entry in /etc/hosts and log in again. |

Use the VM console if networking is broken. Save the actual error and retest after a change. Do not overwrite a working VM simply to make it match a sample screenshot.

## Best practices and handover

### Keep the baseline small

Use a non-root administrator, supported packages and only the services needed by the activity. Keep the VM on NAT for the classroom baseline and expose SSH only through the loopback forwarding rule. Use SSH keys for later production work and verify a second key-based login before restricting existing access.

### Record and recover

Document ISO/build, firmware, VM resources, hostname, account name, interface, address, filesystem and partitions. Take a clean-baseline snapshot after successful verification. A snapshot helps undo a lab change but is not an independent backup; keep important work separately.

### Handover acceptance checklist

- A second administrator can boot the installed disk and log in.

- hostname returns server01 and the VM has a recorded working address.

- Connectivity, updates and a host-to-guest SSH login have real evidence.

- The storage layout and firmware mode are documented.

- Any failures have a cause, fix and successful retest recorded.

- No passwords, private keys, ISO files or VDI/VMDK images are committed.

### Current handover status

Runbook prepared. Ubuntu and Windows installations, screenshot capture, measured configuration and acceptance tests still need to be completed on the lab host. Do not mark these items complete based only on this manual.

## Selected references

**[1] Canonical. Ubuntu Server download.** [https://ubuntu.com/download/server](https://ubuntu.com/download/server). Current LTS download: Ubuntu Server 26.04.1 LTS, amd64.

**[2] Canonical. Basic installation.** [https://ubuntu.com/server/docs/tutorial/basic-installation/](https://ubuntu.com/server/docs/tutorial/basic-installation/). Installation preparation and official server documentation.

**[3] Canonical. Subiquity screen-by-screen installer walk-through.** [https://canonical-subiquity.readthedocs-hosted.com/en/latest/tutorial/screen-by-screen.html](https://canonical-subiquity.readthedocs-hosted.com/en/latest/tutorial/screen-by-screen.html). Installer screens, storage, profile and SSH options.

**[4] Oracle. VirtualBox User Guide, Release 7.2.** [https://docs.oracle.com/en/virtualization/virtualbox/7.2/user/EN-VBOX-7-2-USER.pdf](https://docs.oracle.com/en/virtualization/virtualbox/7.2/user/EN-VBOX-7-2-USER.pdf). VM creation, EFI, networking and NAT forwarding.

**[5] Canonical. OpenSSH server.** [https://ubuntu.com/server/docs/how-to/security/openssh-server/](https://ubuntu.com/server/docs/how-to/security/openssh-server/). SSH installation, configuration and validation.

**[6] Canonical. Install and manage packages.** [https://ubuntu.com/server/docs/how-to/software/package-management/](https://ubuntu.com/server/docs/how-to/software/package-management/). APT package installation and updates.

**[10] GNU Project. GNU GRUB Manual.** [https://www.gnu.org/software/grub/manual/grub/grub.html](https://www.gnu.org/software/grub/manual/grub/grub.html). Bootloader, Linux kernel and initial RAM disk.

**[11] systemd project. bootup.** [https://www.freedesktop.org/software/systemd/man/bootup.html](https://www.freedesktop.org/software/systemd/man/bootup.html). System manager, services and boot targets.
