# InstallationGuide

## Enterprise Server Deployment

### Installation Guide

Jaymark Viriña | BSIT
ITEP 414 - System Administration and Maintenance
Week 3 | 26 October 2026

Lab preparation copy - installation and screenshot evidence still pending

### Project overview

This guide prepares a first Linux server for the startup scenario. It covers the VM, Ubuntu installation, initial checks and an SSH connection from Windows. A separate Windows Server evaluation VM supports the operating-system comparison. File sharing, databases and web hosting are future workloads; they are not installed in this activity.

### Objectives

- Install Ubuntu Server using the required lab settings.

- Configure server01, a non-root administrator, DHCP and OpenSSH.

- Record evidence for login, networking, updates and SSH.

- Explain firmware, the Ubuntu boot sequence and OS choices.

### How to use this copy

Follow the steps on your own host and add real screenshots to screenshots/. Record measured settings and outcomes in Lab_Results.md. The expected results in this guide are acceptance criteria, not test output. Problems Encountered and Solutions Implemented remain open until the lab is run. Use START_HERE_Taglish.md for a simpler explanation.

## Software and VM specifications

Use VirtualBox on the Windows host, the Ubuntu Server LTS amd64 ISO and a separate Windows Server Evaluation ISO. Internet access is needed for downloads, repository updates and evaluation activation. Download from official sources listed in references/Sources.md. [1,4,12,20]

| Setting | Target for this lab |
| --- | --- |
| VM name | Ubuntu-Server-Week03 |
| Operating system | Ubuntu Server 26.04.1 LTS, amd64 / 64-bit [1] |
| Memory | 4096 MB (4 GB) |
| Processors | 2 virtual CPUs |
| Disk | 40 GB dynamically allocated VDI |
| Networking | Adapter 1: NAT; cable connected; DHCP |
| Firmware | UEFI enabled before installation; record actual mode |
| Hostname / user | server01 / virina (non-root administrative account) |
| Keyboard / storage | English (US); guided entire virtual disk; no LVM for this guide |
| SSH / extra packages | Install OpenSSH Server; leave optional server snaps unselected |

The assigned minimum is 4 GB RAM, 2 CPUs and a 40 GB disk for Ubuntu. Check host resources first. The VM firmware setting is separate from the physical PC firmware. The lab is not a production deployment of the Week 2 inventory.

## Ubuntu installation: preparation to networking

### 1. Prepare the host and ISO

Install VirtualBox from Oracle on the Windows host. Download the Ubuntu Server LTS amd64 ISO from Canonical, not the Desktop ISO. This guide uses 26.04.1 LTS as listed on 26 October 2026. Save the ISO filename and checksum in Lab_Results.md. In PowerShell, Get-FileHash -Algorithm SHA256 "C:\path\ubuntu-server.iso" calculates the hash; compare it with the matching official SHA256SUMS file. Leave enough free memory and disk space for the host; run the two server VMs one at a time on a limited laptop. [1,2,4,20]

Evidence: record host RAM, CPU, VirtualBox version and ISO filename before starting.

### 2. Create the Ubuntu virtual machine

In VirtualBox, choose New, enter Ubuntu-Server-Week03 and select the downloaded ISO. Select Ubuntu (64-bit) if detection does not fill it in. Skip or disable unattended installation so you can follow and document the installer. Assign 4096 MB RAM, 2 processors and a new 40 GB dynamically allocated VDI. Enable EFI/UEFI before the first boot. Under Network, leave Adapter 1 on NAT and confirm Cable Connected. Menu labels vary slightly by VirtualBox release. [4]

Screenshot 01-vm-settings.png: show name, memory, CPUs, disk and network settings; use more than one image if needed.

### 3. Start the installer

Start the VM and choose the Ubuntu Server install entry. Select English and the English (US) keyboard layout. Use Tab and arrow keys to move, Space to select a checkbox, and Enter to continue. Accept a normal Ubuntu Server installation; do not choose a desktop installation. If offered an installer update, allow it when the network is working or record the version used.

Screenshot 02-language-keyboard.png: capture the language and keyboard choices.

### 4. Configure the network

Keep DHCP on the detected Ethernet interface. Note the interface name and address shown; do not copy an address from a sample. Leave the proxy blank unless your network requires one and use the default Ubuntu mirror if its check succeeds. NAT lets the guest reach the internet through the host. It does not make guest SSH automatically reachable from the host.

