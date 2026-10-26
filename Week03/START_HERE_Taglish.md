# Week 3 - simulan dito

## Ano ang gagawin natin?

Sa Week 2, plano pa lang ang infrastructure. Sa Week 3, mag-i-install ka na ng totoong operating system sa **virtual machine**. Ang VM ay parang hiwalay na computer sa loob ng laptop mo. May sarili itong RAM allocation, disk at operating system, pero VirtualBox ang nagpapatakbo nito.

May dalawang installation: **Ubuntu Server** para sa main lab, at **Windows Server Evaluation** para sa bring-home activity. **Comparison lang ang Rocky Linux**; hindi hinihinging i-install ito.

Ready na ang guides, research at diagram dito. Kailangan pa ang actual installation at sarili mong screenshots bago maging complete ang submission.

## 1. Ihanda ang kailangan sa Windows PC

1. I-check ang RAM at free disk space. May 4 GB RAM na kailangan ang Ubuntu guest bukod pa sa pangangailangan ng Windows host. Kung limitado ang laptop, isa-isang VM lang ang patakbuhin.
2. I-download at i-install ang [VirtualBox para sa Windows hosts](https://www.virtualbox.org/wiki/Downloads). Hindi kailangan ang optional Extension Pack sa lab na ito.
3. I-download ang **Server LTS amd64 ISO** sa [Ubuntu Server](https://ubuntu.com/download/server). Ang na-verify na latest LTS noong 26 October 2026 ay 26.04.1. Hindi Desktop ISO ang gagamitin.
4. I-download ang [Windows Server 2025 Evaluation ISO](https://www.microsoft.com/en-in/evalcenter/evaluate-windows-server-2025) para sa susunod na VM. Evaluation ito, hindi permanenteng production license.
5. I-record ang version at ISO filenames sa Lab_Results.md. I-check ang ISO hash gamit ang official SHA256SUMS kung available.

## 2. Gawin ang Ubuntu VM

Sa VirtualBox, piliin ang **New**. Ito ang settings:

| Setting | Ilalagay |
| --- | --- |
| Name | Ubuntu-Server-Week03 |
| ISO | Na-download na Ubuntu Server LTS ISO |
| Unattended setup | Skip / disable para ikaw ang makasunod sa installer |
| RAM | 4096 MB |
| CPU | 2 |
| Disk | New 40 GB dynamically allocated VDI |
| Firmware | Enable EFI / UEFI bago mag-install |
| Network | NAT; Cable Connected |

**VM name** ang nakikita sa VirtualBox. **Hostname** naman ang pangalan sa loob ng Ubuntu: server01. Magkaiba ang dalawang iyon.

Kunan ng screenshot ang VM settings. Puwedeng magkahiwalay na screenshot para mabasa ang RAM, CPU, disk at network.

## 3. Sundan ang Ubuntu installer

1. Start VM, pagkatapos piliin ang Ubuntu Server install entry.
2. Language: English. Keyboard: English (US).
3. Network: DHCP. I-record ang actual IP na ibinigay. Proxy: blank kung wala kang ginagamit. Default mirror kung gumagana ang check.
4. Storage: Guided / Use an entire disk. Piliin lang ang **bagong 40 GB virtual disk**. Sa guide na ito, naka-off ang optional LVM para mas simple. Basahin ang partition summary bago mag-confirm.
5. Full name: Jaymark Viriña. Server name: server01. Username: virina. Ikaw ang gumawa ng private password.
6. Piliin ang Install OpenSSH Server. Huwag pumili ng optional featured snaps.
7. Hintaying matapos. Reboot, at alisin ang ISO sa virtual optical drive kung pinapagawa. Huwag alisin ang VDI.
8. Login bilang virina. Normal lang na walang lumalabas na characters habang tina-type ang password.

Tab / arrows para gumalaw, Space para sa checkbox, Enter para magpatuloy. Kunan ng screenshot ang major steps gamit ang listahan sa screenshots/README.md.

## 4. Patunayan na gumagana

Patakbuhin isa-isa sa **Ubuntu terminal**, hindi sa Windows PowerShell:

```bash
hostname
ip addr
ping -c 4 google.com
sudo apt update
sudo apt upgrade -y
systemctl status ssh
```

| Command | Simple na ibig sabihin |
| --- | --- |
| hostname | Ano ang pangalan ng server? Dapat server01. |
| ip addr | Ano ang assigned IP ng network interface? |
| ping -c 4 google.com | Makakapag-resolve at makakaabot ba sa google.com gamit ang apat na ping? |
| sudo apt update | I-refresh ang listahan ng available packages. |
| sudo apt upgrade -y | I-install ang available upgrades; hindi ito release upgrade. |
| systemctl status ssh | Tingnan kung tumatakbo ang SSH service. Press q para lumabas. |

Kapag may error, i-record muna. Huwag gawing Passed ang isang test hangga't hindi talaga gumagana. Kung socket-activated ang SSH, puwedeng idle ang daemon hanggang may connection. I-check ang ssh.socket o gamitin ang sudo systemctl start ssh, saka ulitin ang status at remote login test.

## 5. SSH mula sa Windows host

Ang **SSH** ay encrypted remote terminal. Ang **NAT** ay paraan para makagamit ng network ng laptop ang VM. Para makapasok mula Windows papuntang Ubuntu, may port forwarding:

1. I-shutdown muna nang maayos ang guest. Sa VirtualBox Network / NAT / Port Forwarding, gumawa ng rule.
2. Name: ssh. Protocol: TCP. Host IP: 127.0.0.1. Host Port: 2222. Guest IP: blank. Guest Port: 22.
3. Start Ubuntu. Sa **Windows PowerShell**, patakbuhin:

```powershell
ssh -p 2222 virina@127.0.0.1
```

4. I-compare ang host-key fingerprint sa guest console bago tanggapin ang first connection. Nasa manual ang command para rito. I-type nang private ang password.
5. Pag nakapasok, patakbuhin ang whoami at hostname. Kunan ng screenshot ang working SSH session. Type exit para lumabas.

Ang 127.0.0.1 ay sariling laptop lang. Hindi nito ginagawang public internet server ang VM.

## 6. Windows Server sa hiwalay na VM

1. Gumawa ng Windows-Server-Week03: suggested 4 GB RAM, 2 CPU, 80 GB dynamic VDI, NAT at UEFI. I-check din ang official requirements ng ISO.
2. Piliin ang Evaluation image na may **Desktop Experience** para may GUI. Kung Server Core ang napili, walang full desktop.
3. I-install sa sariling empty virtual disk. Ikaw ang magre-review ng license terms at gagawa ng Administrator password.
4. Login sa Windows guest. Gamitin ang VirtualBox Input / Keyboard / Insert Ctrl+Alt+Del kung kailangan.
5. Sa PowerShell **sa loob ng Windows VM**, bilang Administrator:

```powershell
Rename-Computer -NewName "WIN-SERVER01" -Restart
```

6. Login ulit at patakbuhin ang hostname. Kunan ng screenshot ang installation, desktop/login at bagong computer name. Sundin ang Windows Update at evaluation activation instructions.

## 7. Ano ang BIOS, UEFI at boot process?

**BIOS / UEFI** ang firmware na unang gumagana bago ang OS. Karaniwang UEFI na ang modern setup. Ang **GPT / MBR** ay partition styles, hindi pangalan ng operating system.

Sa diagram: Power On -> firmware checks -> pili ng boot device -> GRUB -> Linux kernel -> systemd -> services -> login. Ang **GRUB** ang loader; ang **kernel** ang pangunahing bahagi ng Linux; ang **systemd** ang nag-aayos ng userspace services.

Hindi automatic na may Secure Boot dahil UEFI lang ang gamit. Hindi rin automatic na mas mabilis ang lahat ng UEFI machines. Nasa BIOS_vs_UEFI.pdf ang mas kumpletong explanation.

## 8. Paano magiging complete ang ipapasa?

I-send ang actual screenshots para maipasok sa guide at README. Punan ang Lab_Results.md gamit ang tunay na settings at outputs. I-update ang reflection ayon sa ginawa at naranasan mo. Pagkatapos, i-review ang final PDFs at GitHub Week03 link bago i-submit sa LMS.

Huwag i-upload ang ISO, VDI/VMDK, passwords o SSH private keys. Ang documentation at evidence lang ang kailangan sa portfolio.
