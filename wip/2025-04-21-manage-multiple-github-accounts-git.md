---
title: How to manage multiple GitHub accounts using Git
description: >-
  Manage multiple accounts and pull/push to different repository accounts
author: pachoyan
date: 2025-04-21 20:00:00 +0800
categories: [git, github]
tags: [git, github, cli]
pin: false
---

## Introduction

Sometimes you might have multiple GitHub accounts you would like to manage for GitHub. Reusing the same ssh key might not be a good practise. 

So, if you are not using the same key, how can git know what user is pushing/pulling to/from?

Simple answer, it will know it from the key associated to the host you are pointing to.

## Setup

In order to get both users working on the same laptop, first you will need to generate ssh keys for each one.

Lets do it

1. First key

```bash

```

2. Second key

```bash

```

## SSH Config

Once you have done it, you will need to know what user you would like to use as the main user and therefore use it for the default github.com host.


### First user

If we choose one you can just add this to `~/.ssh/config`

```config

```

For this user, everything should work out of the box when cloning a repository, as the configuration is not changing the github.com host.

### Second user

Then, in order to use the next one lets create a new configuration to tweak the github host for the second user

```config

```

Finally, for the repos you will need to tweak the remote you are pointing to, to the configured on `~/.ssh/config` file

```bash

```

> If you have more users, you can configure as many hosts as you'd like to

## Test

Lets test the first user

```bash

```


Lets test the second user

```bash

```