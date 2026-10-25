# Enterprise Infrastructure Planning

NovaTech Startup Solutions

Prepared by: Jaymark Viriña, BSIT

ITEP 414 - System Administration and Maintenance | Week 2

25 October 2026

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

The helpdesk is the first contact for user incidents. At NovaTech, this role restores everyday productivity and records information needed for escalation. The support tasks below apply entry-level troubleshooting principles to the startup scenario. [6]

**Responsibilities:** Record and prioritize tickets; install approved workstation software; troubleshoot login, printing and connectivity issues; prepare devices for new staff; verify identity before resets; escalate unresolved incidents with logs and actions already tried.

**Skills:** Clear communication, patient questioning, Windows troubleshooting, hardware basics, safe remote support, basic network checks and accurate documentation.

**Common tools:** A ticket queue such as Jira Service Management; licensed AnyDesk; Windows Event Viewer; Intune; ping and ipconfig. Tool choices are proposed for this company.

**Certifications:** CompTIA A+ is a foundational support certification; the Google IT Support Certificate is another entry-level learning pathway. These are examples for career development, not credentials claimed by the author. [6]

### Network Administrator

The network administrator keeps connectivity available and secure. Cisco describes this work as installing, maintaining, monitoring and troubleshooting organizational networks. [7]

**Responsibilities:** Configure router, firewall, switches and APs; maintain VLANs, DHCP scopes and DNS forwarding; apply access rules; monitor uplinks; save device configurations; troubleshoot wired, wireless and VPN connectivity.

**Skills:** TCP/IP, subnetting, VLAN tagging, routing, firewall policy, Wi-Fi coverage analysis and systematic fault isolation.

**Common tools:** Device management interfaces and CLI; Wireshark for packet analysis; an SNMP monitoring system; Cisco Packet Tracer for learning and design exercises.

**Certifications:** Cisco CCNA for networking fundamentals, IP connectivity, security and automation knowledge. CompTIA Network+ is another possible foundation. [8]

### Linux System Administrator

The Linux administrator operates NovaTech's Ubuntu server and protects its data. Ubuntu documentation and Red Hat's RHCSA skill areas support the proposed focus on services, users, storage and security. [1,9]

**Responsibilities:** Maintain users and groups; apply updates; manage Samba permissions, Git access and internal services; monitor disk space and logs; automate scheduled backups; test restores; maintain recovery documentation.

**Skills:** Linux command-line work, Bash scripting, file permissions, service management, SSH, storage concepts and backup troubleshooting.

**Common tools:** OpenSSH, Bash, systemctl, journalctl, apt, rsync and systemd timers. Protect backup credentials separately from ordinary user accounts.

**Certifications:** Red Hat Certified System Administrator (RHCSA) develops practical Linux administration skills. RHCSA is assessed on Red Hat Enterprise Linux, while the proposed company server runs Ubuntu. [9]

### Cloud Administrator

The cloud administrator manages hosted identities, storage, access and cost controls. Microsoft's Azure Administrator role covers compute, networking, storage, identity, security and governance. [10]

**Responsibilities:** Maintain business cloud accounts; apply least-privilege access and MFA; monitor backup storage and recovery; control subscriptions and spending; review service health; coordinate future migration with the Linux and network administrators.

**Skills:** Cloud service models, identity and access management, virtual networking, backup retention, resource tagging, cost monitoring and incident coordination.

**Common tools:** Microsoft 365 admin center and Entra admin center for planned subscriptions; Azure portal and Azure CLI if Azure resources are approved; service monitoring and budget alerts.

**Certifications:** Microsoft Certified: Azure Administrator Associate is relevant to administering Azure infrastructure. It does not replace product-specific training for Microsoft 365 administration. [10]

### Collaboration

When an employee cannot open a shared folder, the Helpdesk Technician records the symptoms, checks the account and tests the connection. If the network path or VLAN rule is responsible, the Network Administrator investigates; if the share or file permissions are responsible, the Linux System Administrator restores access. The Cloud Administrator checks cloud identity, backup availability or a hosted-service outage when those services are involved. All four use the same incident record, agree on ownership, document changes and verify the result with the employee. In a 20-person startup, these responsibilities may be combined among IT staff or supported by a service provider rather than requiring four additional employees.

## Part 7 Infrastructure Recommendations

### Internet provider

