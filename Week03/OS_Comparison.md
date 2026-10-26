# Windows Server, Ubuntu Server and Rocky Linux

Research comparison; no benchmark claimed.

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

## Discussion

An operating system should be selected for the applications and people it must support. Windows Server, Ubuntu Server and Rocky Linux can all run useful business services, but they fit different environments. The comparison here is based on their documented features, not on a benchmark carried out on these VMs.

Windows Server makes sense when an organization depends on Microsoft services or applications. Active Directory Domain Services, Windows administration tools and policy integration can simplify work for an IT team already using that environment. Desktop Experience provides a GUI, while Server Core avoids the full desktop. The evaluation image is useful for this classroom installation, but its 180-day evaluation period is not a permanent production license. A real deployment needs the correct edition and applicable access licensing. [12,19]

Ubuntu Server is a practical starting point for NovaTech's Linux lab. It provides a command-line environment for learning users, networking, storage, package updates and SSH. APT is used to manage deb packages, and the server can later host web applications or databases. AppArmor adds application confinement. The LTS release is suitable when a stable maintenance path matters. However, the administrator still needs to configure services, apply updates and monitor the system; choosing Linux does not do that work automatically. [1,6,18]

Rocky Linux is another option for enterprise Linux work, especially where the team or application expects the RPM/DNF ecosystem. Its tools and SELinux policies differ from Ubuntu, so procedures should not be copied without checking commands and paths. A team moving from another RHEL-family environment may find this approach familiar. Compatibility and vendor support still need to be checked for the exact application and release. [15-17]

Performance should be tested instead of guessed from the operating system name. A GUI, background roles, storage speed, VM memory and the application itself can all affect results. A fair comparison would use similar resources and measure the same task, such as response time for the same web application. No such measurements are claimed in this report.

For this project, Ubuntu is the main deployment exercise and Windows Server is a separate evaluation VM. Rocky Linux is researched for the comparison; its installation is not required by the activity. I would keep the VMs separate and run one at a time if host resources are limited. The final choice for a real company should depend on application support, staff skills, licensing, security requirements and the cost of maintaining the service.

Sources are numbered in [references/Sources.md](references/Sources.md).
