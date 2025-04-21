---
title: Efficient Powershell Script Management on Windows - Using Scoop and Github
description: >-
  Automate PowerShell script Management using scoop on Windows.
author: pachoyan
date: 2025-04-21 20:00:00 +0800
categories: [windows, powershell]
tags: [windows, powershell]
pin: true
---

## Introduction

If you have powershell scripts that you use frequently and you need to manage them, usually you might have them locally on a folder.

Maybe you have them on a Git Repository, and you backed them up remotely. Maybe you have added them into your PATH manually and you can run them easily.

That all requires manual intervention. But maybe you created a script that handles the installation of them, and adds them to the path. All good.

In this article I will explain another way of managing PowerShell Scripts by delegating all this to Scoop and Github Repos and Packages.

### Requirements

- Windows 10+
- PowerShell
- Git
- [scoop](https://scoop.sh/)
- [GitHub Account](https://github.com/)
- [GitHub CLI](https://cli.github.com/)

## Setup

1. Install scoop

```bash
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

2. Create GitHub Account
3. Install PowerShell

```bash
winget install -e --id Microsoft.PowerShell.Preview
```

3. Install Git

```bash
winget install -e --id Git.Git
```

4. Install GitHub CLI and authenticate with your account

```bash
winget install -e --id GitHub.cli

gh auth login
```

## Create a Scoop Bucket

Create a Github Repository named scoop-bucket by using the gh cli

> 👀 If you prefer the repo to be private replace — public with — private

```bash
gh repo create --public --add-readme scoop-bucket

# ✓ Created repository {username}/scoop-bucket on GitHub
#  https://github.com/{username/scoop-bucket

gh repo clone {username}/scoop-bucket
```

Navigate into the repository and add a folder named bucket and a folder scripts. If you wish add a `README.md` to describe how to use the repo and list the available scripts.

```bash
cd scoop-bucket

mkdir bucket
touch bucket/.gitkeep

mkdir scripts
touch scripts/.gitkeep
```

The folder structure must look like this

```bash
tree 

# ├── README.md
# ├── bucket
# │   └── .gitkeep
# └── scripts
#    └── .gitkeep
```

Push the changes to the repo

```bash
git add .

git commit -m "Initial commit"
git push
```

## Create a PowerShell script and an Scoop App Manifest

### Create PowerShell script

Lets create a `Hello World` PowerShell script, `hello-scoop.ps1` on the scripts folder

```bash
touch scripts/hello-scoop.ps1
```

Add the following

```bash
Write-Host "Hello from Scoop!"
```

Lets create a Github Gist for now to upload the powershell script.

```bash
gh gist create --public scripts/hello-scoop.ps1

# - Creating gist hello-scoop.ps1
# ✓ Created public gist hello-scoop.ps1
# https://gist.github.com/{username}/{gist_id}
```

> 👀 If you prefer you can get the raw link from the repository instead of creating the gist.

### Create a scoop manifest

Create a Scoop App Manifest on the bucket folder create a file hello-scoop.json

```bash
touch bucket/hello-scoop.json
```

Add the following

```json
{
    "version": "0.1",
    "url": "https://gist.github.com/{username}/{gist_id}/raw/hello-scoop.ps1",
    "bin": "hello-scoop.ps1"
}
```

## Add your Bucket to Scoop and install script

To add the bucket to scoop run the following (replace username with your github username)

```bash
scoop bucket add myscripts https://github.com/{username}/scoop-bucket
```

Install hello-scoop

```bash
scoop install myscripts/hello-scoop
```

Run `hello-scoop`

```bash
hello-scoop

# Hello from Scoop!
```

List all the scripts from myscripts

```bash
scoop list | Where-Object { $_.Source -eq 'myscripts' }
```

## Automating Scripts Creation with Github Actions

To automate the publication of the scripts, lets create a github workflow. In order to do that

```bash
mkdir -p .github/workflow
touch .github/workflow/publish-scripts.yaml
```

Add the following to `publish-scripts.yaml`, so it can publish app manifests for scoop automatically when a powershell script is added on scripts folder

```yaml
name: Publish scripts
on:
  push:
    branches:
      - main
    paths:
      - scripts/**
   
jobs:
  publish-script:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: cat .github/manifest-template.json

      - name: Get changed files in the docs folder
        id: changed-files-specific
        uses: tj-actions/changed-files@v44
        with:
          files: scripts/**
          
      - name: Run step if any file(s) in the docs folder change
        if: steps.changed-files-specific.outputs.any_changed == 'true'
        env:
          ALL_CHANGED_FILES: ${{ steps.changed-files-specific.outputs.added_files }}
        run: |
          for file_path in ${ALL_CHANGED_FILES}; do
            file_name=$(echo $file_path | awk -F'/' '{print $NF}')
            only_name=$(echo "${file_name%%.*}" )
            bucket_path="bucket/$only_name.json"


            cp .github/manifest-template.json $bucket_path
            sed "s/{{filename}}/${file_name}/g" .github/manifest-template.json > $bucket_path
          done
          git config user.name "GitHub Actions Bot"
          git config user.email "<>"

          git add .
          git status

          git commit -m "add scripts"
          git push origin main
```

Then enable write permissions for github actions

Now let's create an app manifest template for the workflow in `.github/create-app-manifest.json`

```json
{
    "version": "0.1",
    "url": "https://raw.githubusercontent.com/{{REPOSITORY}}/main/scripts/{{filename}}",
    "bin": "{{ filename }}"
}
```

This will create a new app manifest on buckets, and scoop will immediately pull the new app when running

```bash
scoop update
```

## Testing the scoop bucket

If we now create a `bye-scoop.ps1` script in scripts folder

```bash
touch scripts/bye-scoop.ps1
```

And now add the following to the script

```bash
Write-Host "Bye Scoop!"
```

Commit and push the changes

```bash
git add .
git commit -m "Added bye scoop"
git push
```

And update scoop and install the new app

```bash
scoop update
scoop install myscripts/bye-scoop
```

Let’s list the existing scripts by running

```bash
scoop list | Where-Object { $_.Source -eq 'myscripts' }
```

## Check my Github scoop-bucket repository

If you would like to check the original source code, you can check the repository I have created [here](https://github.com/pachoyan/scoop-bucket).
