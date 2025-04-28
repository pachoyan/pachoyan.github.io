---
title: Bitwarden CLI — Quick Introduction
description: >-
  Quick Introduction on How To use Bitwarden CLI (ak bw)
author: pachoyan
date: 2025-04-21 20:00:00 +0800
categories: [terminal, cli]
tags: [terminal, cli, password-manager, bitwarden]
image: /images/2025-04-21-bitwarden-cli-quick-introduction/preview.png
pin: false
---

## Introduction

Bitwarden is an open-source password manager that has become very popular.

- [Best Password Manager for Personal, Business & Enterprise | Bitwarden](https://bitwarden.com/)

Besides the Desktop app and Browser extension you can interact with Bitwarden via a cli tool

- [Password Manager CLI](https://bitwarden.com/help/cli/)

## Setup

Create an account on [Bitwarden Web Vault](https://vault.bitwarden.com/#/register?layout=default) for free.

- **The free tier** includes unlimited devices, all the core functions and passkey management.
- **Premium tier** costs only 1$ per month and you get access to more features. It is very cheap and incredibly good.

Install CLI tool by running:

- MacOS

```bash
brew install bitwarden-cli
```

- Linux

With `node`

```bash
npm install -g @bitwarden/cli
```

With `snap`

```bash
sudo snap install bw
```

- Windows

```bash
winget install -e --id Bitwarden.CLI
```

## Basic Use

### Login

Login to generate a session key

```bash
bw login
```

Set environment variable `BW_SESSION` with your session key as an environment variable to not include it on every command.

```bash
# ? Email address: someone@gmail.com
# ? Master password: [hidden]
# ? Two-step login code: 11111
# You are logged in!
To unlock your vault, set your session key to the `BW_SESSION` environment variable. ex:
$ export BW_SESSION="*******"
> $env:BW_SESSION="*******"
You can also pass the session key to any command with the `--session` option. ex:
$ bw list items --session *******
```
Add the `BW_SESSION` generated into your `~/.bashrc` or `~/.zshrc`.

```bash
export BW_SESSION="**********"
```

Or for Windows Powershell add `BW_SESSION` to your `$PROFILE`

```bash
$env:BW_SESSION="************"
```

### List items

For example, to list items without `BW_SESSION`

```bash
bw list items --session ******
```

Can be simplified with the following

```bash
bw list items
```

### Search items

To search items run the following

```bash
bw list items --search {key}
```

For example, for bitwarden itself

```bash
bw list items --search bitwarden
```

### Get item

You can show a single item by running

```bash
 bw get item bitwarden
```

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> This will only work if only one item for the key exists (in this case bitwarden).
{: .prompt-tip }
<!-- markdownlint-restore -->

### Get item password

To get the password as a `stdout` run

```bash
 bw get password bitwarden.com
 ```

 ### Get item totp (aka verification code)

 To get the totp as a stdout run

 ```bash
bw get totp bitwarden.com
 ```

 ### Get item notes

```bash
 bw get notes bitwarden.com
```

### Templates

Templates are necessary in order to create items, to get the templates for item and folder:

#### item template

```bash
bw get template item

# {"passwordHistory":[],"revisionDate":null,"creationDate":null,"deletedDate":null,"organizationId":null,"collectionIds":null,"folderId":null,"type":1,"name":"Item name","notes":"Some notes about this item.","favorite":false,"fields":[],"login":null,"secureNote":null,"card":null,"identity":null,"reprompt":0}
```

#### folder template

```bash
 bw get template folder

# {"name":"Folder name"}
```

### Create item

You can create items by using the item template.

```bash
bw get template item | jq ".name=\"Bitwarden\" | .login=$(bw get template item.login | jq '.username="username" | .password="mypassword"')" | bw encode | bw create item
```

### Create attachment

```bash
bw create attachment --file ./myfile.txt --itemid 16b14c89-65b3-4231-bd2b-15051a6d8g77
```

### Create folder

```bash
bw get template folder | jq '.name="My Folder"' | bw encode | bw create folder
```

### Generate passwords

You can generate passwords by running

```bash
bw generate
```

If you’d like to create different types of passwords, you can customize de prompt. For example, to create a passphrase with words

```bash
bw generate -p --words 4
```

Or to replace the separator `-` with `_`

```bash
 bw generate -p --words 4 --separator _
```
