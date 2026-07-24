---
title: "GIT: Use GitHub SSH When Port 22 Is Blocked"
description: "Why GitHub SSH stopped working on hotel Wi-Fi, and how port 443 fixed it"
pubDate: 2026-07-24 21:00:00 +0800
heroImage: "/images/2026-07-24-hotel-wifi-broke-git-pull/preview.png"
tags: [terminal, cli, git, github, ssh]
---

## Git pull does not work

I was working from a hotel and ran `git pull`, it got stucked. 

My first thought was that I had broken the repository, but the repo was right, the remote was correct, and my key was already loaded in `ssh-agent`.

I tried with a Smartphone hotspot Wi-Fi and worked.

Then I tested SSH directly:

```bash
ssh -T git@github.com
```

Got a Timeout. DNS worked, but the connection to `github.com:22` did not.

## Using SSH over the HTTPS port

GitHub has a second [SSH endpoint on port 443](https://docs.github.com/en/authentication/troubleshooting-ssh/using-ssh-over-the-https-port), made for networks like this one:

```bash
ssh -T -p 443 git@ssh.github.com
```

This time I got:

```text
Hi username! You've successfully authenticated, but GitHub does not provide shell access.
```

Problem found. Port 22 was blocked; port 443 was open.

On the first connection, SSH may ask you to confirm GitHub's host key, check it's fine and go ahead.

## Fix it permanently

I did not want to remember a special command or change every Git remote, so I added this to `~/.ssh/config`:

```ssh-config
Host github.com
    HostName ssh.github.com
    Port 443
    User git
```

Now SSH translates `github.com` to `ssh.github.com:443` for me. Normal Git commands stay exactly the same:

```bash
git pull
git push
git clone git@github.com:username/repository.git
```

One final check:

```bash
ssh -T git@github.com
```

## Wait, is this HTTPS now?

No. It is still SSH, with the same key, encryption, and host verification. It just travels over TCP port 443 instead of port 22.

We tend to associate ports with protocols, but a port is just a numbered entry point. HTTPS normally uses 443. GitHub also listens for SSH on 443 at `ssh.github.com`:

```text
Git -> SSH protocol -> TCP port 443 -> GitHub SSH server
```

Hotels, airports, and office networks cannot simply block 443 because that would break most of the web. If they only filter by port, this route works. A stricter firewall can inspect the traffic, notice that it is SSH rather than HTTPS, and still block it.

## What about multiple GitHub accounts?

This also fits nicely with my [multiple GitHub accounts setup](/blog/2025-12-19-git-manage-multiple-github-accounts/). Both aliases can use GitHub's port 443 endpoint while keeping their own keys:

```ssh-config
Host github.com
    HostName ssh.github.com
    Port 443
    User git
    IdentityFile ~/.ssh/id_ed25519
    IdentitiesOnly yes

# Personal GitHub account
Host github-personal
    HostName ssh.github.com
    Port 443
    User git
    IdentityFile ~/.ssh/id_ed25519_personal
    IdentitiesOnly yes
```

The aliases and repository URLs do not change:

```bash
ssh -T git@github.com
git clone git@github.com:work-account/repository.git

ssh -T git@github-personal.com
git clone git@github-personal.com:work-account/repository.git
```

## Summary

- Some Public Wi-Fi's block port 22 - be aware there is nothing wrong on your config
- There is no meaningful security downside here, and the config only affects GitHub. I am keeping it. The next hotel Wi-Fi can block port 22 all it wants.


