---
title: How to use Pbcopy and Pbpaste commands from MacOS on Windows
description: >-
  Use the popular `pbcopy` and `pbpaste` commands from MacOS on PowerShell
author: pachoyan
date: 2025-04-21 20:00:00 +0800
categories: [terminal, cli]
tags: [terminal, cli, tool]
pin: false
---

## Introduction

If you have a background of using MacOS you probably have used the commands pbcopy and pbpaste.

Can you use something similar on Windows?

You can, and there are a few options.

- `clip.exe`, this old command only works one way.
- `Set-Clipboard` and `Get-Clipboard` on `Powershell`.
- `pasteborad` — OSX pbcopy and pbpaste clone.

The basic operations for `pbcopy` and `pbpaste` on `macOS` are

### pbcopy

```bash
cat hello-world.txt | pbcopy
```

### pbpaste

```bash
pbpaste > hello-world.txt

# or to print out to stdout

pbpaste
```

As for Windows these operations can be replicated easily in several ways. I will try to explain all the ones I know.

## How To on Windows

### clip.exe

The old [clip.exe](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/clip) command should be available by default on Windows, it has been around since MSDOS and can be either used on `CMD` or `Powershell`

```bash
where.exe clip

# C:\Windows\System32\clip.exe
```

For example to append to your clipboard a file

```bash
Get-Content hello-world.txt | clip
```

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> This only works one way though, you can’t use it to send the output or paste
{: .prompt-tip }
<!-- markdownlint-restore -->

Finally you can add an alias on your Powershell `$PROFILE` by adding this

```bash
Set-Alias pbcopy Clip
```

And for the pbpaste you can just use the Powershell new function

```bash
Set-Alias pbpaste Get-Clipboard
```

### Set-Clipboard and Get-Clipboard (Powershell)

I have briefly introduced before `Get-Clipboard` previously but if you use it in conjunction with `Set-Clipboard`, you can achieve the same as if you were using `pbcopy` and `pbpaste`.

- [Set-Clipboard](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/set-clipboard)
- [Get-Clipboard](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-clipboard)

To add text to your clipboard from a file

```bash
Get-Content hello-world.txt | Set-Clipboard
```

And to use the clipboard and redirect it into a file

```bash
Get-Clipboard > hello-world.txt
```

Then to set these to be a clone of `pbcopy` and `pbpaste` just add these aliases to your `$PROFILE`

```bash
Set-Alias pbcopy Set-Clipboard
Set-Alias pbpaste Get-Clipboard
```

### Pasteboard

Install it using scoop

```bash
scoop bucket add extras
scoop install extras/pasteboard
```

Then you get `pbcopy` and `pbpaste` tools out of the box

```bash
type hello-world.txt | pbcopy
```

```bash
pbpaste > hello-world.txt
```
