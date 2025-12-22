---
title: Manage Multiple GitHub Accounts Locally
description: >-
  Learn how to manage multiple GitHub Accounts Locally
author: pachoyan
date: 2025-12-19 21:00:00 +0800
categories: [terminal, cli, git]
tags: [terminal, cli, git, github]
image: /images/2025-12-19-manage-multiple-github-accounts/preview.png
pin: false
---

## Introduction

You might have been in a situation where you need to manage multiple GitHub Accounts.

For example, let's say you use the same PC for work and personal projects.
Also, you have your GitHub Work Business Account and your personal GitHub Account.

Managing this it is not trivial, but with not much effort it can be done.

Two accounts:

- username_work
- username

## Configure ssh keys

### Configure Default Key

Create one key with the default `id_ed255519` name. Choose the one you usually use the most.

Tips:

* Use the default ssh-key name
* Use a good password to remember

```bash
ssh-keygen -t ed25519 -C "username_work@work_domain.com"

# Enter file in which to save the key (/home/username/.ssh/id_ed25519): Press enter
# Enter passphrase (empty for no passphrase): 
```

Copy the SSH publick key to your clipboard

```bash
cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard
```

Then go to GitHub `SSH and GPG Keys` and create `New SSH Key` [here](https://github.com/settings/keys) named f.e. `work-ssh-key`.

### Configure Second Key

Create one key with the default `id_ed255519` name. Choose the one you usually use the most.

Tips:

* Use the same password used previously

```bash
ssh-keygen -t ed25519_personal -C "username@gmail.com"

# Enter file in which to save the key (/home/username/.ssh/id_ed25519): id_ed25519_personal
# Enter passphrase (empty for no passphrase): 
```

Copy the SSH publick key to your clipboard

```bash
cat ~/.ssh/id_ed25519_personal.pub | xclip -selection clipboard
```

Then go to GitHub `SSH and GPG Keys` and create `New SSH Key` [here](https://github.com/settings/keys) named f.e. `personal-ssh-key`.

### Edit ssh config file

Open `~/.ssh/config` or create it if does not exist (`touch ~/.ssh/config`) and add the following entries


```
# Work github account
Host github.com
   HostName github.com
   IdentityFile ~/.ssh/id_ed25519
   IdentitiesOnly yes
   
# Personal github account
Host github-personal
   HostName github.com
   IdentityFile ~/.ssh/id_ed25519_personal
   IdentitiesOnly yes
```

## Configure ssh-agent

Start `ssh-agent`

```bash
eval "$(ssh-agent -s)"
```

Add both keys to the agent

```bash
ssh-add ~/.ssh/id_ed25519
ssh-add ~/.ssh/id_ed25519_personal
```

Check they have been added:

```bash
ssh-add -l
```

And then, test your connection:

```bash
ssh -T git@github.com
# Hi username_work! You've successfully authenticated, but GitHub does not provide shell access.

ssh -T git@github-personal
# Hi personal! You've successfully authenticated, but GitHub does not provide shell access.
```

## Manage GitHub Repositories

From now on, for the defaul account we can proceed as usual. Cloning and other git ops on repositories can be used normally

```bash
git clone git@github.com:cli/cli.git

git fetch
git pull
git push
```

For the personal account though, we would need to use the custom HostName

For example, if we'd like to clone `git@github.com:pachoyan/pachoyan.github.io.git`, we would need to clone it as:

```bash
git clone git@github-personal:pachoyan/pachoyan.github.io.git
```

If you check the remote, the host name `git@github.com` should be replaced with your custom name `git@github-personal`.

```bash
git remote -v
origin  git@github-personal:pachoyan/pachoyan.github.io.git (fetch)
origin  git@github-personal:pachoyan/pachoyan.github.io.git (push)
```

### Fix existing repositories

If you already had one cloned with the wrong remote for your personal account. For example:

```bash
git remote -v
origin  git@github.com:pachoyan/pachoyan.github.io.git (fetch)
origin  git@github.com:pachoyan/pachoyan.github.io.git (push
```

You can easily replace it by running

```bash
git remote set-url origin git@github-personal:pachoyan/pachoyan.github.io.git
```

Then verify, it's now pointing to the right HostName

```bash
git remote -v
origin  git@github-personal:pachoyan/pachoyan.github.io.git (fetch)
origin  git@github-personal:pachoyan/pachoyan.github.io.git (push)
```

## GitHub CLI

If you are a GitHub CLI user you might want to configure it to work with multiple accounts too.

Check you do not have set `GITHUB_TOKEN` variable on your shell first

```bash
echo $GITHUB_TOKEN
# must be empty
```

First, configure your main account by selecting `GitHub.com` and the main ssh-key

```bash
gh auth login

# Where do you use GitHub?
# > GitHub.com
# SSH
# Select ~/.ssh/id_ed25519.pub
# Title: GitHub CLI
```

Then, configure your main secondary by selecting `GitHub.com` again and the personal ssh-key

```bash
gh auth login

# Where do you use GitHub?
# > GitHub.com
# SSH
# Select ~/.ssh/id_ed25519_personal.pub
# Title: GitHub CLI
```

Finally check, both have been configured

```bash
gh auth status

# github.com
#   ✓ Logged in to github.com account pachoyan (/home/pchorro/.config/gh/hosts.yml)
#   - Active account: true
#   - Git operations protocol: ssh
#   - Token: gho_************************************
#   - Token scopes: 'admin:public_key', 'gist', 'read:org', 'repo'

#   ✓ Logged in to github.com account work (/home/pchorro/.config/gh/hosts.yml)
#   - Active account: false
#   - Git operations protocol: ssh
#   - Token: gho_************************************
#   - Token scopes: 'admin:public_key', 'delete_repo', 'gist', 'read:org', 'repo'
```
