---
title: WSL Configure Alacritty on Windows for WSL
description: >-
  Setup Alacritty to Work with WSL Default on Windows
author: pachoyan
date: 2025-12-30 20:00:00 +0800
categories: [windows, wsl, linux, ubuntu, nix, terminal, alacritty]
tags: [windows, wsl, linux, ubuntu, wsl-series]
image: /images/2025-12-30-wsl-configure-alacritty-windows/preview.png
pin: false
---

## Introduction

Windows Terminal can feel sluggish inside WSL; [Alacritty](https://alacritty.org/) stays far more responsive, so use it on Windows and point it directly at your Ubuntu distribution.

## Install

Install Alacritty using winget, scoop or downloading the installer from the [website](https://alacritty.org/)

Scoop:

```bash
scoop install extras/alacritty
```

Winget:

```bash
winget install -e --id Alacritty.Alacritty
```

## Configure Fonts

Install Nerd Fonts for maximum compatibility with Alacritty configuration:

The easiest way is to install it using scoop:

```bash
scoop install nerd-fonts/JetBrainsMono-NF
```

## Configure Alacritty

Drop the following config into `C:\Users\<you>\AppData\Roaming\alacritty\alacritty.toml` (or copy the provided template from `/mnt/c/Users/{username}/AppData/Roaming/alacritty/alacritty.toml`):

```toml
[window]
dimensions = { columns = 100, lines = 40 }
padding = { x = 10, y = 10 }
dynamic_padding = true
decorations = "Full"
opacity = 1.0
blur = true
startup_mode = "Windowed"
title = "Alacritty"
dynamic_title = false
decorations_theme_variant = "Dark"
resize_increments = false
level = "Normal"

[scrolling]
history = 20000
multiplier = 3

[font]
normal.family = "JetBrainsMono Nerd Font"
bold.family = "JetBrainsMono Nerd Font"
italic.family = "JetBrainsMono Nerd Font"
bold_italic.family = "JetBrainsMono Nerd Font"
size = 12
offset = { x = 0, y = 0 }

[terminal]
shell = { program = "wsl", args = ["-d", "Ubuntu", "--cd", "~"] }
```

## Run Alacritty

Now, once you open Alacritty, WSL Ubuntu distribution will be open automatically if configured.

You can change `shell = { program = "wsl", args = ["-d", "Ubuntu", "--cd", "~"] }` to any distribution you have installed if you prefer.
