---
title: Configure ssh-agent and keychain on Fish Shell
description: >-
  Configuring ssh-agent and keychain to work on multiple sessions on Fish
author: pachoyan
date: 2025-12-19 21:00:00 +0800
categories: [terminal, cli, linux, git, ssh, fish]
tags: [terminal, linux, fish, ssh, git]
image: /images/2025-12-20-configure-ssh-agent-fish-shell/preview.png
pin: false
---

## Introduction

Configuring ssh-agent on fish is quite easy.

You would need first to start the `ssh-agent` by running

```bash
eval (ssh-agent -c)
```

And then add the keys you'd like to have on your agent

```bash
ssh-add ~/.ssh/id_ed25519
# others
```

If you do not use a multiplexer like tmux or zellij, you might be fine with typing the password not very often, but as a zellij/tmux user you might be opening new sessions all the time.

If you add `eval (ssh-agent -c)` to your `config.fish` it won't solve the issue as you might end up typing your password everytime.

For example, every time you open a new tab or pane you might have this annoying message

```bash
# Enter passphrase for /home/username/.ssh/id_ed25519:
```

How to fix this? Using `keychain`!

## keychain

### What is keychain?

Keychain is a frontend for managing ssh-agent and ssh-add in a much more convenient way. ssh-agent only keeps the keys as long as the UNIX Socket is available using a few environment variables but that's not the case with different sessions.

This is where keychain helps, it allow to reuse an ssh-agent between logins, and only prompt passphrases when the user logs in.

## Install keychain

Installing keychain is really easy, for example for Ubuntu simply run

```bash
sudo apt-get install keychain
```

It is also available as a nix package [here](https://search.nixos.org/packages?channel=25.11&show=keychain&query=keychain)

## Configure keychain on fish

Configuring keychain on fish is not that easy, as it is not fully compatible.

Luckily, we can simply add the following to `config.fish` (full path `~/.config/fish/config.fish`)

```bash
if type -q keychain
    SHELL=(which fish) keychain --quiet --eval id_ed25519 | source
end
```

## Configuring keychain on bash/zsh

If you use bash for any reason, you can reuse the ssh-agent with keychain easily. 

Simply add the following to `~/.bashrc` or `~/.zshrc`:

```bash
if command -v keychain >/dev/null 2>&1; then
  eval "$(keychain --quiet --eval id_ed25519)"
fi
```

## Summary

Now, everytime you open a new session (f.e. with zellij a new pane or tab), or even a new terminal if the user is already logged in, keychain will keep the ssh-agent passphrases available.

So you will only need to type your passhprase once, and this works even when switching shells (from bash to fish f.e.)
