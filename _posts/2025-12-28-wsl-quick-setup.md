---
title: WSL Quick Setup
description: >-
  Quick WSL Setup
author: pachoyan
date: 2025-12-28 20:00:00 +0800
categories: [windows, wsl, linux, ubuntu]
tags: [windows, wsl, linux, ubuntu, wsl-series]
image: /images/2025-12-28-wsl-quick-setup/preview.png
pin: false
---

## Introduction

WSL or Windows Susbsystem for Linux is a Microsoft Windows feature that let developers run a Linux Environment on Windows. WSL2 includes a real Linux Kernel.

To learn more about it, read [here](https://learn.microsoft.com/en-us/windows/wsl/about).

## Initial Configuration

On Windows `$HOME` folder create a file `.wslconfig`

```bash
Set-Location $HOME
New-Item -Path ".wslconfig" -ItemType File
```

Then add the following to `.wslconfig`

```toml
[wsl2]
networkingMode=mirrored
```

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> To learn more about .wslconfig go to [official docs](https://learn.microsoft.com/en-us/windows/wsl/wsl-config#wslconfig)
{: .prompt-tip }
<!-- markdownlint-restore -->

## Install WSL

Open PowerShell in admin mode and run

```bash
wsl --install -d Ubuntu
```

After logging in you will need to:

- Create default user (leave it with default Windows user)
- Set Password (use Windows PIN for convenience)

If already installed, check you are using a `wsl2` version first

```bash
wsl --version

# WSL version: 2.6.1.0
```

By default, the installed Linux Distribution will be Ubuntu. To keep it simple we will work with Ubuntu.
Check the distribution has been installed by running

```bash
wsl --list

# Windows Subsystem for Linux Distributions:
# Ubuntu (Default)
```

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> You can install other distributions at the same time. When running `wsl --list` you will see `(Default)` on the main one
{: .prompt-tip }
<!-- markdownlint-restore -->


## WSL Ubuntu Configuration

Check that `systemd` is enabled

```bash
 cat /etc/wsl.conf
```

You should check that `systemd=true` exists

```toml
[boot]
systemd=true
```

Disable `interop/appendWindowsPath` in `/etc/wsl.conf` (this includes binaries from Windows on your shell `PATH`) to avoid Windows Binary clashes.
Ideally, the system should run all by itself, but if you prefer you can leave it as `true`.

```toml
[interop]
enabled = true
appendWindowsPath = false
```

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> To learn more about /etc/wsl.conf go the [official docs](https://learn.microsoft.com/en-us/windows/wsl/wsl-config#wslconf)
{: .prompt-tip }
<!-- markdownlint-restore -->

## Initial WSL Ubuntu Configuration

Update apt

```bash
sudo apt-get update
```

Install core utils

```bash
sudo apt-get install -y sudo gpg wget vim curl xz-utils wslu ca-certificates systemd systemd-sysv dbus
```

Install build essentials (`gcc`, `make`, `perl`, etc)

```bash
sudo apt install -y build-essential
```

Log out, wait at least 8 seconds and log in again

```bash
exit
wsl -t Ubuntu

# wait at least 8 seconds
wsl -d Ubuntu
```

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> If you wonder why 8 seconds, read [The 8 second rule for configuration changes](https://learn.microsoft.com/en-us/windows/wsl/wsl-config#the-8-second-rule-for-configuration-changes) from microsoft
{: .prompt-tip }
<!-- markdownlint-restore -->

You are now good to go!
