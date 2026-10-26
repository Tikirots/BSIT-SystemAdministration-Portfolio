# Enterprise Infrastructure Planning

NovaTech Startup Solutions

Prepared by: Jaymark Viriña, BSIT

ITEP 414 - System Administration and Maintenance | Week 2

25 October 2026

## Project Overview

This plan covers the equipment, software, network and support needs of a fictional startup with 20 employees. The PDF and this text version contain the eight project sections.

## Part 1 Company Profile

**Company name:** NovaTech Startup Solutions

**Nature of business:** A fictional software development startup building web and mobile applications for small businesses.

**Vision:** To become a trusted software solutions provider that helps small businesses grow through technology.

**Mission:** To deliver reliable, secure, and affordable software while developing employee skills and protecting customer information.

**Office location:** 3rd Floor, Meridian Business Center, Brgy. Real, Calamba City, Laguna (fictional).

**Office arrangement:** One office floor with departmental work areas and a locked equipment area. The CEO and department heads are included in the 20 employees, not additional positions.

CEO / General Manager → department managers → department staff. Management roles are included in the 20 employees.

| Department | Employees | Workstations |
| --- | --- | --- |
| Information Technology | 5 | 5 desktops |
| Human Resources | 4 | 4 desktops |
| Finance | 5 | 5 desktops |
| Sales | 6 | 6 laptops |
| Total | 20 | 14 desktops and 6 laptops |

## Part 2 Enterprise Hardware Inventory

| Asset ID | Hardware | Qty | Department | Purpose and specification |
| --- | --- | --- | --- | --- |
| HW-001 | Desktop computer | 5 | IT | 8-core class CPU, 32 GB RAM, 1 TB SSD; development, testing and administration. |
| HW-002 | Desktop computer | 4 | HR | 6-core class CPU, 16 GB RAM, 512 GB SSD; employee records and office work. |
| HW-003 | Desktop computer | 5 | Finance | 6-core class CPU, 16 GB RAM, 512 GB SSD; accounting and financial reports. |
| HW-004 | Laptop | 6 | Sales | 16 GB RAM, 512 GB SSD, Wi-Fi and full-disk encryption; client visits and mobile work. |
| HW-005 | Tower server | 1 | Shared / IT | 8 cores, 32 GB ECC RAM, mirrored boot SSDs and mirrored data disks; files, Git and internal apps. |
| HW-006 | VPN-capable router | 1 | Shared | WAN routing and provider handoff; avoid duplicate NAT with the firewall. |
| HW-007 | Managed 24-port switch | 2 | Shared | Gigabit VLAN-capable core SW1 and access SW2; SW1 supplies PoE for two APs. |
| HW-008 | Multifunction printer | 2 | Shared | One for IT/HR and one for Finance/Sales; network print and scan. |
| HW-009 | UPS | 3 | Shared | Server/NAS, network edge/core, and access switch/AP path; size from measured load. |
| HW-010 | Wireless access point | 2 | Shared | Business dual-band Wi-Fi, multiple SSIDs and VLAN tagging; coverage verified on site. |
| HW-011 | NAS storage | 1 | Shared / IT | Two-bay mirrored storage, at least 4 TB usable initially; restricted local backups. |
| HW-012 | External backup drive | 2 | IT | Encrypted 4 TB drives rotated weekly; one disconnected and stored off-site. |
| HW-013 | Monitor | 16 | IT / HR / Finance | 14 primary monitors plus two extra displays for IT development and administration. |

Asset IDs identify purchasing groups; assign unique unit records at deployment. Shared equipment in Parts 2 and 4 is counted once. UPS units protect infrastructure rather than every desktop.

## Part 3 Enterprise Software Inventory

Supported, approved versions are recorded at deployment. Device OS licenses and user subscriptions are separate.

