---
title: WSL Ubuntu Nix Setup
description: >-
  Setup Nix and Nix Flakes on Ubuntu WSL
author: pachoyan
date: 2025-12-29 10:00:00 +0800
categories: [windows, wsl, linux, ubuntu, nix]
tags: [windows, wsl, linux, ubuntu, wsl-series]
image: /images/2025-12-29-wsl-ubuntu-nix-setup/preview.png
pin: false
---

## Introduction

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> Make sure you have followed WSL Quick Setup Post first.
{: .prompt-tip }
<!-- markdownlint-restore -->

Nix and Nix flakes makes easier to install tools on Ubuntu. Although, not all of them work perfectly fine (I prefer to keep podman f.e. installed from `apt`) it makes easier to maintain the environment clean and reproducible.

- [nix](https://nixos.org/learn/) provides a package-manager with a unique declarative approach. Do not confuse with NixOs which is a Linux Distribution on its own.
- [nix flakes](https://wiki.nixos.org/wiki/Flakes) provides a standard way to use nix for installing packages easily with nix files.

## Install

Install nix multi-user with daemon

```bash
curl -L https://nixos.org/nix/install | sh -s -- --daemon
```

Log out, wait at least 8 seconds and log in again

```bash
exit
wsl -t Ubuntu

# wait at least 8 seconds
wsl -d Ubuntu
```

## Enable Flakes

Enable flakes by creating `~/.config/nix/nix.conf`

```bash
mkdir -p ~/.config/nix/
touch ~/.config/nix/nix.conf
```

Add to `~/.config/nix/nix.conf` the following (run code `~/.config/nix/nix.conf`)

```toml
experimental-features = nix-command flakes
```

Check nix flakes works

```bash
nix flake --help

nix run nixpkgs#hello

# Hello, World!
```
