---
title: Git Commands you should be using - Enhance Your Workflow
description: >-
  I recommend you to start using these git commands if you are not.
author: pachoyan
date: 2025-04-21 20:00:00 +0800
categories: [git]
tags: [git]
pin: false
---

## Create Stash with a Single File/Path

Since git 2.13 you can save a specific file or path to the stash

```bash
git stash push -u file.txt
```

## Create Stash including untracked files

When running git stash, git will include only the tracked files. If you would like to include untracked files you need to add a flag

```bash
git stash --include-untracked 
```

## Restore the Staged Area

```bash
git restore --staged .
```

## Clean All (tracked and untracked files)

```bash
git clean -df
```

## Clean Only Files Ignored by Git

Sometimes if you were just playing on your repo, or for any reason you messed things up, you can just clean changes and untracked files in a single command

```bash
git clean -dfx
```

## Amend last commit

If you just made a commit but you forgot a change you would like to include, you can reset the last commit and make the changes you'd like and do the commit again

```bash
git reset HEAD^1
```

## Pull with Rebase

If you are in a branch that the history does not match your current one you can pull and rebase in a single command

```bash
git pull --rebase
```

## Push Force safely

Forcing a push is not safe. Thankfully, there is an alternative that makes it safer

```bash
git push --force-with-lease
```

## Move to the previous branch

If you would like to switch to the previous branch you were, you can just run this command

```bash
git checkout -
```

## Rebase branch (main) with your current ranch

To update your branch with a rebase (usually from main) you can run

```bash
git rebase main
git push --force-with-lease
```

## Show one liner log

If you just run git log, you will notice that the output is quite verbose. If you only want to see the hashes, for example, just run

```bash
git log --oneline
```

## Show Changes on a file

If you would like to check the changes on a specific file/path, just run

```bash
git diff file.txt
```

## Backup repository on a zip file

To backup the repository on a zip file you can run

```bash
git archive --format=zip --output=output.zip
```

## Show top contributors

To show the top contributors of a specific repo

```bash
git shortlog -sn
```

## Optimize git repository performance

If you repository slows down and performance is an issue, you can just run the garbage collector

```bash
git gc --prune=now
```

## Enable reuse of recorded resolution of conflicts

This is quite useful, as you command git to record how you fied previous conflicts and make it learn from it for the future

```bash
git rerere
```

## Show history of a specific file

To check all the changes made on a specific file over time, run

```bash
git log --follow file.txt
```

## Show last commit changes

Sometimes you just want to check what were the latest changes made on the last commit.

```bash
git diff HEAD~1
```