| Software | Version | License | Purpose |
| --- | --- | --- | --- |
| Windows 11 Pro | Supported release | 20 OEM/device licenses | Business desktop OS, disk encryption and workstation administration. |
| Ubuntu Server | 24.04 LTS | Open source | Server OS for Samba file shares, Git access, SSH and internal applications. [1,2] |
| Microsoft Office | Microsoft 365 Apps | 20 Business Premium user subscriptions | Word, Excel, PowerPoint and Outlook; business email and collaboration. [3] |
| VS Code | Approved stable build | Microsoft distribution license; no purchase fee | Code editing, debugging and development extensions for IT. |
| Git | Approved stable build | Open source (GPLv2) | Version history and collaboration for application code and configuration. |
| GitHub Desktop | Approved stable build | Open source (MIT) | Graphical Git workflow for IT; private repository access follows company policy. |
| VirtualBox | Supported 7.x base package | Open-source base package | Isolated development/test VMs on IT PCs. Optional Extension Pack excluded. [4] |
| Google Chrome | Approved stable build | Proprietary; no purchase fee | Browser-based business services and web application compatibility tests. |
| Microsoft Defender | Updated signatures / agent | Built-in AV; business management via Premium | Endpoint antivirus with centralized visibility using Defender for Business and Intune. [3] |
| AnyDesk | Supported business build | Paid commercial license | Authorized remote support by IT; no personal-use license for company support. [5] |
| 7-Zip | Approved stable build | Open source; component licenses apply | Archive and extract files for routine document and backup transfers. |

## Part 4 Enterprise Network Inventory

| Item | Specification | Qty | Purpose |
| --- | --- | --- | --- |
| ISP modem / ONT | Provider-managed fiber handoff | 1 | Business fiber termination; bridge/routed handoff coordinated with ISP. |
| Router | Gigabit WAN/LAN and VPN capability | 1 | Provider-facing routing; firewall handles LAN policy, NAT and remote VPN. |
| Firewall | NGFW with VLAN interfaces, VPN and logging | 1 | Default-deny inter-VLAN rules, outbound control and inspected remote access. |
| Managed switch | 24-port Gigabit, 802.1Q; PoE on SW1 | 2 | Core SW1 and access SW2; VLAN trunks and wired endpoint connections. |
| Wireless AP | Dual-band, VLAN-aware business AP | 2 | Sales and guest coverage; PoE-powered from SW1. |
| Patch panel | 24-port Cat6 | 1 | Terminates 20 planned horizontal office cable runs; four spare positions. |
| Cat6 cable / patch lead | Correctly rated runs and patch leads | 70 | 20 fixed runs, 20 cabinet leads, 18 endpoint leads, 6 device links and 6 spares. |
| RJ45 connector | Cat6-compatible plug; match cable type | 100 | Spare stock for patch-lead fabrication and repairs, not mandatory use on every run. |

### VLAN and addressing plan

| VLAN | Group | Subnet | Access |
| --- | --- | --- | --- |
| 10 | IT | 192.168.10.0/24 | 5 PCs; privileged access only from approved admin devices. |
| 20 | HR | 192.168.20.0/24 | 4 PCs; access only to approved HR shares and services. |
| 30 | Finance | 192.168.30.0/24 | 5 PCs; restricted accounting and finance shares. |
| 40 | Sales | 192.168.40.0/24 | 6 laptops on staff Wi-Fi; approved files and printers. |
| 50 | Servers / backup | 192.168.50.0/24 | Server .10 and NAS .20; backup administration restricted. |
| 60 | Printers | 192.168.60.0/24 | PRN1 .11 and PRN2 .12; print access without broad LAN reach. |
| 70 | Guest Wi-Fi | 192.168.70.0/24 | Internet only with client isolation; blocked from private subnets. |
| 99 | Management | 192.168.99.0/24 | SW1 .11, SW2 .12, AP1 .21, AP2 .22; IT admin access only. |

