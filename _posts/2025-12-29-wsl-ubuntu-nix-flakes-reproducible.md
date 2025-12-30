---
title: WSL Ubuntu Nix Flakes Reproducible Environments
description: >-
  Reproducible Environments with Nix Flakes on WSL Ubuntu 
author: pachoyan
date: 2025-12-29 22:00:00 +0800
categories: [windows, wsl, linux, ubuntu, nix]
tags: [windows, wsl, linux, ubuntu, wsl-series]
image: /images/2025-12-29-wsl-ubuntu-nix-setup/preview.png
pin: false
---

## Introduction

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> You will need to have followed [WSL Ubuntu Nix Setup first]({{ '/posts/wsl-ubuntu-nix-setup' | relative_url }}) post before.
{: .prompt-warning }
<!-- markdownlint-restore -->

Using Nix flakes you can create declarative and repoducible environments.

Install tools and apps via nix and store them on a repository.

## Create Git Repository

First, we need to create a Git Repository. 

Create a folder on `~/nix-flakes`

```bash
mkdir -p ~/nix-flakes
cd nix-flakes
```

Then intialize a repository

```bash
touch README.md

git init
git add .
git commit -m "initial commit"
```

## Create Nix Flakes

We will need to first initialize the Flake

```bash
nix flake init
git add flake.nix flake.lock
```

Add the following to `flake.nix`

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    homeConfigurations.default = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home ];
    };
  };
}
```

Then create a folder `home/` on the Repository

```bash
mkdir -p home
```

And create a file `home/default.nix` on it with the following content (`touch home/default.nix`)

```nix
{ ... }:

let
  username = builtins.getEnv "USER";
in
{

  nixpkgs.config.allowUnfree = true;

  assertions = [
    {
      assertion = username != "";
      message = "Environment varialbe USER is not set. Set USER";
    }
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.stateVersion = "25.11";

  imports = [
    ./core.nix
  ];

  programs.home-manager.enable = true;
}
```

And add a new file `home/core.nix` with these packages


```nix
{ pkgs, ... }:

{

  home.packages = [
    pkgs.btop # htop replacement
    pkgs.coreutils
    pkgs.curl
    pkgs.dust # du modern replacement (system storage tool)
    pkgs.ffmpeg
    pkgs.gnupg
    pkgs.libaio
    pkgs.libarchive
    pkgs.procs # ps replacement
    pkgs.sd # sed replacement
    pkgs.unixtools.netstat
    pkgs.wget
    pkgs.wslu
    pkgs.xdg-utils
    pkgs.xz
    pkgs.keychain
    pkgs.unzipNLS
    pkgs.zip
  ];

}
```

Commit the changes

```bash
git add .
git commit -m "Configure git flake"
```

## Install Packages

In order to install the package you will need to run from the repo first (`cd ~/nix-flakes`)

```bash
nix run github:nix-community/home-manager#home-manager -- switch --impure --flake .#default
```

This will install all the packages that you have declared.

## Add more Packages

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> You can find packages on [Nix Packages official website](https://search.nixos.org/packages)
{: .prompt-tip }
<!-- markdownlint-restore -->

If you'd like to add more packages you can create a new file (f.e. `home/browsers.nix`) like

```nix
{ pkgs, ... }:

{

  home.packages = [
    pkgs.firefox
    pkgs.browsh
  ];

}
```

And add them to imports on `home/default.nix`

```nix
  ...
  imports = [
    ./core.nix
    ./browsers.nix
  ];
  ...
```

You will need to commit the changes before applying them

```bash
git add .
git commit -m "adding browsers"
```

Then you can simply run

```bash
home-manager switch --impure --flake .#default
```
