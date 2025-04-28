---
title: Freeze — Generate images from the otuput of your terminal
description: >-
  freeze cli to generate images of your terminal output
author: pachoyan
date: 2025-04-21 20:00:00 +0800
categories: [terminal, cli]
tags: [terminal, cli, tool]
image: /images/2025-04-21-freeze-generate-images-from-the-output-of-terminal/preview.png
pin: false
---

## Introduction

### charm

If you have not heard about [charm](https://charm.sh/) you should definitely check out what they have.

The libraries and apps they have created the best good looking ones I have seen in a long time, they somehow have reinvented the way cli tools look like on the terminal, and for better.

### freeze

[freeze](https://github.com/charmbracelet/freeze) is one of the new cli tools they have created to generate images of code and terminal output

Similar to [asciinema](https://asciinema.org/) but focus on images, you can generate an image from the terminal and customize it as you wish. It is really mind blowing how good the images look.

## Install

### MacOS

Using homebrew

```bash
brew install charmbracelet/tap/freeze
```

## Linux

Any Linux platform using go

```bash
go install github.com/charmbracelet/freeze@latest
```

## Use

Generate Image from STDOUT

```bash
freeze --execute "ls -la"
```

Generate image from a code file

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> It will detect the language automatically
{: .prompt-tip }
<!-- markdownlint-restore -->

```bash
freeze config.fish
```

If you prefer you can set the language

```bash
cat bash_script.sh | freeze --language bash
```

## Customize

There are many options to customise the ouput on freeze

- margin, padding, window, width and height
- border: radius, width and color
- shadow: blur, x and y
- font: family, file, size and ligatures
- line-height, lines and show line numbers.


### Interactive mode

The easiest way to customise `freeze` is by running the `interactive mode`

```bash
freeze --interactive bash_script.sh

# Changed

# Theme doom-one
```

### Using flags

You can customise **the output using flags** too

```bash
freeze --theme doom-one bash_script.sh
```

## Extras

### Show line numbers

```bash
freeze --show-line-numbers bash_script.sh
```

### Show only lines from X to Y

```bash
freeze --lines 2,5 --show-line-numbers bash_script.sh
```

### Change the default freeze.png output file name and image type

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> You can generate svg, png or webp images
{: .prompt-tip }
<!-- markdownlint-restore -->

```bash
freeze bash_script.sh --output bash.svg
```