The firewall is the .1 gateway and DHCP server for each VLAN. User leases: .100-.199. Deny cross-department access by default, permit only approved services, and restrict management to approved IT devices. Guest access is internet-only. The 20 horizontal runs cover 14 desktops, two printers, two APs and two spare outlets. The 70 cable items comprise these runs, 20 cabinet leads, 18 endpoint leads, six equipment interconnects and six spare leads. Validate cable measurements and PoE budget before purchase.

## Part 5 Enterprise Network Diagram

![NovaTech network topology](diagrams/NovaTech_Network_Diagram.png)

[Editable Draw.io](diagrams/NovaTech_Network_Diagram.drawio) | [PDF](diagrams/NovaTech_Network_Diagram.pdf)

SW1 uses 7 ports; SW2 uses 16. The two APs serve the same six Sales laptops. The patch panel is omitted from this logical topology. Coordinate router and firewall roles to avoid duplicate NAT.

## Part 6 System Administration Roles

### Helpdesk Technician

Employees usually contact the helpdesk first when something stops working. At NovaTech, this could be a login problem, a printer error or a laptop that cannot connect to Wi-Fi. The helpdesk checks the problem and passes it on with useful details if another administrator is needed. [6]

**Responsibilities:** Log support requests and decide which need attention first. Set up employee devices, install approved software and check common account, printer and connection problems. Verify the employee's identity before a password reset. Record the checks already done before escalating a ticket.

**Skills:** Listening, clear explanations, Windows troubleshooting, basic hardware and networking knowledge, safe remote support and careful ticket notes.

**Common tools:** A ticketing system such as Jira Service Management, licensed AnyDesk, Windows Event Viewer, Intune, ping and ipconfig.

**Certifications:** CompTIA A+ is one option for building support skills. The Google IT Support Certificate is another starting point for troubleshooting, operating systems and customer support. [6]

### Network Administrator

The Network Administrator looks after the connections between employees, shared devices and the internet. Cisco describes the role as installing, maintaining, monitoring and troubleshooting networks. At NovaTech, the switches, firewall and Wi-Fi would be part of this work. [7]

**Responsibilities:** Set up the router, firewall, switches and APs. Maintain VLANs, DHCP settings, DNS forwarding and access rules. Check link failures and Wi-Fi problems, monitor the network and keep backup copies of device configurations.

**Skills:** TCP/IP, subnetting, VLANs, routing, firewall rules, Wi-Fi planning and step-by-step troubleshooting.

**Common tools:** Device web interfaces and command lines, Wireshark for packet checks, an SNMP monitoring tool and Cisco Packet Tracer for practice and design exercises.

**Certifications:** Cisco CCNA covers network fundamentals, IP connectivity, security and automation. CompTIA Network+ is another foundation to consider. [8]

### Linux System Administrator

The Linux System Administrator would maintain NovaTech's Ubuntu server, including shared files, user access and internal services. Ubuntu documentation and the RHCSA skill areas cover the user, storage, service and security tasks needed here. [1,9]

**Responsibilities:** Create users and groups, set file permissions and maintain Samba and Git access. Apply updates, check logs and storage space, schedule backups and test restores. Keep recovery instructions that another IT staff member can follow.

**Skills:** Linux commands, Bash scripting, file permissions, SSH, service management, storage and backup troubleshooting.

**Common tools:** OpenSSH, Bash, systemctl, journalctl, apt, rsync and systemd timers. Backup credentials should be kept separate from ordinary employee accounts.

**Certifications:** Red Hat Certified System Administrator (RHCSA) tests practical Linux administration. Its exam uses Red Hat Enterprise Linux, so Ubuntu-specific commands and tools still need separate practice. [9]

### Cloud Administrator

The Cloud Administrator handles the company's hosted accounts and services. For this plan, that starts with Microsoft 365 and could later include cloud backup or hosting. Microsoft's Azure Administrator role also covers compute, networks, storage, identity and governance. [10]

**Responsibilities:** Manage cloud accounts and access, require MFA and review service health. Check backup storage, subscriptions and spending. Work with the Linux and network administrators when adding hosted services or moving an existing service to the cloud.

