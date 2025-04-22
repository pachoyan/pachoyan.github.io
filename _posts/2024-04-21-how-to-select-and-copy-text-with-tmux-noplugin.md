---
title: How to quickly select and copy any text with TMUX — no plugin required
description: >-
  Select and copy faster than ever using TMUX without plugins
author: pachoyan
date: 2025-04-21 20:00:00 +0800
categories: [terminal, cli]
tags: [terminal, cli, tmux]
pin: false
---

## Introduction

Older versions in TMUX required using both tmux-copycat and tmux-yank plugins.

There is an simpler solution as from TMUX 3.1 native regex search is included natively. Also from 1.5 yank works out of the box.

Although I still use tmux-yank and tmux-copycat, I believe nowadays there’s no need to have them installed unless you need specific features included in those two plugins.

## How To

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> Use the q to exit the copy mode
{: .prompt-tip }
<!-- markdownlint-restore -->

### Search

To search for words the combination you need to use is a bit tricky to learn, but once you have mastered it, you will find it works well.

To enable copy mode first add the following to your **tmux configuration file**.

```bash
setw -g mode-keys vi
```

1. Enter Copy Mode by hitting `Prefix + [`
2. Enable search hitting `/` then type the text you would like to search
3. Hit `Enter`
4. Press `n` (from next) to navigate to the next selection

### Select

1. Enter Copy Mode by `Prefix + [`
2. Hit `space`
3. Use the arrows or vim keys (`h`,`j`,`k`,`l`) if enabled to select
4. Hit Enter or `q` to exit

### Yank/Copy

Do either of previous steps and then

1. Hit `y`
2. After hitting `y` you will enter to normal mode and the text will be on your clipboard.
3. Try to paste it by using `Ctrl + v` or `Command + v`.
