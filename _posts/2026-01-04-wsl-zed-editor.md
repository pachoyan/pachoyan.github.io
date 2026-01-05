---
title: Install and Use Zed Editor on Windows WSL
description: >-
  Use Zed Editor for Windows WSL Development Guide
author: pachoyan
date: 2026-01-04 22:00:00 +0800
categories: [windows, wsl, linux, editor, ide]
tags: [windows, wsl, linux, terminal, editor, zed-editor, wsl-series]
image: /images/2026-01-04-wsl-zed-editor/preview.png
pin: false
---

## Introduction

[Zed editor](https://zed.dev/) is a modern super fast Editor written in Rust. As of today it is completely cross-platform (macOS, Linux and Windows). 
Also, it has really superb AI integrated features and it is built with collaboration with AI on mind.

It has a good plugin ecosystem although not comparable to others like VS Code. For Rust or Golang it might be the best GUI Editor out there.

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> If you intend to install it directly on your WSL Distribution, it won't work. The trick is to install it on Windows and use remote server feature.
{: .prompt-warning }
<!-- markdownlint-restore -->


## Installation

As mentioned previously, Zed Editor can be installed on WSL directly but it will fail to run due to missing GPU packages that do not work directly on WSL Distributions.

The best option is to install it directly on Windows. Install it via:

- scoop

```bash
scoop bucket add extras
scoop install extras/zed
```

- Executable: download it directly from [zed.dev](https://zed.dev/).

## Open Projects

1. Open Zed Editor from Windows.
2. Click on the top menu `File > Open Remote...` or`Ctrl+Alt+Shift+O`
3. Select the folder project within the WSL Distribution (f.e. `/home/{user}/projects/golang-project`)

This will open the folder and a terminal inside WSL which let you work from Windows using remote SSH in WSL Linux.

## Extensions

Press `Ctrl+Shift+P` and search for extensions. You will se a huge collection of useful extensions to install.

Some of the recommended ones I use is:

- HTML: html support
- Catpuccin: catpuccin theme for zed
- Catpuccin Icons: icons for zed
- Dockerfile: docker syntax support
- Make: makefile syntax highlighting
- TOML: toml syntax support
- SQL: SQL Language support
- golangci-lint: golang lint support
- Color higlight: higlight colors based on color-lsp.

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> Rust support is built-in to Zed.
{: .prompt-tip }
<!-- markdownlint-restore -->

## Terminal

A terminal built-in on editors and IDE(s) is quite helpful when someone does not want to be switching windows. I personally have open my Alacritty Terminal and work on both. But sometimes for quick commits I simply use the terminal that is built-in on Zed.

Use:

- Press _Ctrl+`_ to open the WSL Linux Terminal. Depending on your default shell it will open your configured environment.
- Also pressing _Ctrl+J_ will toggle the bottom dock as it is configured in that position by default.
- To open it manually search the bottom bar on the right.

## Agent and AI Features

Zed comes with built-in agent/ai features in the editor. You can the most popular providers: codex (from chatgpt), claude, github copilot chat, etc.

Use: 

- Press `Ctrl+Alt+B`
- To open it manually search the bottom bar on the right.

Configure LLM Providers and MCP in the settings tab itself.