**Skills:** Cloud service models, account permissions, virtual networks, backup retention, cost monitoring and incident coordination.

**Common tools:** Microsoft 365 admin center and Entra admin center for the planned subscriptions. Azure portal, Azure CLI and budget alerts would be used if Azure resources are added.

**Certifications:** Microsoft Certified: Azure Administrator Associate is relevant to Azure infrastructure. Microsoft 365 administration would still require training in its own products and tools. [10]

### Collaboration

For example, an employee may report that a shared folder will not open. The Helpdesk Technician first checks the account and connection, then records the results in the ticket. The Network Administrator checks the network path or VLAN rule, while the Linux System Administrator checks the share and file permissions. The Cloud Administrator joins in if cloud identity or a hosted service is involved. They keep their notes in the same ticket and confirm with the employee that access works again. With only five IT employees at NovaTech, one person may handle more than one of these roles; the responsibilities still need to be clear.

## Part 7 Infrastructure Recommendations

### Internet provider

I would ask PLDT Enterprise and Converge Business for business-fiber proposals for the office location. A 300 Mbps connection is a starting point for the plan, but the choice should depend on actual coverage, upload speed, repair response, uptime commitments and cost. A static IP is worth checking if a service needs one. Large backups can run after office hours. A separate mobile connection can provide failover if the main line goes down. Coverage, prices and service terms still need confirmation.

### Server specifications

An 8-core CPU and 32 GB ECC RAM should be a reasonable starting point for shared files, Git and small internal applications. I would use two 480 GB SSDs in a mirror for the OS and two 4 TB disks in a mirror for data, with room to upgrade memory. Ubuntu Server 24.04 LTS offers a stable support lifecycle. Storage and workload measurements should guide later upgrades. Mirrored disks help when one drive fails, but they do not replace a backup. [1,2]

### Backup strategy

Keep the working files on the server and make a versioned backup to the NAS each night. Copy them weekly to encrypted rotating USB drives, keeping one disconnected and off-site. An encrypted cloud copy of critical files would reduce the gap between off-site backups. The initial targets are to lose no more than 24 hours of data and restore service within 8 hours; a restore trial must show whether these targets are realistic. Without the cloud copy, an off-site recovery could lose up to one week. Keep 30 daily and 12 monthly versions where storage allows. Check failures daily, restore sample files monthly and test full recovery quarterly. [11]

### Security recommendations

Use the VLAN rules in Part 4 so employees can reach the files and printers they need without gaining access to every department. Allow SSH administration only from approved IT devices, use keys and disable direct root login. Remote administrators should connect through a VPN with MFA. Keep SSH and file shares off the public internet. Encrypt employee devices, apply updates, limit administrator rights, lock the equipment area and back up device configurations. Any inspection of encrypted traffic needs an approved company policy.

### Antivirus

Keep Microsoft Defender Antivirus active on all Windows workstations. This plan includes Microsoft 365 Business Premium for 20 users, covering Office apps, Intune management and Defender for Business. IT still needs to enroll the devices and test whether alerts reach the administrator. When a threat is detected, isolate the device, investigate the cause and record the recovery steps. [3]

### Password policy

Require unique passphrases of at least 15 characters and MFA for company email, cloud administration and VPN access. A company password manager can help employees avoid reusing passwords. Block known compromised passwords and change credentials when compromise is suspected. Avoid routine forced changes and arbitrary character rules. Keep administrator accounts separate from everyday accounts and protect recovery methods. These recommendations follow NIST guidance and need to be configured within each product's available controls. [12]

### Expansion plan

SW1 uses 7 ports and SW2 uses 16, leaving 25 of the 48 ports free. The 14 desktops use cable connections and the six Sales laptops use Wi-Fi. The 20 fixed cable runs cover the desktops, two printers, two APs and two spare outlets. Before adding staff, check the PoE budget, Wi-Fi load, patch-panel capacity and server use. Add another panel, switch or AP when those checks show it is needed. As the company takes on more work, review whether a second connection, more resilient equipment or cloud hosting is worth the cost.