Request site-specific business-fiber proposals from PLDT Enterprise and Converge Business, starting with a proposed 300 Mbps service. Compare verified coverage, upload speed, uptime commitments, repair response, installation cost and static-IP options. No provider, price, static IP or service-level agreement is assumed confirmed. Schedule large backups outside busy hours and add a separate mobile failover service if downtime would interrupt client work.

### Server specifications

Start with an 8-core CPU, 32 GB ECC RAM with an upgrade path, two 480 GB SSDs mirrored for the OS and two 4 TB disks mirrored for data. Use Ubuntu Server 24.04 LTS with updates, least-privilege groups and monitored storage. Its published support lifecycle supports a stable deployment choice. These are planning assumptions for file sharing, Git and small internal services, to be validated with workload measurements. Disk mirroring improves availability but does not replace backups. [1,2]

### Backup strategy

Keep production data on the server, a nightly versioned backup on the NAS and a weekly encrypted copy on rotating USB drives, with one drive disconnected off-site. This provides multiple copies across network storage and removable media. Add an encrypted cloud copy of critical data for shorter off-site recovery gaps. Proposed targets are a 24-hour recovery point and an 8-hour recovery time, subject to a restore trial; off-site recovery may lose up to one week without cloud replication. Retain 30 daily and 12 monthly versions where capacity permits, review failures daily and test a sample restore monthly and full recovery quarterly. [11]

### Security recommendations

Enforce VLAN boundaries at the firewall and use the permissions listed in Part 4. Permit SSH only from approved IT administration devices; use keys and disable direct root login. Require VPN with MFA for remote administrative access; do not publish SSH or file shares directly to the internet. Apply device encryption, patching, least privilege, a locked equipment area and configuration backups. Inspect encrypted traffic only under an approved company policy.

### Antivirus

Keep Microsoft Defender Antivirus active on every Windows endpoint. Budget Microsoft 365 Business Premium for 20 users to provide the proposed Office apps, Intune management and Defender for Business capabilities. Enroll devices and test alerts; built-in antivirus alone does not establish centralized management. Review detections, isolate affected devices and document recovery actions. [3]

### Password policy

Adopt unique passphrases of at least 15 characters, MFA for email, cloud administration and VPN, and a company password manager. Block known compromised passwords; avoid routine forced changes and arbitrary character-composition rules. Change credentials after suspected compromise, protect recovery methods and separate ordinary from administrator accounts. This company policy is informed by NIST guidance and must be implemented within each product's supported controls. [12]

### Expansion plan

The initial core switch uses 7 ports and the access switch uses 16, leaving 25 of 48 ports unused. Each of 14 desktops has one cable run; six laptops use Wi-Fi. The 20 horizontal runs comprise 14 desktops, two printers, two APs and two spare outlets. Add staff only after checking PoE capacity, Wi-Fi load, patch-panel capacity and server utilization. Add a patch panel, access switch or AP when measurements justify it. Reassess redundancy and cloud hosting as availability needs grow.

## Part 8 Personal Reflection

Before this project, I thought being a System Administrator was mostly about fixing computers when something goes wrong. Planning the infrastructure for NovaTech helped me understand that the work begins much earlier. A system administrator needs to identify what employees do, choose suitable equipment, organize access, and prepare ways to recover important information. A useful plan explains why each decision supports the business instead of simply listing products.

Preparing the inventories helped me connect equipment choices to actual users. The IT, HR, and Finance departments need desktop computers because most of their work takes place at fixed desks. Sales employees need laptops because their work can involve client visits. I also learned that shared equipment, such as printers, switches, storage, and UPS units, needs to be counted and justified. The quantities in the report should agree with the diagram so that another person can understand what must be purchased.

The most challenging part was organizing the network diagram. Choosing labels was easier than deciding how devices should connect and how departments should be separated. I needed to distinguish a physical connection from a security boundary. A switch connects devices, while VLANs and firewall rules control which groups can communicate. Clear connections and consistent labels make the design easier to explain and reduce confusion during deployment.

Planning is important because mistakes become more expensive after equipment is purchased and installed. Missing backup storage, insufficient network ports, or unclear software licenses can delay work and create unexpected costs. I also realized that having a backup is only useful when it can be restored. A recovery plan should identify who checks backup failures and how often restoration is tested.

This project will help me become a better System Administrator by encouraging me to document decisions, check assumptions, and consider maintenance before deployment. Researching the four IT roles also showed me why communication matters. Helpdesk, network, Linux, and cloud responsibilities are connected even when one person performs several of them. I still need more practical experience configuring and testing these systems, but this activity gives me a clearer process to follow when planning an organization's IT environment.

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

