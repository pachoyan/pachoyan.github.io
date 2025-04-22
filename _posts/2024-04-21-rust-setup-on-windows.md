---
title: Rust setup on Windows - Using rustup
description: >-
  Setup Rust on Windows step by step
author: pachoyan
date: 2025-04-21 20:00:00 +0800
categories: [programming, rust]
tags: [programming, cli, rust]
pin: false
---

## Introduction

Rust setup on Windows might be a bit more complicated than MacOS or Linux as it might require some extra steps, although using `rustup` everything should be pretty straightforward.

## Install

Go to [rustup](https://rustup.rs/), then download and run `rustup-init-exe`

It will open a terminal and choose `1`

```bash
Rust Visual C++ prerequisites

Rust requires a linker and Windows API libraries but they don't seem to be
available.

These components can be acquired through a Visual Studio installer.

1) Quick install via the Visual Studio Community installer
   (free for individuals, academic uses, and open source).

2) Manually install the prerequisites
   (for enterprise and advanced users).

3) Don't install the prerequisites
   (if you're targeting the GNU ABI).

> 1
```

This will download `Visual Studio`, you will be required to install it by using `Admin privileges`. Select all the options to be installed.

Finally, another prompt will show, press `1`

```bash
Current installation options:


   default host triple: x86_64-pc-windows-msvc
     default toolchain: stable (default)
               profile: default
  modify PATH variable: yes

1) Proceed with standard installation (default - just press enter)
2) Customize installation
3) Cancel installation
>1
```

Finally install a toolchain and set is as default

```bash
rustup default stable-msvc
```

## Rust Versions

If you would like to install different rust versions, is really easy to deal with it using rustup

Install the versions you required, for example from the following list


```bash
rustup --help
```

To have them available on your path then just use rustup for it

```bash
rustup toolchain install stable-x86_64-pc-windows-gnu
rustup default stable-x86_64-pc-windows-gnu
```

Finally, optionally but recommended installation cmake and NASM

```bash
winget install -e --id Kitware.CMake
winget install -e --id NASM.NASM
```

## Tools

### Cargo install - Package manager

You can install packages with cargo. For example, win-env

```bash
cargo install win-env
```

### Cargo fmt (format)

Use it by running

```bash
cargo fmt
```

### Cargo build

```bash
cargo build
```

### Cargo run

```bash
cargo run
```

## IDE - Code Editors

### VSCode

For non vim experienced devs, it is recommended to use vscode for your environment.

In order to have a good setup, you will need to install extensions.

### Helix

Helix is a terminal vim-like editor that can be easily install.

### Neovim/Vim

Neovim are older terminal editors that work pretty well with rust.
