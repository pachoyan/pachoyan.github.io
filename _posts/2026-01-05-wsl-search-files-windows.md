---
title: Find and Manipulate WSL Linux Files and Directories from Windows
description: >-
  Learn how to manipulate files on WSL Linux from Windows itself.
author: pachoyan
date: 2025-12-29 22:00:00 +0800
categories: [windows, wsl, linux, terminal]
tags: [windows, wsl, linux, terminal, wsl-series]
image: /images/2026-01-05-wsl-search-files-windows/preview.png
pin: false
---

## Introduction

WSL Linux on Windows is simply mounted as a volume, so accessing the files and directories from Windows is possible.

It is not recommended to work directly on those, like for example openning Visual Studio Code Folder from there, but it is useful for simplicity.

## Paths

The mounted path from WSL in windows is `\\wsl.localhost\{Distribution}\`. So if you have Ubuntu as the main distribution the path would be `\\wsl.localhost\Ubuntu\home\{user}`

## Windows File Explorer

If you open the `File explorer` and go to `\\wsl.localhost\Ubuntu\home\my-user` you will see the wsl files in Windows File Explorer.

You can now navigate in the File Explorer as you would do with Windows. You can also save favorite paths for later if necessary.

## Windows Terminal

If you'd like to cd (move to directory) from Windows (PowerShell, Nushell or Command Prompt) you can use the WSL Path to do it.

For example, from Windows PowerShell you could run

```bash
cd '\\wsl.localhost\Ubuntu\home\my-user'
```

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> When running cd from windows the wsl path must be escaped with single quotes `'`.
{: .prompt-warning }
<!-- markdownlint-restore -->

You can also do normal ops like copying a file from the wsl file system to windows f.e.:

```bash
cp my-file.txt C:/Users/my-user/Downloads/
```

## Extras

### Flow launcher

On Windows, Install Flow Launcher using [scoop.sh](https://scoop.sh/#/).

```bash
scoop bucket add extras
scoop install extras/flow-launcher
```

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> When flow-launcher is running open it by pressing `Alt+Space`.
{: .prompt-tip }
<!-- markdownlint-restore -->

Then from your WSL Ubuntu distribution:

- Install zsh

```bash
sudo apt install zsh -y
```

- Install fd-find

```bash
sudo apt install fd-find
```

- Install [WSL File Search Plugin](https://www.flowlauncher.com/plugins/wsl-file-search-e4d1c3a7-b8f3-45d2-b5fa-5a3c8c0a1f41/).

Then when opening Flow Launcher (Alt+Space) type `wslf` with space followed by the folder (f.e. `project-go`).

Then press `Enter` or `Alt+F{Number}` to open the File Explorer on the path selected.