Screenshot 03-network.png: show the assigned interface and IP address.

## Ubuntu installation: disk to first login

### 5. Review the virtual disk

Choose Guided / Use an entire disk and select the new 40 GB virtual disk. For a simple reproducible layout, turn off the optional LVM setting and leave encryption off for this classroom baseline. Let the installer create the partitions. Under UEFI, expect an EFI System Partition, normally FAT32/vfat, and an ext4 root filesystem; verify the actual layout later. Check that this is the disposable VM disk before confirming the write. Record sizes from the real summary instead of assuming fixed partition sizes. [3]

Screenshot 04-storage-summary.png: capture the partition table before confirming the installation.

### 6. Set the server identity

Use Jaymark Viriña as the full name, server01 as the server name and virina as the username. Create a strong unique password and keep it private. This is a normal account with sudo administration rights, rather than direct root login. Skip an optional Ubuntu Pro subscription for this lab unless your instructor asks for it.

Screenshot 05-profile.png: show the hostname and username without showing a password.

### 7. Enable SSH and finish installation

Select Install OpenSSH Server. If you have not set up SSH keys, keep password login available for this isolated lab so the first SSH test can work; do not select an imported key you do not control. Leave optional featured server snaps unselected. Wait for installation to finish, choose Reboot and remove the ISO from the VM optical drive if prompted. Keep the installed virtual disk attached.

Screenshots 06-ssh-selection.png and 07-install-complete.png: show OpenSSH selected and completion/reboot.

### 8. Log in and verify

At the console, log in as virina. Password characters are not displayed while typing; that is normal. Run the commands in the verification section, save the real results and take the required screenshots. The login prompt and hostname should identify server01. If settings differ from this guide, document the difference in Lab_Results.md.

Screenshot 08-login.png: capture a successful shell prompt after login.

## Initial configuration and verification

Run each required command in the installed Ubuntu VM. Record the real output, date and evidence filename. All results currently await execution.

| Check | Command | Expected result | Evidence |
| --- | --- | --- | --- |
| Login | whoami | virina after a successful console login | 08-login.png |
| Hostname | hostname | server01 | 09-hostname.png |
| IP address | ip addr | Non-loopback interface has a DHCP address | 10-ip-address.png |
| Connectivity | ping -c 4 google.com | Successful replies; record actual packet loss | 11-internet.png |
| Package index | sudo apt update | Repositories reached; no unresolved errors | 12-apt-update.png |
| Upgrades | sudo apt upgrade -y | Command completes; record any deferred packages | 13-apt-upgrade.png |
| SSH service | systemctl status ssh | active (running) after starting/triggering SSH | 14-ssh-status.png |

### Updates and reboot

Run sudo apt update, then sudo apt upgrade -y. The first refreshes package indexes; the second installs available upgrades without asking for routine yes/no confirmation. Wait for each to finish and read errors. If /var/run/reboot-required exists, reboot with sudo reboot and repeat the hostname, network and SSH checks. Do not run a release upgrade for this exercise. Record deferred/phased packages separately rather than claiming that every package was upgraded. [6]

### Record the installed storage and firmware

```text
lsblk -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINTS
sudo fdisk -l
if [ -d /sys/firmware/efi ]; then echo UEFI; else echo BIOS; fi
```

Press q to leave systemctl status. Use ip -brief addr and ip route for shorter network views. Actual interface names, disk names, partition sizes and addresses must come from your VM.

## SSH from the Windows host

Use NAT with a loopback-only port forward for this local lab. Directly connecting to an assumed NAT address from Windows may fail even when Ubuntu can access the internet. [4]

| Port forwarding field | Value |
| --- | --- |
| Name | ssh |
| Protocol | TCP |
| Host IP / port | 127.0.0.1 / 2222 |
| Guest IP / port | Leave Guest IP blank / 22 |

### Step 1

Power off the Ubuntu VM cleanly. In its VirtualBox Network settings, open Adapter 1 / NAT / Port Forwarding. Add the rule below. Binding the host side to 127.0.0.1 limits it to this host.

### Step 2

Start Ubuntu, log in and run systemctl status ssh. If the service is inactive but ssh.socket is listening, make an SSH connection or run sudo systemctl start ssh, then check again. Use sudo sshd -t to test configuration if a service will not start. [5]

### Step 3

