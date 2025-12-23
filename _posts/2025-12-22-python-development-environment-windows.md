---
title: Python Setup on Windows (using scoop)
description: >-
  Complete Python Setup on Windows using scoop.
author: pachoyan
date: 2025-12-19 21:00:00 +0800
categories: [windows, python]
tags: [windows, python]
image: /images/2025-12-22-python-development-environment-windows/preview.png
pin: false
---

## Introduction

Dealing with different versions of Python and tools might be trickier on Windows than Linux due to the way packages work on Windows.

This post describes an easy way similar to Linux or MacOS to manage Python and Python Versions using [scoop](https://scoop.sh).

## Requirements

Install [scoop](https://scoop.sh/).

```bash
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

## Install Python

You can easily install the latest stable python release by running

```bash
scoop install main/python
```

## Install Python Version

If you would like to install different python versions, is really easy to deal with it using scoop

Install the versions you required, for example from the following list

```bash
scoop install versions/python27
scoop install versions/python35
scoop install versions/python37
scoop install versions/python38
scoop install versions/python39
scoop install versions/python310
scoop install versions/python311
scoop install versions/python312
```

To have them available on your path then just use scoop for it

```bash
scoop reset python35
python --version
# Python 3.5

scoop reset python 39
python --version
# Python 3.9.13
```

## Extra tools

### Pipx - Package manager

[pipx](https://pipx.pypa.io/stable/) — Install and Run Python Applications in Isolated Environments. Similar to scoop, brew or apt is a package manager but for Python apps.

Install pipx with scoop by running

```bash
scoop install main/pipx
```

Then you can install with pipx applications that are written in python. For example, pre-commit

```bash
pipx insall pre-commit
```

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> Combining `pipx` with `scoop` is fine, but you might end up having issues with pipx underlying python version when updating it via scoop. 
> 
> It is recommended to hold `pipx` and upgrade only when necessary:
> 
> ```bash
> scoop hold pipx
> ```
{: .prompt-warning }
<!-- markdownlint-restore -->

### Poetry

Poetry is a tool that serves as an alternative to the standards build-tools and pip.

It helps you manage python versions, environments, dependencies in a fluent and easy way.

Install it by running

```bash
scoop install main/poetry
```

### ruff

[ruff](https://docs.astral.sh/ruff/) is the fastest linter and code formatter. It is usually not necessary to be installed as should run as part of your dev workflow, for example using git hooks.

If you prefer to run it manually, you can also install it

```bash
scoop install main/ruff
```

Then you can run

```bash
ruff check   # Lint all files in the current directory.
ruff format  # Format all files in the current directory.
```

### uv and uvx

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> Prefer `uvx` (uv tool) over `pipx`
{: .prompt-tip }
<!-- markdownlint-restore -->

uv is an extremely fast Python package and project manager, written in Rust.

```bash
scoop install main/uv
```

Although it can be used for the same purpose of poetry, also it comes with uvx which serves the same purpose as pipx but faster.

For example, to run a hello world

```bash
uvx pycowsay 'hello world!'
```

## VSCode editor

It is highly recommended to use vscode for your dev environment.

In order to have a good setup, you will need to install the following extensions:

- [Python](https://marketplace.visualstudio.com/items?itemName=ms-python.python)
- [Python Debugger](https://marketplace.visualstudio.com/items?itemName=ms-python.debugpy)
- [Poetry](https://marketplace.visualstudio.com/items?itemName=zeshuaro.vscode-python-poetry)
- [ruff](https://marketplace.visualstudio.com/items?itemName=charliermarsh.ruff)
