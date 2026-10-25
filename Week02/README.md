# Week 2 Enterprise Infrastructure Planning

**Jaymark Viriña, BSIT**
ITEP 414 - System Administration and Maintenance

[Read the report](EnterpriseInfrastructurePlan.pdf) · [Read the text version](EnterpriseInfrastructurePlan.md) · [Diagram PDF](diagrams/NovaTech_Network_Diagram.pdf) · [Edit in Draw.io](diagrams/NovaTech_Network_Diagram.drawio)

## Project Overview

This project proposes the initial IT infrastructure for **NovaTech Startup Solutions**, a fictional software development startup. As Junior System Administrator, I planned the workstations, shared services, software, network, security and backup arrangements before purchasing or deployment. The report includes all eight required project sections.

## Learning Objectives

- Explain the responsibilities of system administration and how support roles cooperate.
- Translate business requirements into justified hardware, software and network inventories.
- Design a logical network with appropriate segmentation, connectivity and capacity.
- Document technical decisions and communicate them through a professional GitHub portfolio.

## Company Scenario

NovaTech starts with **20 employees on one office floor**, with no computers, server, network, internet infrastructure or security policies. The fictional location is Calamba City, Laguna. The organizational structure and complete company profile are in Part 1 of the report.

| Department | Employees | Workstations |
| --- | --- | --- |
| Information Technology | 5 | 5 desktops |
| Human Resources | 4 | 4 desktops |
| Finance | 5 | 5 desktops |
| Sales | 6 | 6 laptops |
| Total | 20 | 14 desktops and 6 laptops |

## Hardware Inventory Summary

| Equipment | Quantity | Purpose |
| --- | --- | --- |
| Desktop computers | 14 | IT 5, HR 4, Finance 5 |
| Laptops | 6 | Sales mobility |
| Server / NAS | 1 each | Internal services / restricted local backups |
| Router / NGFW | 1 each | Provider routing / firewall and VPN |
| Managed switches | 2 | 24-port core SW1 and access SW2 |
| Wireless APs / printers | 2 each | Wi-Fi coverage / shared print and scan |
| UPS units | 3 | Infrastructure power protection |
| External backup drives | 2 | Encrypted rotation with one off-site |
| Monitors | 16 | 14 primary and two extra IT displays |

The inventories are a purchasing plan, not evidence that equipment has been acquired. Part 2 provides specifications and selection rationale.

## Software Inventory Summary

| Software | Purpose / licensing approach |
| --- | --- |
| Windows 11 Pro | Business desktop OS, disk encryption and workstation administration. 20 OEM/device licenses. |
| Ubuntu Server | Server OS for Samba file shares, Git access, SSH and internal applications. [1,2] Open source. |
| Microsoft Office | Word, Excel, PowerPoint and Outlook; business email and collaboration. [3] 20 Business Premium user subscriptions. |
| VS Code | Code editing, debugging and development extensions for IT. Microsoft distribution license; no purchase fee. |
| Git | Version history and collaboration for application code and configuration. Open source (GPLv2). |
| GitHub Desktop | Graphical Git workflow for IT; private repository access follows company policy. Open source (MIT). |
| VirtualBox | Isolated development/test VMs on IT PCs. Optional Extension Pack excluded. [4] Open-source base package. |
| Google Chrome | Browser-based business services and web application compatibility tests. Proprietary; no purchase fee. |
| Microsoft Defender | Endpoint antivirus with centralized visibility using Defender for Business and Intune. [3] Built-in AV; business management via Premium. |
| AnyDesk | Authorized remote support by IT; no personal-use license for company support. [5] Paid commercial license. |
| 7-Zip | Archive and extract files for routine document and backup transfers. Open source; component licenses apply. |

Exact installed builds will be recorded during deployment. AnyDesk requires a commercial license for work use; the optional VirtualBox Extension Pack is excluded. Windows device licenses and Microsoft 365 subscriptions are budgeted separately. See [sources 3-5](references/Sources.md).

## Network Inventory Summary

The design includes one ISP modem/ONT, one router, one firewall, two managed switches, two APs, one 24-port patch panel, 70 Cat6 cable items and 100 spare compatible RJ45 plugs. Cabling includes fixed runs, cabinet and endpoint leads, device interconnects and spares. See Part 4 for the itemized inventory and VLAN plan. SW1 uses 7 ports and SW2 uses 16; 25 ports remain unused across the two switches.

