# BIOS vs UEFI

## BIOS vs UEFI

Jaymark Viriña | ITEP 414 | Week 3 | 26 October 2026

| Area | Legacy BIOS | UEFI |
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

Research comparison [7-9]. UEFI/GPT is the preferred baseline in this guide; record the mode and layout actually installed. The next page is the one-page explanation.

## Why UEFI replaced legacy BIOS

UEFI has largely replaced legacy BIOS because modern systems need more flexible boot and storage support than the original PC design provided. Legacy BIOS usually starts disk boot code and relies on a chain of small loaders. UEFI can instead select an EFI program using stored boot entries. This gives the firmware a clearer way to find an installed operating system and makes it easier to support several boot choices. [7]

Disk size is one practical reason for the change. The familiar limit of about 2 TiB comes from an MBR layout with 512-byte logical sectors. It should not be described as the maximum capacity of every BIOS computer. GPT supports much larger disks and more flexible partition layouts. UEFI and GPT are commonly used together, but they are different technologies: one is firmware and the other describes disk partitions. Linux can use GPT with a BIOS-mode GRUB setup. Windows requires GPT for its UEFI system disk. [8,9]

Security is another difference. On a system with Secure Boot enabled, the firmware checks whether a boot component is trusted before running it. That helps reduce the chance of some boot-level malware loading before the operating system can defend itself. However, UEFI alone does not prove that Secure Boot is enabled, and Secure Boot is not a replacement for updates, account controls or backups. The settings and trust keys still need to be managed correctly. [7]

UEFI can also make startup more efficient, but it would be misleading to promise that every UEFI machine boots faster. A slow disk, a firmware delay, a network boot timeout or an operating system service can still hold up startup. For a fair comparison, the same workload and hardware should be tested. On a Linux system, examining service startup can be more useful than assuming that the firmware explains all of the delay.

For the Week 3 VM, I would choose UEFI before installing Ubuntu and record that decision. The installer can then prepare the boot files for that mode. After installation, checking /sys/firmware/efi tells me how the running guest booted; the partition table and filesystem can be checked separately. Changing the VM from BIOS to UEFI after installation may prevent the existing loader from starting, so firmware mode should be part of the deployment record.

The main benefit is a boot environment that fits modern operating systems and hardware. Legacy BIOS still matters when maintaining older equipment. An administrator should understand both paths, use the mode supported by the system, and keep enough information to diagnose a startup failure.

## References

**[7] UEFI Forum. UEFI FAQs.** [https://uefi.org/faq](https://uefi.org/faq). Firmware interfaces, boot support and Secure Boot.

**[8] Microsoft Learn. Convert a disk to GPT or MBR partition scheme.** [https://learn.microsoft.com/en-us/windows-server/storage/disk-management/change-disk-partition-scheme](https://learn.microsoft.com/en-us/windows-server/storage/disk-management/change-disk-partition-scheme). MBR limitations and GPT capabilities.

**[9] Microsoft Learn. Windows and GPT FAQ.** [https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/windows-and-gpt-faq?view=windows-11](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/windows-and-gpt-faq?view=windows-11). UEFI/GPT relationships and Windows-specific limitations.

**[10] GNU Project. GNU GRUB Manual.** [https://www.gnu.org/software/grub/manual/grub/grub.html](https://www.gnu.org/software/grub/manual/grub/grub.html). Bootloader, Linux kernel and initial RAM disk.

**[11] systemd project. bootup.** [https://www.freedesktop.org/software/systemd/man/bootup.html](https://www.freedesktop.org/software/systemd/man/bootup.html). System manager, services and boot targets.
