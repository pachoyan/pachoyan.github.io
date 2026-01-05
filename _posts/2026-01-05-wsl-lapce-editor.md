---
title: Install and Use Lapce Editor on Windows WSL
description: >-
  Use Lapce Editor for Windows WSL Development Guide
author: pachoyan
date: 2026-01-04 22:00:00 +0800
categories: [windows, wsl, linux, editor, ide]
tags: [windows, wsl, linux, terminal, editor, lapce-editor, wsl-series]
image: /images/2026-01-04-wsl-lapce-editor/preview.png
pin: false
---

## Introduction

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> I have not successfully be able to open WSL Remote Folders using lapce. As for now, it seems the file picker for wsl has not been implemented yet.
>
> Use it at your own risk.
{: .prompt-warning }
<!-- markdownlint-restore -->

[Lapce editor](https://lap.dev/lapce/) is a modern super fast Editor written in Rust, it is the Zed alternative, although it is less polished and totally open sourced.

## Installation

As mentioned previously, Lapce Editor can be installed on WSL directly but it will fail to run due to missing GPU packages that do not work directly on WSL Distributions.

The best option is to install it directly on Windows. Install it via:

- scoop

```bash
scoop bucket add extras
scoop install extras/lapce
```

- Winget

```bash
winget install -e --id Lapce.Lapce
```

- Executable: download it directly from [https://lap.dev](https://lap.dev/lapce/).

## Open WSL Remote Projects

1. Go to `File > Open Folder`
2. In the Windows File Explorer select the WSL Path (`\\wsl.localhost\Ubuntu\home\my-user\path-to-project`)

This will only open the folder with the files but you will still work as if they were Windows File. So as you can see it is not fully compatible yet.

For a more detailed documentation visit the official docs [here](https://docs.lapce.dev/get-started/remote-development).
