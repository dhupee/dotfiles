# USB Toolkit

> [!IMPORTANT]
> This toolkit targets Windows, simply because it's the most common desktop OS I'm likely to encounter on unfamiliar machines. For Unix-like environments, [nix-portable](https://github.com/DavHau/nix-portable) is another option for running Nix without a system-wide installation. This toolkit is intended to be used alongside a USB drive prepared with [Ventoy](https://www.ventoy.net/en/).

<!--toc:start-->
- [USB Toolkit](#usb-toolkit)
  - [Overview](#overview)
    - [Motivations](#motivations)
  - [Important Notes](#important-notes)
  - [Tools List](#tools-list)
    - [Installed Using PortableApps](#installed-using-portableapps)
    - [Downloaded or Configured Manually](#downloaded-or-configured-manually)
<!--toc:end-->

---

## Overview

The USB Toolkit is an extension of my dotfiles. It keeps a selection of portable applications and useful tools on a USB drive, so I can access a familiar working environment even when I'm away from my own computer.

The idea is simple: I don't always have access to my own machine, but that doesn't mean I should have to start from scratch every time I need to get something done.

---

### Motivations

There are a few situations where having this toolkit makes sense:

- **Lab PCs:** Access the tools I need on shared or unfamiliar computers.
- **Development on the go:** Carry essential development tools without relying entirely on whatever is installed on the host.
- **Hardware failure:** Keep a basic working environment available if my main PC breaks or becomes unavailable.
- **Recovery:** Have a selection of useful utilities ready when I need to troubleshoot or work on another machine.

Ventoy makes a USB drive useful as a multiboot device, but booting into a separate operating system isn't always practical. Sometimes I just need a browser, a text editor, or a few utilities inside the Windows session that's already running.

This toolkit is meant to cover those situations without turning the USB drive into another full operating-system installation.

---

## Important Notes

- **Use a sufficiently fast drive.** A reasonably performant flash drive with at least 128 GB of storage is my baseline. Slow storage makes portable applications and larger tools less pleasant to use.
- **Plan for the host machine.** Some tools may require internet access, additional permissions, or a longer setup process. A portable application doesn't automatically bypass restrictions imposed by the host.
- **Keep the toolkit focused.** The applications listed below are the baseline essentials. Anything else is optional and can be added when a specific task calls for it.
- **Keep personal data in mind.** A portable environment is convenient, but it also makes it easier to leave credentials, configuration files, or other sensitive data on a shared machine.
- **Refer to the main [README](./README.md)** for the broader dotfiles setup, including Scoop and its cleanup procedure.

---

## Tools List

The following is my baseline list of applications to keep on the USB drive. The goal isn't to carry every application I use, but to have enough tools to handle common tasks without needing to install everything from scratch.

### Installed Using PortableApps

[PortableApps](https://portableapps.com/) provides a convenient way to organize and run portable applications from the USB drive without installing each application separately on the host.

My baseline selection is:

- 7-Zip
- Firefox
- gVim
- LibreOffice
- PuTTY
- qBittorrent
- VLC

### Downloaded or Configured Manually

These tools are handled separately because I prefer their own deployment methods, or because their requirements differ from the applications managed through PortableApps.

- [Visual Studio Code](https://code.visualstudio.com/docs/setup/portable) - development environment.
- [Bitwarden](https://bitwarden.com/) - password management.
- [Git for Windows](https://git-scm.com/install/windows) - version control and command-line workflows.
- [LocalSend](https://localsend.org/) - local file transfers between supported devices.

The exact setup may change as I find better ways to keep the toolkit portable and useful across different machines.