## Part 8 Personal Reflection

I used to think that a System Administrator mainly fixes computers and installs software. Working on this plan for NovaTech showed me how much needs to be decided before any equipment is bought. The company has 20 employees, but their needs are different. The plan has to account for the work they do, the information they use, and what happens if a device or service fails.

The hardware inventory made those differences easier to understand. IT, HR, and Finance can use desktops because they mainly work at their desks. Sales needs laptops for work that may involve visiting clients. Shared equipment also needs a reason for being included. A NAS, backup drives, and UPS units may be less noticeable than computers, but they help protect the company's files and keep important services available.

The network diagram was the hardest part for me. Listing devices was straightforward; showing how they connect took more thought. The drawing also had to agree with the inventory. For example, the 14 desktops use wired connections, while the six Sales laptops use Wi-Fi. I needed to understand that connecting devices to a switch does not automatically mean every department should have access to the others. That is where the VLANs and firewall rules come in.

This activity also changed how I look at backups. Keeping another copy of a file is only part of the job. Someone still has to check whether the backup ran and whether the files can actually be restored. Software licenses and spare network ports also need attention early, since overlooking them can lead to extra costs after installation.

Planning gives the company something to check before spending money. It also gives the people setting up the network a clear starting point. For me, this project is practice in explaining my choices instead of just naming equipment. Learning about the helpdesk, network, Linux, and cloud roles showed me how their work connects during a problem. I still need hands-on experience configuring these systems, but I now have a better idea of what to check and document before deployment.

## References

1. **Canonical. [Ubuntu Server documentation](https://ubuntu.com/server/docs/).** Linux server services, users, storage and administration.

2. **Canonical. [Ubuntu release cycle](https://ubuntu.com/about/release-cycle).** Ubuntu 24.04 LTS support lifecycle.

3. **Microsoft. [Microsoft 365 Business Premium](https://www.microsoft.com/en-us/microsoft-365/business/microsoft-365-business-premium).** Productivity apps, device management and business endpoint protection.

4. **Oracle. [VirtualBox licensing FAQ](https://www.virtualbox.org/wiki/Licensing_FAQ).** Base package and optional Extension Pack have different licensing conditions.

5. **AnyDesk. [Professional and personal use](https://anydesk.com/en/professional-use).** Company remote support requires a commercial license.

6. **Google. [Google IT Support Certificate](https://grow.google/certificates/it-support/).** Troubleshooting, customer care, networking, operating systems and support learning.

7. **Cisco. [Become a Network Administrator](https://www.cisco.com/site/us/en/learn/training-certifications/tech-roles/network-administrator.html).** Network administrator responsibilities.

8. **Cisco. [CCNA certification](https://www.cisco.com/site/us/en/learn/training-certifications/certifications/enterprise/ccna/index.html).** Networking certification pathway.

9. **Red Hat. [Red Hat Certified System Administrator](https://www.redhat.com/en/services/certification/rhcsa).** Linux administrator skills and RHCSA scope.

10. **Microsoft Learn. [Azure Administrator Associate](https://learn.microsoft.com/en-us/credentials/certifications/azure-administrator/).** Azure administrator responsibilities and credential.

11. **US-CERT / CISA. [Data Backup Options](https://www.cisa.gov/sites/default/files/publications/data_backup_options.pdf).** Multiple backups, different media and off-site recovery.

12. **NIST. [SP 800-63B-4 Authentication and Authenticator Management](https://pages.nist.gov/800-63-4/sp800-63b.html).** Passphrases, compromised-password checks and authentication controls.

13. **draw.io. [Supported export formats](https://www.drawio.com/docs/manual/export/export-diagram/).** Editable diagram source and PNG/PDF formats.

