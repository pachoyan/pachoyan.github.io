---
title: Configure Oracle sqlcl MCP Server for AI Agents
description: >-
  If you are working on an Oracle Database and would like to let your agents interact with the database using an MCP server, sqlcl from Oracle is a good choice.
author: pachoyan
date: 2025-12-19 21:00:00 +0800
categories: [terminal, cli, oracle, ai, mcp, ai-agent, sql]
tags: [terminal, cli, oracle, ai, mcp]
pin: false
---

## Introduction

Working with Databases is always a bit tricky. Trying to understand tables, relationships, data on legacy systems is even harder.
Luckily, we can nowadays use LLM to do the hard work and give us insights about that.

If you are a postgres, mysql or other open source databases you might be lucky, as most of the tools work with those.

But, what if you are using an Oracle Database?

Unluckily, developers tend to create solutions and tools for other databases. Still, Oracle has extended their `sqlcl` cli tool to provide an MCP server that works out of the box.

## What is an MCP Server?

MCP Server stand for Model Context Protocol, and allows LLMs and AI agents to use external tools to connect to APIs, databases and files.

## Oracle SQLcl

Oracle SQLcl is a modern command-line tool to work on Oracle Databases. It is a replacement of the old SQL*Plus cli tool.

In the latest releases, SQLcl has an MCP Server integrated that allows LLMs to interact with your database.

Learn more [here](https://modelcontextprotocol.io/docs/learn/server-concepts)

### Instal Oracle SQLcl

For Linux users:

Download sqlcl from [Oracle Website](https://www.oracle.com/database/sqldeveloper/technologies/sqlcl/download/)

Then extract it somewhere like `~/.local/share/sqlcl` and create a link at ~/.local/bin/sql`.

For Windows:

Using scoop, you might install it by running

```bash
scoop install main/sqlcl
```

For MacOS Users:

```bash
brew install --cask sqlcl
```

## Oracle SQLcl MCP

SQLcl mcp must be available out of the box. So run `sqlcl -mcp` to test it works:

```bash
sqlcl -mcp

# ---------- MCP SERVER STARTUP ----------
# MCP Server started successfully on Sat Dec 20 11:25:34 CST 2025
# Press Ctrl+C to stop the server
# ----------------------------------------
```

### Configure Connections

Running sqlcl mcp it is quite easy, but it is useless unless you configure a connection to a database, so the LLM or AI agent can use those connections.

First, run

```bash
sqlcl /nolog

# SQLcl: Release 25.3 Production on Sat Dec 20 11:27:44 2025
# Copyright (c) 1982, 2025, Oracle.  All rights reserved.
# SQL>
```

Then you will need to save connections in order to use them. 

For that you will need to use `conn` command on `sqlcl`

For example, to save a `local` connection

```bash
conn -save local -savepwd user/password@//localhost:1521/db
```

The way this works is:

- `local`: name of the connection
- `-savepwd`: saves the password
- url: `user/password@//localhost:1521/db`
  - user
  - password
  - host
  - port
  - database
  
  Save as many connections as you want, but keep in mind the connection name must be different. f.e. `local`, `qa` and `prod`.
  
  ### Configure mcp
  
  For vscode you will need to create a file if it does not exist as `.vscode/mcp.json` and add the following
  
  ```json
  {
      "servers": {
        "sqlcl": {
            "command": "sql",
             "args": [
               "-mcp"
             ]
           }
      }
  }
  ```
  
For GitHub Copilot CLI, add the following to `~/.copilot/mcp.json`

```json
{
  "mcpServers": {
    "sqlcl": {
      "tools": [
        "*"
      ],
      "type": "local",
      "command": "sql",
      "args": [
        "-mcp"
      ]
    }
}
```

And For Codex CLI, add the following to `~/.codex/config.toml`

```toml
[mcp_servers.sqlcl]
args = ["-mcp"]
command = "sql"
```

### Usage

Once connections and mcp has been configured, AI Agents can use the mcp server alongside their capabilities.

Usually, I use prompts where I specify the AI Agent to use the mcp server and what connection I'd like to use:

```txt
Use mcp sqlcl to connect to local and understand the persons table relationship with animals
```

Be careful when using it, if you are using it to update records, or in a production environment always review what the AI Agent will run!