On Windows, open PowerShell and run ssh -p 2222 virina@127.0.0.1. On the guest console, sudo ssh-keygen -lf /etc/ssh/ssh_host_ed25519_key.pub shows the public host-key fingerprint. Compare it with the first-connection prompt before trusting the host.

### Step 4

Enter the guest account password privately. Run whoami and hostname in the remote session, capture the successful session and type exit to disconnect. A service status check alone does not prove remote login works. For production, set up key authentication and test it before disabling passwords.

```text
ssh -p 2222 virina@127.0.0.1
```

Save 16-ssh-login.png only after a real remote login. Never upload passwords, private SSH keys or an installer file containing credentials.

## Windows Server installation

Bring-home activity: use a new VM and a separate virtual disk. The required outcomes are a completed install, assigned computer name, Administrator password and successful login.

### Step 1

Download the Windows Server 2025 Evaluation ISO from Microsoft. Create a separate VM named Windows-Server-Week03; do not reuse the Ubuntu disk. Suggested lab allocation: 4 GB RAM, 2 CPUs, an 80 GB dynamically allocated VDI and NAT. Use UEFI and check the official CPU/firmware requirements for the selected build. This allocation is a lab recommendation, not a claim about minimum requirements. [12,14]

### Step 2

Attach the ISO and skip unattended setup. Boot it, choose the language and keyboard, and select the evaluation installation path. Choose Windows Server 2025 Standard Evaluation (Desktop Experience) when that image is offered. The option without Desktop Experience installs Server Core.

### Step 3

Read and accept the terms yourself. Select only the empty Windows VM disk and allow Setup to create its partitions. Proceed with the clean installation; the wording of the disk-selection screens can vary by media build. Keep the Ubuntu VDI separate. [13]

### Step 4

Wait through the restarts without starting the installer again. Set a unique Administrator password privately. Use VirtualBox Input / Keyboard / Insert Ctrl+Alt+Del when needed, then sign in to the guest. Capture the working desktop and selected OS edition; never include a password in a screenshot.

Evidence: 17-windows-vm.png, 18-windows-installer.png and 19-windows-login.png. Evaluation media is for assessment; review production licensing separately.

## Windows configuration and installation summary

Open PowerShell as Administrator inside the Windows VM. Run Rename-Computer -NewName "WIN-SERVER01" -Restart, then log in again. Confirm the name with hostname and review the OS information with Get-ComputerInfo. Capture the actual result. Use Windows Update and follow Microsoft's evaluation activation guidance; the trial lasts 180 days and requires internet activation within the first 10 days. No Windows installation or activation is claimed until these checks are performed. [12]

```text
Rename-Computer -NewName "WIN-SERVER01" -Restart
```

```text
hostname
Get-ComputerInfo | Select-Object WindowsProductName,OsVersion,OsArchitecture
```

| Summary item | Target / current record |
| --- | --- |
| VM | Windows-Server-Week03; actual creation pending |
| Image | Windows Server 2025 Standard Evaluation, Desktop Experience |
| Computer name | WIN-SERVER01; verification pending |
| Administrator account | Password to be set privately; never recorded in the repo |
| Login / updates / activation | Not yet tested |
| Screenshot evidence | Not yet supplied |

### What remains to document

Record the ISO filename, installed edition/build, VM memory, CPU, disk size, actual computer name and install date in Lab_Results.md. Describe any installation error and the fix that actually worked. Do not replace missing evidence with a stock screenshot.

## BIOS and UEFI comparison

| Topic | Legacy BIOS | UEFI |
| --- | --- | --- |
| Definition | Legacy PC firmware interface rooted in older x86 designs. | Modern firmware interface specification with a modular pre-OS environment. |
| Boot process | Usually reads boot code from the selected disk, then passes control to a loader. | Uses boot entries to load an EFI application, often from the EFI System Partition. |
| Maximum disk support | Common MBR layout: about 2 TiB with 512-byte logical sectors. This is an MBR limit, not an absolute BIOS disk limit. | Usually paired with GPT, which handles disks much larger than 2 TiB; actual OS and device limits still apply. |
| Partition style | Usually MBR. GRUB can also boot a GPT disk in BIOS mode with suitable setup. | Usually GPT. UEFI itself can support MBR; Windows UEFI system disks require GPT. |
| Security features | No UEFI Secure Boot mechanism; protections depend on the platform. | Can verify trusted boot components with Secure Boot when supported and enabled. |
| Speed | Legacy paths can add overhead, but boot time varies. | Can streamline startup; firmware, storage, services and settings determine actual time. |
| Advantages | Useful for older operating systems, hardware and legacy tools. | Modern boot entries, GPT support and optional trusted boot verification. |
| Disadvantages | Older boot conventions and fewer modern firmware security features. | Firmware and key management add complexity; old tools may not work. |
| Modern usage | Older PCs and compatibility environments. | Normal choice for current PCs, servers and modern virtual machines. |

