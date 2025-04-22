---
title: How to quickly and easily set up Git on Windows
description: >-
  Setup Git with sensible configurations on Windows very easily
author: pachoyan
date: 2025-04-21 20:00:00 +0800
categories: [git, windows]
tags: [windows, git, terminal]
pin: true
---

## Install

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> Check how to install scoop (and Winget if used) if you have not installed it first
{: .prompt-tip }
<!-- markdownlint-restore -->

To install Git you have different options.

Install it using a package manager:

- Scoop - Check scoop.sh to see how to install it.

```bash
scoop install main/git
```

- Winget - Check Install WinGet to see how to install it.

```bash
winget install -e --id Git.Git
```

## Configuration

Git has three locations for configurations:

| Scope       | Location                       | Description                                   |
| ----------- | ------------------------------ | --------------------------------------------- |
| System      | `C:\Users\username\.gitconfig` | Usually not touched                           |
| User/Global | `$HOME\.gitconfig`             | Common config: username, email, ssh key, etc. |
| Repository  | `<git-repo>/.git/config`       | Repo specific configuration                   |
| Portable    | `C:\ProgramData\Git\config`    | Only applies when using a Portable Git        |


### User gitconfig file

Anything added directly on the `.gitconfig` file can be added by using the command line

For example:

```bash
git config --global user.name "John Doe"

git config --global user.email johndoe@example.com
```

- Location: `$HOME\.gitconfig` or `C:\Users\<your-username>\.gitconfig`

The simplest configuration you need for Git to work properly is:

```toml
[user]
   name = <your-name>
   email = <your-email>

[init]
   defaultBranch = main

[core]
   sshCommand = 'C:\\Windows\\System32\\OpenSSH\\ssh.exe'
```

Let’s go deeper and have a nicer configuration:

#### 1. Alias: create aliases for your common operations like status, checkout, branch, or commit

```toml
[alias]
    st = status
    co = checkout
    br = branch
    ci = commit -v
    unstage = reset HEAD --
    last = log -1 HEAD-
    aa = add --all
```

#### 2. Diff tool: Install difftastic or delta

To visualize changes more easily from the terminal, configure a diff tool.

Install with Scoop:

```bash
scoop install main/difftastic
scoop install main/delta
```

Add `delta` or `difftastic` as your diff tool:


```toml
[interactive]
    diffFilter = delta --color-only --features=interactive

[diff]
    tool = difftastic

[difftool]
    prompt = false

[difftool "difftastic"]
    cmd = difft "$LOCAL" "$REMOTE"

[pager]
    difftool = true
```

#### 3. Merge tool: Use IntelliJ Idea merge tool or another like Meld or vimdiff

I love IntelliJ idea merge tool but you can use any, for example for IntelliJ Idea

```toml
[merge]
    tool = intellij

[mergetool "intellij"]
    cmd = idea merge $LOCAL $REMOTE $BASE $MERGED
```

#### 4. Other useful configurations

- Auto git pull rebase
- Set git push auto setup remote

```toml
[pull]
    rebase = true

[push]
    autoSetupRemote = true
```

#### 5. For Windows, it might be recommendable to support long file name paths

```bash
git config --global core.longpaths true
```

#### 6. Complete configuration example

If we put everything together we will result on a `~/.gitconfig` file that looks like this

```toml
[user]
    name = <your-name>
    email = <your-emai>

[init]
    defaultBranch = main

[core]
    pager = delta
    sshCommand = 'C:\\Windows\\System32\\OpenSSH\\ssh.exe'
    longpaths = true

[alias]
    st = status
    co = checkout
    br = branch
    ci = commit -v
    unstage = reset HEAD --
    last = log -1 HEAD-
    aa = add --all

[interactive]
    diffFilter = delta --color-only --features=interactive

[diff]
    tool = difftastic

[difftool]
    prompt = false

[difftool "difftastic"]
    cmd = difft "$LOCAL" "$REMOTE"

[pager]
    difftool = true

[merge]
    tool = intellij

[mergetool "intellij"]
    cmd = idea merge $LOCAL $REMOTE $BASE $MERGED

[pull]
    rebase = true

[push]
    autoSetupRemote = true
```

## Gitignore Files

Install gitignore utils for fetching gitignore file templates:

```bash
scoop install main/gitignore
```

Then for example:

```bash
gitignore java
```

Git ignore files specify files not to track. Usually configured at the repository level, but you can have a global one for common ignores.

## SSH Key

Using HTTPS for Git is not recommended. Use SSH.

1. Generate a new SSH Key

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

2. Name it something like `github_ed25519`.
3. Enter a secure passphrase.

If you need to avoid typing the passphrase every time, use ssh-agent:

```bash
Get-Service -Name ssh-agent | Set-Service -StartupType Manual
Start-Service ssh-agent
```

You will need to add your key to the agent

```bash
ssh-add c:/Users/<username>/.ssh/github_ed25519
```

For more info:

- [Connecting to Github with SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
- [Generate a new SSH Key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
- [Using SSH agent forwarding](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/using-ssh-agent-forwarding)

## GUI Git Clients

If you prefer to use a GUI Client there are popular apps you can take a look

- [GitKraken](https://www.gitkraken.com/)
- [Sourcetree](https://www.sourcetreeapp.com/)
- [Fork](https://git-fork.com/)
- [SmartGit](https://www.syntevo.com/smartgit/)
- [GitButler](https://gitbutler.com/)

## Others

### GitHub CLI

If you use GitHub it might be convenient to use the Github CLI

Install gh by running

```bash
scoop install main/gh
```

Login into your account by running

```bash
gh auth login
```

Manage pull request within a git repository by using:

```bash
# list
gh pr list

# create
gh pr create --fill

# view
gh pr view --web

# review
gh pr review 123 -r -b "needs more ASCII art"
```

Open the git repository on GitHub

```bash
gh browse
```

### Gitea CLI

If instead of GitHub, you are using Gitea then you also have a cli tool available

Gitea CLI (tea) allows interactions with Gitea from the terminal.

Install with Scoop:

```bash
scoop install main/tea
```

Create a Gitea API token at User/Settings/Applications.

1. Login

```bash
tea login add --name my-gitea --url https://my-gitea.com --user {username} --password {your_password} --token {generated_token}
```

2. Check options

```bash
tea --help
```

3. Configure PowerShell autocomplete

```bash
tea autocomplete powershell
```

Then append to $PROFILE:

```bash
& $home\.config\tea\tea.ps1
```

4. Open Web Browser from terminal

```bash
tea open
```

5. Review PR locally

List pulls:

```bash
tea pulls
```

Review a pull request:

```bash
tea pull review {pull_number}
```

## Learn git

Although using git basic operations is easy to learn, when doing more complex operations Git can become a bit overwhelming. Mastering Git is very challenging.

It is recommended to learn how branches, commits and blobs work in order to understand what you are doing. The reason why is that even if you know how to perform an operation, in order to understand what you are doing you need to map somehow how the operation will perform.

It is recommended to do the following training:

- [Learn Git Branching](https://learngitbranching.js.org/) - interactive and available for free
