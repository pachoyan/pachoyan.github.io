---
title: "WINDOWS: Scoop Windows Package Manager Quickstart"
slug: windows-package-manager-scoop-quickstart
description: >-
  Quick Introduction to Windows scoop package manager
author: pachoyan
date: 2026-02-06 20:00:00 +0800
categories: [terminal, cli]
tags: [terminal, cli, package-manager, scoop]
image: /images/2026-02-06-windows-package-manager-scoop-quickstart/preview.png
pin: false
---

## Introduction

[scoop](https://scoop.sh/) is a popular package manager for Windows. It is a powerful package-manager with linux like feelings.

- Keeps your PATH clean
- Avoids windows permission-popup by installing portable binaries.
- Simple and powerful

## Recommended requirements

We will use `winget` which is the official Microsoft Windows package-manager to install a few recommended dependencies first.

Open a terminal and run:

```bash
winget install -e --id Microsoft.WindowsTerminal
```

We will install PowerShell from Winget to avoid scoop having a conflict with the pwsh installed by scoop

```bash
winget install --id Microsoft.PowerShell --source winget
```

Install `Git` from `winget` also if possible

```bash
winget install -e --id Git.Git
```

## Install scoop

Open a PowerShell terminal and run

```bash
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

This will install scoop and will be available on your 

### Scoop Buckets

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> scoop `main` bucket is added by default when installed. In the following example we will add it again.
{: .prompt-tip }
<!-- markdownlint-restore -->

scoop splits different binaries and apps in buckets - a bucket is a repository containing app manifests.

In order to add buckets, we need to run `scoop bucket add {bucket-name}`

The recommended buckets for an initial setup are:

```bash
scoop bucket add main
scoop bucket add extras
scoop bucket add versions
scoop bucket add noportable
scoop bucket add nerd-fonts
```

Also, if you are a Java developer would be recommended to add `java` bucket

```bash
scoop bucket add java
```

For non-official buckets you can still add those by running `scoop bucket add {alias} {git-url}`

For example, to add tiltdev bucket and install tilt, run

```bash
scoop bucket add tilt-dev https://github.com/tilt-dev/scoop-bucket
scoop install tilt-dev/tilt
```

## Install recommended apps

scoop installs apps by running `scoop install {bucket-name}/{app-name}`

It is recommended to install these apps for the initial setup

```bash
scoop install main/git
scoop install main/curl
scoop install main/7zip
```

Also, recommended to install

```bash
scoop install main/aria2 # if you'd like to speed downloads
```

## Update apps

Updating apps on scoop is quite simple. First, you need to keep scoop buckets up to date by running

```bash
scoop update
```

Then you can individually update an app by running `scoop update {app-name}`

For example, to update git run

```bash
scoop update git
```

If you prefer to update all the apps at once, you can run

```bash
scoop update *
```

Also, if you'd like to know what apps can be updated after updating your buckets, you can run 

```bash
scoop status

# Name   Installed Version Latest Version Missing Dependencies Info
# ----   ----------------- -------------- -------------------- ----
# nu     0.108.0           0.110.0                             
# podman 5.4.2             5.7.1                               
```

Finally, it is recommended to hold apps you don't want to update that often. 

```bash
scoop hold podman
```
Then if you run `scoop status` you will see they are marked as held

```bash
❯ scoop status

# Name   Installed Version Latest Version Missing Dependencies Info
# ----   ----------------- -------------- -------------------- ----
# podman 5.4.2             5.7.1                               Held packag
```
