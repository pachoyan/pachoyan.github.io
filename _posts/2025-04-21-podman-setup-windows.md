---
title: Podman setup on Windows (and local Kubernetes cluster)
description: >-
  Setup podman on Windows step by step (plus a local Kubernetes cluster with Podman)
author: pachoyan
date: 2025-04-21 20:00:00 +0800
categories: [containers, podman, windows]
tags: [windows, containers, podman]
pin: true
---

## Introduction

[Podman](https://podman.io/) is open source first and won’t lock you in. Podman Desktop can be used as one tool to manage all your containers, regardless of container engine - even if you don’t use `Podman` as your container engine.

Rootless containers allow you to contain privileges without compromising functionality.

## Install

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> This guide uses [scoop](https://scoop.sh/) command-line installer for Windows to setup Podman.
>
> Ensure you have installed scoop first.
{: .prompt-warning }
<!-- markdownlint-restore -->

## Podman CLI

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> Once set up using podman-cli you will be able to use podman-desktop too if installed
{: .prompt-tip }
<!-- markdownlint-restore -->

```bash
scoop install main/podman
```

### Podman desktop

```bash
scoop install extras/podman-desktop
```

### Extras but recommended

Install docker-compose, kubernetes-cli and kind (local kubernetes cluster)

```bash
scoop install main/docker-compose
scoop install main/kubectl
scoop install main/kind
```

## Setup

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> Choosing between setting up podman using podman cli or desktop is up to you.
>
> Doing it through the cli gives you more flexibility when configuring the cluster but podman-desktop is more straightforward.
{: .prompt-info }
<!-- markdownlint-restore -->

### Podman CLI

#### Podman Machine

First init a machine by running

```bash
podman machine init --rootful
```

Then start the machine

```bash
podman machine start
```

Verify it is working by running

```bash
podman ps
```

#### Kubernetes

Create a file `kind-config.yaml` to define the cluster - this will mount a volume on your windows `$HOME` path in a folder .k8v so you can sync data with it.

```yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
name: kind-cluster
networking:
  ipFamily: ipv6
  apiServerAddress: 127.0.0.1
nodes:
  - role: control-plane
    extraPortMappings:
      - containerPort: 30000
        hostPort: 30000
        protocol: TCP
    extraMounts:
      - hostPath: /Users/{your_user}/.k8v
        containerPath: /data/k8v
```

Then declare an env variable by either running on your powershell the following or adding it to your `$PROFILE` file (in this case restart the terminal)

```bash
$env:KIND_EXPERIMENTAL_PROVIDER="podman"
```

Start a Kind Kubernetes cluster by running

```bash
kind create cluster --config .\kind-config.yaml
```

Once completed, verify is running by running

```bash
kubectl cluster-info --context kind-kind-cluster
```

### Podman Desktop

#### Podman Machine

Open <kbd>Podman Desktop</kbd> and follow the onboarding to set it up properly - you will most likely need <kbd>Admin Privileges</kbd>

![podman-onboarding](/images/2024-04-21-podman-setup-windows/podman-desktop-onboarding.png)

The onboarding will follow the next steps

1. Compose Setup
2. Kubectl Setup
3. Podman Setup - Enable Autostart Podman engine when launching Podman Desktop if you’d like.

![podman-start-engine](/images/2024-04-21-podman-setup-windows/podman-dekstop-start-engine.gif)

Once finished you should see Podman is running on the App

![podman-machine-running](/images/2024-04-21-podman-setup-windows/podman-desktop-running.gif)

#### Kubernetes

Kubernetes clusters can be setup by using either [Kind](https://kind.sigs.k8s.io/) or [minikube](https://minikube.sigs.k8s.io/docs).

We are going to follow Kind as it is the most compatible tool and works out of the box.

Go to <kbd>Kubernetes</kbd> on the left menu and click ond <kbd>Create Kind Cluster</kbd>

![podman-kind-cluster](/images/2024-04-21-podman-setup-windows/podman-desktop-create-kind.gif)

Once loaded click on <kbd>Create</kbd> so it starts creating it - it will take a while

![podman-kind-cluster-running](/images/2024-04-21-podman-setup-windows/podman-desktop-creating-kind.gif)

Once created test `kubectl` can connect to it

```bash
kubectl get all --all-namespaces
```

## Uninstall

Close <kbd>Podman Dekstop</kbd> and make sure to quit from <kbd>Hidden Icons</kbd>.

Also, to ensure it has stopped, stop Podman and Podman Desktop processes

```bash
Get-Process podman | Stop-Process
Get-Process 'Podman Desktop' | Stop Process
```

Terminate and unregister WSL podman-machine-default

```bash
wsl --terminate podman-machine-default
wsl --unregister podman-machine-default
```

Uninstall podman

```bash
scoop uninstall extras/podman-desktop
scoop uninstall main/podman

scoop cache rm --all
scoop cleanup *
```

Remove configuration folders

```bash
rm $HOME/.local/share/containers
rm $HOME/.config/containers
rm $HOME/AppData/Roaming/containers
```

If installed with scoop remove podman-desktop persist folder

```bash
rm $HOME/scoop/persist/podman-desktop
```

And maybe uninstall Docker related tools if you had them

```bash
scoop uninstall main/docker-compose
scoop uninstall main/docker
```

## Tips & Tricks

### Disable tls-verify to speed up pull images

When pulling images you can speed them up a bit by disabling tls verification if it is not needed, just add the following flag

```bash
podman pull --tls-verify=false {image}
```

#### Enable Parallel Image layer

If you prefer podman to pull image layers on parallel it can be configured to do so, this might increase the speed of the images being pulled.

Change the configuration by adding the following on `containers.conf`

```toml
[engine]
image_parallel_copies=6
```

#### Enable docker-cli to work with podman-machine

First install docker-cli (not Docker Desktop)

```bash
scoop install main/docker
```

Then ensure the following variable is setup on your shell `$PROFILE` or Windows Environment Variables

```bash
$env:DOCKER_HOST = 'npipe:////./pipe/docker_engine'
```

## Troubleshooting

### Podman image pull progress not showing

Podman image pull progress does not work from Windows or macOS so you will need to use podman from the wsl to see the progress

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> There is an active discussion https://github.com/containers/podman/discussions/16712 that explains the reason about this
{: .prompt-tip }
<!-- markdownlint-restore -->


```bash
wsl -u root -d podman-machine-default

podman pull {image}
```

The alternative is to use <kbd>docker-cli</kbd> with the pipe docker configured, which simply works fine

### failed: exit status 0xffffffff

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> Using podman-desktop directly should configure the required optional features for you.
{: .prompt-info }
<!-- markdownlint-restore -->

When running podman - if you have tried to start the podman-machine without using podman-desktop you might encounter the following error

```bash
podman machine init
```

If you run into an error like

```log
The operation could not be started because a required feature is not installed.
Error code: Wsl/Service/RegisterDistro/CreateVm/HCS/HCS_E_SERVICE_NOT_AVAILABLE
Error: the WSL import of guest OS failed: command C:\Users\[user]\AppData\Local\Microsoft\WindowsApps\wsl.exe [--import podman-machine-default C:\Users\[user]\.local\share\containers\podman\machine\wsl\wsldist\podman-machine-default C:\Users\[user]\.local\share\containers\podman\machine\wsl\podman-machine-default-amd64 --version 2] failed: exit status 0xffffffff
```

Turn on optional features on Windows

- Containers
- Virtual Machine Platform
- Windows Subsystem For linux

![optional-features](/images/2024-04-21-podman-setup-windows/optional-features-turn-on.gif)

### WSL Podman != Windows Podman

If you started podman machine as root in order to have the same machine that windows podman-cli is using you will need to connect to wsl as root

```bash
wsl -u root -d podman-machine-default
```

Then running podman commands in both should match

```bash
podman ps
podman images
```
