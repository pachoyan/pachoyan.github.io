---
title: Configure Wezterm on Windows for WSL
description: >-
  Setup Wezterm to Work with WSL Default on Windows
author: pachoyan
date: 2025-12-29 12:00:00 +0800
categories: [windows, wsl, linux, ubuntu, nix, terminal, wezterm]
tags: [windows, wsl, linux, ubuntu, wsl-series]
image: /images/2025-12-29-wsl-configure-wezterm-windows/preview.png
pin: false
---

## Introduction

Windows Terminal can feel sluggish inside WSL; [Wezterm](https://wezterm.org/) is a good alternative with many of the built-in features and still felling more responsive.

## Install

Install Wezterm using winget

Winget:

```bash
winget install -e --id wez.wezterm
```

## Configure Fonts

Install Nerd Fonts for maximum compatibility with Wezterm configuration:

The easiest way is to install it using scoop:

```bash
scoop bucket add nerd-fonts
scoop install nerd-fonts/JetBrainsMono-NF
```

## Configure Wezterm

Drop the following config into `C:\Users\<you>\.wezterm.lua`:

```bash
local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

local config = {}
local keys = {}
local mouse_bindings = {}
local launch_menu = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.font = wezterm.font('JetBrainsMono Nerd Font')
config.font_size = 11
config.launch_menu = launch_menu
config.disable_default_key_bindings = true
config.mouse_bindings = mouse_bindings

config.default_domain = 'WSL:Ubuntu'

return config
```

## Run Wezterm

Now, once you open Wezterm, WSL Ubuntu distribution will be open automatically if configured.

You can change `config.default_domain = 'WSL:Ubuntu'` to any distribution you have installed if you prefer.