Sources [7-9]. Firmware mode and partition style are related but distinct. Secure Boot availability does not mean it is enabled.

The complete one-page explanation is in BIOS_vs_UEFI.pdf. For this VM, set UEFI before installation and confirm the running mode with the firmware check on page 5. Keep that setting unchanged after installation unless you are deliberately rebuilding the boot environment.

## Ubuntu boot process

![Ubuntu boot process](diagrams/BootProcessFlowchart.png)

Firmware hands control to GRUB, which loads Linux and its initial RAM filesystem. systemd then brings up configured userspace services. Login availability and a healthy SSH service still need to be verified. The graph shows the logical sequence rather than exact timing. [10,11]

## Windows, Ubuntu and Rocky Linux

Research comparison: Windows Server 2025, Ubuntu Server 26.04 LTS and Rocky Linux 10. The Rocky installation is not part of the required lab. No performance benchmark is claimed.

| Area | Windows Server | Ubuntu Server | Rocky Linux |
| --- | --- | --- | --- |
| Licensing | Commercial licensing; Evaluation is time-limited, not a production license. | Open-source distribution; no OS purchase fee; optional paid support. | Open-source enterprise distribution; no OS purchase fee; support arrangements vary. |
| User interface | Desktop Experience GUI or Server Core; PowerShell and remote tools. | Server console and SSH by default; optional GUI is unnecessary for this lab. | Server console/SSH; graphical installation choices are available. |
| Package management | Windows Update, DISM, PowerShell roles/features; WinGet is available in 2025. | APT/dpkg for deb packages; other package formats can be used when needed. | DNF/RPM with enterprise repositories. |
| Security | Defender, Windows Firewall, policy and identity integration. | AppArmor, sudo, SSH, firewall controls and security updates. | SELinux enforcing policies, sudo, SSH, firewalld and updates. |
| Performance | GUI and server roles affect resource use; Server Core reduces GUI overhead. | A minimal install suits headless services; measure the actual application. | A minimal install suits long-running services; test the same workload fairly. |
| Enterprise use | AD DS, Windows file services, Microsoft applications and Hyper-V. | Web/API servers, databases, containers, cloud VMs and development tools. | Enterprise Linux applications, web/database services and RHEL-family environments. |
| Advantages | Familiar GUI option and integration with Windows-based organizations. | Large documentation ecosystem, APT workflow and cloud tooling. | Stable enterprise focus and familiarity for RPM/SELinux administrators. |
| Disadvantages | License costs and edition/access-license planning; GUI can use more resources. | Windows-only roles may require another platform; Linux skills are needed. | Package versions and hardware support need checking; major upgrades need planning. |

Sources [1,6,12,15-19]. Licensing and support must be checked for the chosen edition and workload. See the next page for the discussion.

## Operating system comparison: discussion

An operating system should be selected for the applications and people it must support. Windows Server, Ubuntu Server and Rocky Linux can all run useful business services, but they fit different environments. The comparison here is based on their documented features, not on a benchmark carried out on these VMs.

Windows Server makes sense when an organization depends on Microsoft services or applications. Active Directory Domain Services, Windows administration tools and policy integration can simplify work for an IT team already using that environment. Desktop Experience provides a GUI, while Server Core avoids the full desktop. The evaluation image is useful for this classroom installation, but its 180-day evaluation period is not a permanent production license. A real deployment needs the correct edition and applicable access licensing. [12,19]

Ubuntu Server is a practical starting point for NovaTech's Linux lab. It provides a command-line environment for learning users, networking, storage, package updates and SSH. APT is used to manage deb packages, and the server can later host web applications or databases. AppArmor adds application confinement. The LTS release is suitable when a stable maintenance path matters. However, the administrator still needs to configure services, apply updates and monitor the system; choosing Linux does not do that work automatically. [1,6,18]

Rocky Linux is another option for enterprise Linux work, especially where the team or application expects the RPM/DNF ecosystem. Its tools and SELinux policies differ from Ubuntu, so procedures should not be copied without checking commands and paths. A team moving from another RHEL-family environment may find this approach familiar. Compatibility and vendor support still need to be checked for the exact application and release. [15-17]

