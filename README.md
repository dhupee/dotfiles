# Dhupee's Nix configurations Repository

<!--toc:start-->

- [Dhupee's Nix configurations Repository](#dhupees-nix-configurations-repository)
  - [What is this](#what-is-this)
  - [Screenshots](#screenshots)
  - [File Structure](#file-structure)
  - [Installation](#installation)
  - [References for me](#references-for-me)
  - [To-Do List](#to-do-list)
  <!--toc:end-->

> [!IMPORTANT]
> I USE NIXOS, BTW

## What is this

This is my new dotfiles that I will use in the next few years or might be my last dotfiles repo, this repo is not only for NixOS, but also for Android, HELL EVEN WINDOWS SUBSYSTEM FOR LINUX NOW!!! and maybe hopefully servers and Macs if i have money.

I use combination of chezmoi for dealing with sensitive files that need to be kept secret, and Home-manager for managing my home configuration.

This repo is intended to combine my existing setup but also new Nix paradigm, not only to not shackled so much with Nix, but enables me to use some of my configurations on random Servers or PC that might be thrown at me to be worked on without actually have to deal with NixOS.

## Screenshots

TBA

## File Structure

This is how I structure my nix-configs currently, it might will have few more diretories in the future.

the naming scheme is auto generated by Chezmoi, so don't be surprised.

on the front you will have:

- `dot_distrobox-recipe`, my recipe for distroboxes I might use, the command is long so having that is neat.
- `dot_scripts`, my scripts which mostly bash scripts, carry over from my old dotfiles.
- `mutable-configs`, configs that is mutable, not worth it to be carried to home directory since it will changed a lot, will be symlinked by the home-manager depend on what i need.
- `private_dot_nix-configs`, my actual NixOS configs.
- `private_dot_secrets`, well...encrypted files, configs, secrets
- `private_dot_ssh`, obviously...my ssh key
- `Templates`, templates of files...maybe not a lot that I added atm.
- `Wallpapers`, Waifu and car picture for Wallpapers

then when it comes to my actual `.nix-configs`, the directories looks like this.

- `aliases`, my aliases...also carried from my old dotfiles.
- `configs`, mostly my configuration files of packages, tried not to use nix for this so I can use it on non Nix systems.
- `droids`, configurations for `Nix On Droid`, NixOS but for Android (a Termux-based app)
- `home`, my home-manager configs, tried to seperate from systems as much as possible
- `linux`, my systems configs for NixOS
- `machines`, mostly for backups but it's collection of hardware-configurations.
- `modules`, modules of nix configs, seperated by systems and home-manager ofc.
- `theming`, modules for my ricing, has Gnome, KDEPlasma 6, maybe Hyprland if I want a neckbeard.
- `users`, modules for users, if there's more than me, or if I need a user for specific machines.
- `wsl`, modules specifically for NixOS config on Windows Subsystem for Linux

This thing obviously can change overtime as this dotfiles grow.

## Installation

ofc, i will assumed you to have nix installed with it's channel exist

run this command to get my dotfiles:

```nix
nix-shell -p chezmoi git --run "chezmoi init dhupee"
```

then you add my Age key to the home directory, if you don't know, rob me. After that you run:

```nix
chezmoi apply
```

This will decrypt encypted files, and send the directories to targeted place, then `switch` your NixOS and Home-Manager, in `.nix-configs` directory run this:

```nix
sudo nixos-rebuild switch --flake .#nitro
home-manager switch --flake .#dhupee
```

that will rebuild the systems into `nitro` profile, and `dhupee` home-manager profile and that will bring every tooling and ricing I have on such profile.

## References for me

- [Partitioning NixOS with Disko](https://jefftp.com/nixos-disko/)
- [NixOS on WSL Github Repository](https://github.com/nix-community/NixOS-WSL)
- [Nix Shorts, A collection of short notes about Nix, down to what is immediately needed for users.](https://github.com/justinwoo/nix-shorts)
  - [Your First Derivation](https://github.com/justinwoo/nix-shorts/blob/master/posts/your-first-derivation.md)

## Tools I use in this dotfiles

TBA

## To-Do List

- [x] ~~Neovim modules with nixvim, finished then migrate fully~~ Managed use most of my old configs with something left behind for now
- [x] Vscode modules also
- [x] Migrating few of my scripts from old dotfiles
- [x] KDE Plasma Ricing, using Plasma-Manager, will do it once I actually have time
- [x] ~~Make a command and control like for managing nix, built in go, name Yuki~~ Not sure if i need super command and control anyway
- [x] Utilizing rootless Nix
- [ ] NixOS profile specifically for Klipper Servers, for my 3D printer
