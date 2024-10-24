# Dhupee's Nix configurations Repository

This is my Nix configurations, which "will" be part of my dotfiles. These are configurations that I currently created on my Nix dotfiles, not only for NixOS, but also for Android, and maybe hopefully servers and Macs if i have money.

I use combination of chezmoi for dealing with sensitive files that need to be kept secret, and Home-manager for managing my home configuration.

<!--toc:start-->

- [Dhupee's Nix Dotfiles (EXPERIMENTAL)](#dhupees-nix-dotfiles-experimental)
  - [File Structure](#file-structure)
  - [Installation](#installation)
  - [To-Do List](#to-do-list)
  <!--toc:end-->

## Screenshots

TBA

## File Structure

This is how I structure my nix-configs currently, it might will have few more directories, maybe regarding theming, users, or something else in the future.

```txt
.nix-configs
├── aliases                 # Bunch of my Aliases
├── config                  # Non-nix configuration files
│   ├── alacritty
│   ├── helix
│   └── ohmyposh-droid
├── desktop                 # Systems configuration.nix files
│   └── nitro
├── droids                  # Nix on Droid configuration.nix files
├── home                    # Home-manager nix files
├── machines                # hardware-configuration.nix files, mostly for backups
│   └── virt-manager-vm
└── modules                 # modules, to make it neat
    └── home-manager
```

## Installation

TBA

## To-Do List

- [x] ~~Neovim modules with nixvim, finished then migrate fully~~ Managed use most of my old configs with something left behind for now
- [ ] Vscode modules also
- [x] Migrating few of my scripts from old dotfiles
- [ ] Theming related, KDE, Gnome, Hyprland whatever i can just change since its Nix
- [ ] Make a command and control like for managing nix, built in go, name Yuki
- [ ] Either specific nix for centralized configuration, or maybe on the flake
- [x] Utilizing rootless Nix
