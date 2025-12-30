---
title: WSL List Terminals
description: >-
  List of Best terminals to work with Windows Subsystem Linux
author: pachoyan
date: 2025-12-29 22:00:00 +0800
categories: [windows, wsl, linux, terminal]
tags: [windows, wsl, linux, terminal, wsl-series]
image: /images/2025-12-29-wsl-list-terminals/preview.png
pin: false
---

## Terminals

### Windows terminal

It is the official Microsoft Windows Terminal. It can be configured via a json file. Only available on Windows.

Also, and surprisingly it is open source and you can find the code on GitHub [here](https://github.com/microsoft/terminal)

Pros:

- Open Source
- Modern terminal.
- Advanced built-in features.
- Configuration stored on a JSON File.
- Fully compatibility with Windows and WSL.
- True color, Emoji's and Hyperlinks.

Cons:

- Can feel more slower than other terminals.
- Does not support Graphics Protocol or SIXEL.

### Alacritty

Moder terminal cross-platform terminal, blazing fast written in Rust.

[Alacritty](https://alacritty.org/) is a terminal loved by the community, although it has not so many built in features other have, if you are an advanced terminal user you will love it.

Pros:

- Open Source
- Fastest terminal
- Configuration via a toml file.
- True color, Emoji's and Hyperlinks.
- Good configuration defaults and infinite options to customize it.

Cons:

- Can feel old.
- Does not have simple built-in features like tabs.
- Customize configuration might be intimidating at the beginning.

### Wezterm

Another modern terminal written in rust. It comes with many built-in features.

Wezterm author is very keen adding features proposed by the community.

Check it out [here](https://wezterm.org/index.html)

Pros:

- Open Source
- Modern terminal.
- Advanced built-in features.
- True color, Emoji's and Hyperlinks and Graphics.

Cons:

- Slower than other simple terminals like Alacritty.
- Lua configuration might have a steep learning curve at the beginning.

### Others

I'd like to also include other Terminal options.

Although I have not used them very much to have a strong opinion, they are worth mentioning:

- [Tabby](https://tabby.sh/): super modern and customizable terminal.
- [Hyper](https://hyper.is/): electron based modern terminal.
- [Warp](https://www.warp.dev/): AI first terminal.
- [Waveterm](https://www.waveterm.dev/): open source ai first terminal

## Which one to choose?

So which one yo should choose?

- `Windows Terminal`: it can be sluggish, but it comes with pretty much any built-in feature you need to work. If you are a regular user that is not looking to use any terminal multiplexer (like Zellij or tmux) and do not care about rendering speed, honestly the Windows Terminal is the best choice.

- `Alacritty`: the fastest terminal to work with WSL. Besides that, only consider using it if you are going to use a terminal multiplexer as no tabs or pretty much any modern feature is included on Alacritty. Also, if you are going to use an image render (f.e. for Yazi), Alacritty won't work so it simply can't be your choice. I personally use Alacritty, I now the limitations but I am happy with priortizing smoothness and speed over built-in features.

- `Wezterm`: i guess it has the best of both worlds. I find it a bit complext to configure, but once done and learnt I guess should be all good. It is not as fast as Alacritty, but feels better than Windows Terminal. It can render images and has a built-in multiplexer also.

- Others: if you are already familiar or prefer to try one of the existing modern terminals listed previosuly, go for it.