## Embedded Network Diagram

![NovaTech enterprise network topology prepared by Jaymark Viriña](diagrams/NovaTech_Network_Diagram.png)

Internet → ISP modem/ONT → edge router → firewall → SW1 core switch. SW1 connects the server, NAS, one printer, two APs and SW2. SW2 connects the 14 desktops and second printer. Six Sales laptops use staff Wi-Fi. VLANs separate IT, HR, Finance, Sales, servers, printers, guests and device management; the firewall enforces access between them.

**Diagram files:** [PNG](diagrams/NovaTech_Network_Diagram.png), [PDF](diagrams/NovaTech_Network_Diagram.pdf), [editable Draw.io](diagrams/NovaTech_Network_Diagram.drawio), [SVG](diagrams/NovaTech_Network_Diagram.svg). Open the `.drawio` file in diagrams.net to edit individual symbols, labels and connectors.

## Technologies Used

Draw.io-compatible diagram XML, Markdown, Git/GitHub, PDF documentation, Windows 11 Pro, Ubuntu Server, VLANs, VPN, NAS backups and business endpoint management. The operating systems and services are proposed deployment technologies; this activity documents their design.

## Challenges Encountered

The main challenge was turning an equipment list into a logical diagram. Each shared device needs a clear switch connection, and inventory quantities must match the drawing. Another challenge was separating physical connectivity from VLAN access policy and accounting for software licenses, backup recovery and future growth.

## Reflection

Before this project, I thought being a System Administrator was mostly about fixing computers when something goes wrong. Planning the infrastructure for NovaTech helped me understand that the work begins much earlier. A system administrator needs to identify what employees do, choose suitable equipment, organize access, and prepare ways to recover important information. A useful plan explains why each decision supports the business instead of simply listing products.

Preparing the inventories helped me connect equipment choices to actual users. The IT, HR, and Finance departments need desktop computers because most of their work takes place at fixed desks. Sales employees need laptops because their work can involve client visits. I also learned that shared equipment, such as printers, switches, storage, and UPS units, needs to be counted and justified. The quantities in the report should agree with the diagram so that another person can understand what must be purchased.

The most challenging part was organizing the network diagram. Choosing labels was easier than deciding how devices should connect and how departments should be separated. I needed to distinguish a physical connection from a security boundary. A switch connects devices, while VLANs and firewall rules control which groups can communicate. Clear connections and consistent labels make the design easier to explain and reduce confusion during deployment.

Planning is important because mistakes become more expensive after equipment is purchased and installed. Missing backup storage, insufficient network ports, or unclear software licenses can delay work and create unexpected costs. I also realized that having a backup is only useful when it can be restored. A recovery plan should identify who checks backup failures and how often restoration is tested.

This project will help me become a better System Administrator by encouraging me to document decisions, check assumptions, and consider maintenance before deployment. Researching the four IT roles also showed me why communication matters. Helpdesk, network, Linux, and cloud responsibilities are connected even when one person performs several of them. I still need more practical experience configuring and testing these systems, but this activity gives me a clearer process to follow when planning an organization's IT environment.

## References

The report uses numbered citations for IT-role research, product licensing, backup and authentication guidance. Full titles, source links and their relevance are in [references/Sources.md](references/Sources.md).

## Submission Checklist

- [x] Company profile and 20-person employee distribution
- [x] Hardware inventory with quantities and purposes
- [x] Software inventory with versions, licensing and purposes
- [x] Network inventory and VLAN plan
- [x] Labeled network diagram with student name in PNG and PDF
- [x] Four IT roles, certifications and collaboration paragraph
- [x] Seven infrastructure recommendation topics
- [x] Personal reflection within 300-500 words
- [x] README with headings, tables, image and working local links
- [ ] Publish the LinkedIn post and paste its permalink below
- [ ] Submit the required files or repository link in the LMS

**LinkedIn post:** Pending publication. A [ready-to-review draft](LinkedIn_Post_Draft.md) is included; attach the [diagram PNG](diagrams/NovaTech_Network_Diagram.png).

**LMS submission:** Pending the student's submission.
