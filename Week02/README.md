# Week 2 Portfolio Project - Enterprise Infrastructure Planning

ITEP 414 - System Administration and Maintenance
Prepared by: JAYMARK VIRINA, BSIT

## Project Overview
For this project I played the role of a Junior System Administrator who has to plan out the whole IT setup for a startup company (NovaTech Startup Solutions) before anything gets bought. This includes the company profile, hardware/software/network inventories, a network diagram, some research on IT roles, recommendations, and a reflection.

## Learning Objectives
- Understand what a System Administrator actually does
- Figure out the hardware, software, and network needs of a small company
- Practice making IT documentation and planning an infrastructure

## Company Scenario
NovaTech Startup Solutions is a new software company with 20 employees (IT-5, HR-4, Finance-5, Sales-6). They currently have nothing - no computers, no server, no network, no security policies. Everything had to be planned from scratch.

## Hardware Inventory Summary
- 14 desktops (IT, HR, Finance)
- 6 laptops (Sales, since they go out to meet clients)
- 1 server, 1 router, 2 switches, 2 wireless APs
- UPS units, NAS storage, backup drives, printers, monitors

Full table with Asset IDs and quantities is in `EnterpriseInfrastructurePlan.docx` / PDF.

## Software Inventory Summary
Windows 11 Pro on workstations, Ubuntu Server on the server, Microsoft Office, VS Code, Git, GitHub Desktop, VirtualBox, Chrome, Microsoft Defender, AnyDesk, and 7-Zip.

## Network Diagram
![Network Diagram](diagrams/NovaTech_Network_Diagram.png)

Flow: Internet -> ISP Modem -> Router -> Firewall -> Core Switch -> Server / Printer / Wireless AP / department groups (IT, HR, Finance, Sales).

Diagram file: `diagrams/NovaTech_Network_Diagram.drawio` (open with draw.io).

## Technologies Used
Draw.io, Microsoft Word, Git/GitHub, Ubuntu Server, Windows 11 Pro

## Challenges Encountered
The hardest part was making the network diagram actually make sense - figuring out where the firewall should go and how to group the departments without it looking cluttered.

## Reflection
Full reflection is in the main document (Part 8), but basically this project taught me that planning has to come before buying anything, and that the different IT roles (helpdesk, network, Linux, cloud admin) work more closely together than I thought.

## References
- Cisco Networking Academy
- CompTIA A+/Network+/Linux+ objectives
- Ubuntu Server Docs - https://ubuntu.com/server/docs
- draw.io Docs - https://www.drawio.com/doc/

---
Part of the BSIT-SystemAdministration-Portfolio repo - Week 2.