Performance should be tested instead of guessed from the operating system name. A GUI, background roles, storage speed, VM memory and the application itself can all affect results. A fair comparison would use similar resources and measure the same task, such as response time for the same web application. No such measurements are claimed in this report.

For this project, Ubuntu is the main deployment exercise and Windows Server is a separate evaluation VM. Rocky Linux is researched for the comparison; its installation is not required by the activity. I would keep the VMs separate and run one at a time if host resources are limited. The final choice for a real company should depend on application support, staff skills, licensing, security requirements and the cost of maintaining the service.

## Troubleshooting guide

These are possible issues and diagnostic actions. They are not problems claimed to have occurred on Jaymark's VM.

| Symptom | What to check | Possible action |
| --- | --- | --- |
| 64-bit guest unavailable or VM will not start | Check host CPU virtualization and available memory. Confirm a supported VirtualBox/host combination. | Record the actual error first. Enable VT-x/AMD-V only if needed; ask for help before changing other host security settings. |
| Installer starts again after reboot | The ISO is still first in the boot order. | Eject the ISO from the virtual optical drive, retain the VDI and boot the installed disk. |
| No guest address | Check Adapter 1 NAT, Cable Connected, ip -brief addr and ip route. | Reconnect the virtual cable or correct the VM adapter, then obtain a DHCP lease again. |
| Address works but google.com fails | Run getent hosts google.com and check resolvectl status if available. | Fix the DNS path. If ICMP is filtered, document that separately; do not label ping as successful. |
| SSH connection refused | Check systemctl status ssh and ssh.socket; check sudo ss -ltnp. | Install openssh-server if missing, validate with sudo sshd -t and start the service. Recheck NAT rule and port. |
| SSH times out from Windows | Check host port 2222 and the loopback-only forwarding rule. | Use 127.0.0.1 on the host, not an assumed NAT guest IP. Change host port if already used. |
| APT lock or download error | Check whether unattended updates are running and read the exact error. | Let the active updater finish. Fix networking/mirror problems and retry; do not delete lock files while a package manager runs. |
| Hostname remains wrong | Compare hostname, hostnamectl and /etc/hostname. | Run sudo hostnamectl set-hostname server01; review any old hostname entry in /etc/hosts and log in again. |
| Windows has no desktop | The Server Core image may have been selected. | Use its supported administration tools or reinstall the empty lab VM with Desktop Experience if the GUI is required. |
| Windows install or activation fails | Check ISO edition, guest CPU compatibility, RAM, disk space and internet/time settings. | Use the official evaluation media and its documented activation process. Do not use an unofficial activation tool. |

## Evidence and lessons learned

### Problems Encountered / Solutions Implemented

No VM installation results or screenshots have been supplied yet. Record actual incidents in Lab_Results.md using symptom, cause, action, retest and evidence. Keep this separate from the possible issues in the troubleshooting table.

### Documentation lessons

- VM resource allocation must leave enough capacity for the host.

- A hostname, address or service state must be checked on the installed system.

- Successful outbound NAT does not prove inbound SSH works.

- Firmware mode, disk layout and bootloader installation belong in the same deployment record.

### Evidence checklist

Save the 20 listed captures in screenshots/README.md. Then add them next to the relevant steps in the guide and README; the current copy contains instructions rather than installation evidence. A real screenshot must show enough context to identify the command and result.

### Before submission

- Ubuntu: complete the installation and all six required verification tasks.

- Windows: install the evaluation VM, rename it and confirm a successful login.

- Fill Lab_Results.md, attach screenshots and replace pending status with actual results.

- Review the preparation reflection and revise it with your own lab experience.

- Follow the instructor's LMS and LinkedIn requirements; neither has been submitted here.

## References 1-10

Official sources accessed 26 October 2026. The assignment supplies the lab settings; source material supports product behavior and comparison research.

