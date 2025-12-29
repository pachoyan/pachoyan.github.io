---
title: WSL Find and Install different Distributions
description: >-
  Discovery Different Available Distros for WSL on Windows
author: pachoyan
date: 2025-12-29 15:00:00 +0800
categories: [windows, wsl, linux]
tags: [windows, wsl, linux, ubuntu, wsl-series]
image: /images/2025-12-28-wsl-quick-setup/preview.png
pin: false
---

## Introduction

Historically, WSL has always worked with Ubuntu - initial versions only had Ubuntu available actually.

Nowadays, on WSL2 many popular distributions are available although some do have some incompatibilities, or they are unstable, but still they are available.

We can split up the list on:

- Official Distributions: officially supported and backed by Microsoft. They can be installed directly from WSL CLI.
- Unofficial Distributions: usually open source projects or not backed by Microsoft. They can be installed as custom WSL Distros.

## Official Distributions

Easiest way to list official online available distros is by using WSL CLI itself.

Run the following

```bash
wsl --list --online
```

WSL will list you a list of available Distros:

```bash
# The following is a list of valid distributions that can be installed.
# Install using 'wsl.exe --install <Distro>'.

# NAME                            FRIENDLY NAME
# AlmaLinux-8                     AlmaLinux OS 8
# AlmaLinux-9                     AlmaLinux OS 9
# AlmaLinux-Kitten-10             AlmaLinux OS Kitten 10
# AlmaLinux-10                    AlmaLinux OS 10
# Debian                          Debian GNU/Linux
# FedoraLinux-43                  Fedora Linux 43
# FedoraLinux-42                  Fedora Linux 42
# SUSE-Linux-Enterprise-15-SP7    SUSE Linux Enterprise 15 SP7
# SUSE-Linux-Enterprise-16.0      SUSE Linux Enterprise 16.0
# Ubuntu                          Ubuntu
# Ubuntu-24.04                    Ubuntu 24.04 LTS
# archlinux                       Arch Linux
# kali-linux                      Kali Linux Rolling
# openSUSE-Tumbleweed             openSUSE Tumbleweed
# openSUSE-Leap-16.0              openSUSE Leap 16.0
# Ubuntu-20.04                    Ubuntu 20.04 LTS
# Ubuntu-22.04                    Ubuntu 22.04 LTS
```

In order to install any of those distributions use `wsl --install <Name of Distro>`.
For example, to install Debian:

```bash
wsl --install Debian
```

Then log in by running

```bash
wsl -d Debian
```

## Unofficial Distributions

There are several ways of finding unofficial distros. 

A trusted one is using [scoop.sh](https://scoop.sh/). For example by searching `wsl`

As for the moment, the distros you can install using scoop are

- [alpinewsl](https://github.com/yuk7/AlpineWSL)
- [archwsl](https://github.com/yuk7/ArchWSL)

Install them by simply running

```bash
scoop install extras/alpinewsl
scoop install extras/archwsl
```

The other one is by simply searching on GitHub or Google.

One of the most interesting unofficial distros I found is `NixOS`. You can install it by following the steps on the [README.md](https://github.com/nix-community/NixOS-WSL).

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> Keep in mind that most distributions that can run on Docker can be set up as a WSL Distro with a few extra steps.
{: .prompt-tip }
<!-- markdownlint-restore -->

## Distribution Manager

A quick way to manage your Distributions is by using [wsl2-distro-manager](https://github.com/bostrot/wsl2-distro-manager).

If you prefer to use a simple GUI with capabilities like searching distros or running them from docker images, I totally recommended.

Install it using scoop or winget

Scoop:

```bash
scoop install extras/wsl2-distro-manager
```

Winget:

```bash
winget install Bostrot.WSLManager
```
