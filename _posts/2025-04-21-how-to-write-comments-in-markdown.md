---
title: How to write comments in Markdown
description: >-
  Explore the different alternatives of writing comments on Markdown
author: pachoyan
date: 2025-04-21 20:00:00 +0800
categories: [markdown]
tags: [markdown]
pin: false
---

## Introduction

Markdown is a markup language that is very simple and is focused on creating formatted text using a simple text editor.

Like any other markup language, in order to have a good looking output a render/processor needs to read the markdown file and display it. That is the reason why depending on where you read a markdown, it might look different or have different outputs, as it is the processor who decides how the file is going to look like.

Same as interpreters/compilers, the markdown file (f.e Readme.md) that contains the instructions and the processor is responsible for diplaying it based on those instructions. In Python, for example, a Python Script File is interpreted by the Python Interpreter in order to execute the orders defined on the script.

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> This a really simple description of how Markdown is diplayed, and it might differ from reality a bit
{: .prompt-warning }
<!-- markdownlint-restore -->

![markdown-image](/images/2025-04-21-how-to-write-comments-in-markdown/markdown-diagram.png)

The problem here is that there is no such instruction in most of the Markdown Processors to instruct that a line is a comment.
How can we write comments?

CHEATING THE INTERPRETER.

## What is a Comment?

A comment is a marked line that is not eavaluted typically used for having a readable explanation.
A comment is very common on programming, it can be used on most programming languages (Java , Python, Rust,..) or even configuration files like YAML or TOML.

For example, for Java

```java
// this is a comment
```

or for YAML

```yaml
# this is a comment
```

## How To Write Comments in Markdown

Writing comment in Markdown is simply not a thing.

Markdown specification does not have a standard way of adding comments.

Obviously, based on the file-processor I have explained before, you can cheat the render and somehow have them.

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> The examples described here, might not work on all the renders.
{: .prompt-warning }
<!-- markdownlint-restore -->

### Standard HTML comments tags

```md
<!--- this is a comment -->
```

### Style of links

```md
[comment]: # (this is a comment)
```

```md
[//]: # (this is a comment)
```

Or only one word by

```md
[comment]: comment
```

## Test

If you go into https://markdownlivepreview.com/ and test

```md
<!--- this is a comment -->
[comment]: # (this is a comment)
[//]: # (this is a comment)
[comment]: comment
```

You will see no output is shown. You can try different renders to see if they are displayed or not as some options might work differently on different Markdown Apps.