**[1] Canonical. Ubuntu Server download.** [https://ubuntu.com/download/server](https://ubuntu.com/download/server). Current LTS download: Ubuntu Server 26.04.1 LTS, amd64.

**[2] Canonical. Basic installation.** [https://ubuntu.com/server/docs/tutorial/basic-installation/](https://ubuntu.com/server/docs/tutorial/basic-installation/). Installation preparation and official server documentation.

**[3] Canonical. Subiquity screen-by-screen installer walk-through.** [https://canonical-subiquity.readthedocs-hosted.com/en/latest/tutorial/screen-by-screen.html](https://canonical-subiquity.readthedocs-hosted.com/en/latest/tutorial/screen-by-screen.html). Installer screens, storage, profile and SSH options.

**[4] Oracle. VirtualBox User Guide, Release 7.2.** [https://docs.oracle.com/en/virtualization/virtualbox/7.2/user/EN-VBOX-7-2-USER.pdf](https://docs.oracle.com/en/virtualization/virtualbox/7.2/user/EN-VBOX-7-2-USER.pdf). VM creation, EFI, networking and NAT forwarding.

**[5] Canonical. OpenSSH server.** [https://ubuntu.com/server/docs/how-to/security/openssh-server/](https://ubuntu.com/server/docs/how-to/security/openssh-server/). SSH installation, configuration and validation.

**[6] Canonical. Install and manage packages.** [https://ubuntu.com/server/docs/how-to/software/package-management/](https://ubuntu.com/server/docs/how-to/software/package-management/). APT package installation and updates.

**[7] UEFI Forum. UEFI FAQs.** [https://uefi.org/faq](https://uefi.org/faq). Firmware interfaces, boot support and Secure Boot.

**[8] Microsoft Learn. Convert a disk to GPT or MBR partition scheme.** [https://learn.microsoft.com/en-us/windows-server/storage/disk-management/change-disk-partition-scheme](https://learn.microsoft.com/en-us/windows-server/storage/disk-management/change-disk-partition-scheme). MBR limitations and GPT capabilities.

**[9] Microsoft Learn. Windows and GPT FAQ.** [https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/windows-and-gpt-faq?view=windows-11](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/windows-and-gpt-faq?view=windows-11). UEFI/GPT relationships and Windows-specific limitations.

**[10] GNU Project. GNU GRUB Manual.** [https://www.gnu.org/software/grub/manual/grub/grub.html](https://www.gnu.org/software/grub/manual/grub/grub.html). Bootloader, Linux kernel and initial RAM disk.

## References 11-20

**[11] systemd project. bootup.** [https://www.freedesktop.org/software/systemd/man/bootup.html](https://www.freedesktop.org/software/systemd/man/bootup.html). System manager, services and boot targets.

**[12] Microsoft. Windows Server 2025 Evaluation Center.** [https://www.microsoft.com/en-in/evalcenter/evaluate-windows-server-2025](https://www.microsoft.com/en-in/evalcenter/evaluate-windows-server-2025). 180-day evaluation and internet activation guidance.

**[13] Microsoft Learn. Install Windows Server from installation media.** [https://learn.microsoft.com/en-us/windows-server/get-started/install-windows-server](https://learn.microsoft.com/en-us/windows-server/get-started/install-windows-server). Installation and Desktop Experience selection.

**[14] Microsoft Learn. Windows Server hardware requirements.** [https://learn.microsoft.com/en-us/windows-server/get-started/hardware-requirements](https://learn.microsoft.com/en-us/windows-server/get-started/hardware-requirements). Check CPU, memory, storage and firmware compatibility.

**[15] Rocky Linux. Installing Rocky Linux 10.** [https://docs.rockylinux.org/10/guides/installation/](https://docs.rockylinux.org/10/guides/installation/). Rocky Linux as an enterprise Linux server platform.

**[16] Rocky Linux. DNF package manager.** [https://docs.rockylinux.org/10/guides/package_management/dnf_package_manager/](https://docs.rockylinux.org/10/guides/package_management/dnf_package_manager/). RPM/DNF package management.

**[17] Rocky Linux. SELinux Security.** [https://docs.rockylinux.org/10/guides/security/learning_selinux/](https://docs.rockylinux.org/10/guides/security/learning_selinux/). SELinux policies and enforcing mode.

**[18] Canonical. AppArmor.** [https://ubuntu.com/server/docs/how-to/security/apparmor/](https://ubuntu.com/server/docs/how-to/security/apparmor/). Ubuntu application confinement.

**[19] Microsoft Learn. Comparison of Windows Server editions.** [https://learn.microsoft.com/en-us/windows-server/get-started/editions-comparison](https://learn.microsoft.com/en-us/windows-server/get-started/editions-comparison). Windows server roles and security features.

**[20] Oracle. VirtualBox downloads.** [https://www.virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads). Official host installer; use the Windows hosts download.
