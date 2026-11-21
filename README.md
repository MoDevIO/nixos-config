# NixOS Configuration

[![Dynamic JSON Badge](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FMoDevIO%2Fnixos-config%2Frefs%2Fheads%2Fmain%2Fmachines.json&query=%24.length&style=for-the-badge&label=Managed%20Machines&color=A09ABC)](https://github.com/MoDevIO/nixos-config/blob/main/machines.json) [![Dynamic JSON Badge](https://img.shields.io/badge/dynamic/json?url=https%3A%2F%2Fraw.githubusercontent.com%2FMoDevIO%2Fnixos-config%2Frefs%2Fheads%2Fmain%2Fservers.json&query=%24.length&style=for-the-badge&label=Managed%20Servers&color=B6A6CA)](https://github.com/MoDevIO/nixos-config/blob/main/servers.json) [![GitHub commit activity](https://img.shields.io/github/commit-activity/t/MoDevIO/nixos-config?style=for-the-badge&color=D5CFE1)]()

My personal NixOS configuration, managed declaratively with Nix flakes.

## Overview

- **NixOS** – Declarative system configuration
- **Home Manager** – User environment and dotfiles
- **sops** –  Secrets management
- **Hyprland** – Window Manager

## Hosts

| Host | Type | Architecture |
|---|---|---|
| `t14` | Laptop | x86_64-linux |
| `x1` | Laptop | x86_64-linux |
| `mopc` | Desktop | x86_64-linux |
| `nixser1` | Server | x86_64-linux |

## Usage

List available configurations:

```bash
nix flake show
```

Build a system configuration:

```bash
nh os build .#t14
```

Switch to a configuration:

```bash
nh os switch .#t14
```

## Structure

```text
.
├── flake.nix
├── flake.lock
├── machines.json
├── servers.json
├── hosts/
├── modules/
└── overlays/
```

---

My personal configuration, configured with Nix.




