---
title: Configure Windows Terminal for WSL
description: >-
  Setup Windows Terminal to Work with WSL
author: pachoyan
date: 2025-12-29 12:00:00 +0800
categories: [windows, wsl, linux, ubuntu, nix, terminal, windows-terminal]
tags: [windows, wsl, linux, ubuntu, wsl-series]
image: /images/2025-12-29-wsl-configure-windows-terminal/preview.png
pin: false
---

## Introduction

[Windows Terminal](https://github.com/microsoft/terminal) is the modern and default terminal created by Microsoft. It is the replacement for the old one and fully compatible with WSL and PowerShell.

Microsoft has open sourced the terminal, it is fully configurable via a JSON file and works very well with Windows features like PowerShell, Command Prompt or WSL.

If you are still using the old Terminal, do not hetistate in switching to the new one.

## Install

Install Windows Terminal using winget if not installed (it should already be installed in newer Windows versions)

Winget:

```bash
winget install -e --id Microsoft.WindowsTerminal
```

## Configure Fonts

Install Nerd Fonts for maximum compatibility with Wezterm configuration:

The easiest way is to install it using scoop:

```bash
scoop bucket add nerd-fonts
scoop install nerd-fonts/JetBrainsMono-NF
```

## Configure Windows Terminal

Drop the following config into `C:\Users\<user>\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json`:

```json
{
    "$help": "https://aka.ms/terminal-documentation",
    "$schema": "https://aka.ms/terminal-profiles-schema",
    "actions": [],
    "copyFormatting": "none",
    "copyOnSelect": false,
    "defaultProfile": "{04453231-eab1-4519-87bc-6326bec9a27c}",
    "keybindings": 
    [
        {
            "id": "Terminal.CopyToClipboard",
            "keys": "ctrl+c"
        },
        {
            "id": "Terminal.PasteFromClipboard",
            "keys": "ctrl+v"
        },
        {
            "id": "Terminal.FindText",
            "keys": "ctrl+shift+f"
        },
        {
            "id": "Terminal.DuplicatePaneAuto",
            "keys": "alt+shift+d"
        }
    ],
    "newTabMenu": 
    [
        {
            "type": "remainingProfiles"
        }
    ],
    "profiles": 
    {
        "defaults": {},
        "list": 
        [
            {
                "commandline": "C:\\WINDOWS\\system32\\wsl.exe --distribution Ubuntu --cd ~",
                "font": 
                {
                    "face": "JetBrainsMono Nerd Font"
                },
                "guid": "{04453231-eab1-4519-87bc-6326bec9a27c}",
                "hidden": false,
                "name": "Ubuntu",
                "startingDirectory": null
            },
            {
                "font": 
                {
                    "face": "JetBrainsMono Nerd Font"
                },
                "guid": "{574e775e-4f2a-5b96-ac1e-a2962a402336}",
                "hidden": false,
                "name": "pwsh (winget)",
                "source": "Windows.Terminal.PowershellCore"
            },
            {
                "commandline": "%SystemRoot%\\System32\\WindowsPowerShell\\v1.0\\powershell.exe",
                "font": 
                {
                    "face": "JetBrainsMono Nerd Font"
                },
                "guid": "{61c54bbd-c2c6-5271-96e7-009a87ff44bf}",
                "hidden": false,
                "name": "Windows PowerShell"
            },
            {
                "commandline": "%SystemRoot%\\System32\\cmd.exe",
                "guid": "{0caa0dad-35be-5f56-a8ff-afceeeaa6101}",
                "hidden": false,
                "name": "S\u00edmbolo del sistema"
            }
        ]
    },
    "schemes": 
    [
        {
            "background": "#24273A",
            "black": "#494D64",
            "blue": "#8AADF4",
            "brightBlack": "#5B6078",
            "brightBlue": "#8AADF4",
            "brightCyan": "#8BD5CA",
            "brightGreen": "#A6DA95",
            "brightPurple": "#F5BDE6",
            "brightRed": "#ED8796",
            "brightWhite": "#A5ADCB",
            "brightYellow": "#EED49F",
            "cursorColor": "#F4DBD6",
            "cyan": "#8BD5CA",
            "foreground": "#CAD3F5",
            "green": "#A6DA95",
            "name": "Catppuccin Macchiato",
            "purple": "#F5BDE6",
            "red": "#ED8796",
            "selectionBackground": "#5B6078",
            "white": "#B8C0E0",
            "yellow": "#EED49F"
        },
        {
            "background": "#1E1E2E",
            "black": "#45475A",
            "blue": "#89B4FA",
            "brightBlack": "#585B70",
            "brightBlue": "#89B4FA",
            "brightCyan": "#94E2D5",
            "brightGreen": "#A6E3A1",
            "brightPurple": "#F5C2E7",
            "brightRed": "#F38BA8",
            "brightWhite": "#A6ADC8",
            "brightYellow": "#F9E2AF",
            "cursorColor": "#F5E0DC",
            "cyan": "#94E2D5",
            "foreground": "#CDD6F4",
            "green": "#A6E3A1",
            "name": "Catppuccin Mocha",
            "purple": "#F5C2E7",
            "red": "#F38BA8",
            "selectionBackground": "#585B70",
            "white": "#BAC2DE",
            "yellow": "#F9E2AF"
        }
    ],
    "themes": 
    [
        {
            "name": "Catppuccin Macchiato",
            "tab": 
            {
                "background": "#24273AFF",
                "iconStyle": "default",
                "showCloseButton": "always",
                "unfocusedBackground": null
            },
            "tabRow": 
            {
                "background": "#1E2030FF",
                "unfocusedBackground": "#181926FF"
            },
            "window": 
            {
                "applicationTheme": "dark",
                "experimental.rainbowFrame": false,
                "frame": null,
                "unfocusedFrame": null,
                "useMica": false
            }
        },
        {
            "name": "Catppuccin Mocha",
            "tab": 
            {
                "background": "#1E1E2EFF",
                "iconStyle": "default",
                "showCloseButton": "always",
                "unfocusedBackground": null
            },
            "tabRow": 
            {
                "background": "#181825FF",
                "unfocusedBackground": "#11111BFF"
            },
            "window": 
            {
                "applicationTheme": "dark",
                "experimental.rainbowFrame": false,
                "frame": null,
                "unfocusedFrame": null,
                "useMica": false
            }
        }
    ]
}
```

I am not a huge fan of the default WSL Ubuntu Profile, but if you prefer replace the first profile with 

```json
{
  "guid": "{a0e8cb5d-61f0-56b4-820e-c01d7a6a9637}",
  "hidden": false,
  "name": "Ubuntu",
  "source": "Microsoft.WSL"
}
```

## Run Windows Terminal

Now, once you open Windows Terminal, WSL Ubuntu distribution will be open automatically if configured. Also, you can open other profiles like PowerShell if desired.

You can change `"defaultProfile": "{04453231-eab1-4519-87bc-6326bec9a27c}"` to any profile you have installed if you prefer.

Use the guid to change the default profile.
