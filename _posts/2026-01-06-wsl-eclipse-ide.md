---
title: Install and Use Eclipse IDE on Windows WSL
description: >-
  Use Eclipse IDE for Windows WSL Development Guide
author: pachoyan
date: 2026-01-04 22:00:00 +0800
categories: [windows, wsl, linux, editor, ide]
tags: [windows, wsl, linux, terminal, editor, eclipse-ide, wsl-series]
image: /images/2026-01-06-wsl-eclipse-ide/preview.png
pin: false
---

## Introduction

Eclipse IDE is one of the most popular Java IDE(s) hated and loved by the community.

Although nowadays feels a bit out of date, still is a good IDE for Java developers that do not want to go into Jetbrains IDEs (IntelliJ IDEA).

## Installation

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> If you intend to install eclipse using nix, note that an error occurs when launching the project ecp which remains unresolved. Only proceed if you’d like to fix this.
{: .prompt-warning }
<!-- markdownlint-restore -->

### How To

Install Java First

```bash
sudo apt update
sudo apt install default-jdk
```

Download eclipse

```bash
wget https://mirror.umd.edu/eclipse/technology/epp/downloads/release/2025-09/R/eclipse-rcp-2025-09-R-linux-gtk-x86_64.tar.gz --output-document eclipse-rcp-2025-09-R-linux-gtk-x86_64.tar.gz
```

Uncompressed file to `.local/share/eclipse`

```bash
tar -xvzf eclipse-rcp-2025-09-R-linux-gtk-x86_64.tar.gz
mkdir -p ~/.local/share/eclipse
mv eclipse ~/.local/share/eclipse/rcp-2025-09
```

Add it to your `PATH` environment variable

- bash & zsh

```bash
PATH="~/.local/share/eclipse/rcp-2025-09:$PATH"
```

- fish

```bash
fish_add_path ~/.local/share/eclipse/rcp-2025-09
```

## Launch Eclipse

Launching Eclipse on WSL is not as easy as doing it on Native Windows.

```bash
nohup sh -c eclipse >/dev/null 2>&1 & disown
```

Create an alias

- bash & zsh

```bash
alias eclipse-app=`nohup sh -c "$cmd" >/dev/null 2>&1 & disown`
```

- fish

Create eclipse-app function

```bash
touch ~/.config/fish/functions/eclipse-app.fish
```

Add the following

```bash
function eclipse-app --description "Eclipse IDE"
  nohup sh -c "$cmd" >/dev/null 2>&1 & disown
end
```

## Troubleshooting

Eclipse GUI inside WSL can be buggy. For example, the windows can get stuck and there's no way of killing it. 

In order to do that find the parent java process and kill it.
