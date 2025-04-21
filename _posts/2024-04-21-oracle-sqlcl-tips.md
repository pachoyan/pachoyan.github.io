---
title: Oracle SQLcl - Best tips for Configuration and Usage
description: >-
  SLSQLcl is a command line interface for Oralce Databases. It is a more modern tool than the popular SQLPlus.
author: pachoyan
date: 2025-04-21 20:00:00 +0800
categories: [terminal, oracle]
tags: [terminal, cli, tool, oracle]
pin: false
---

## Introduction

SQLcl is a command line interface for Oralce Databases. It is a more modern tool than the popular SQLPlus.

- Oracle [SQLcl](https://www.oracle.com/database/sqldeveloper/technologies/sqlcl/)

In this article, It will explain the easiest way of configuring SQLcl and manage connections. It will go through basic techniques to run queries and scripts too.

## Install

If you prefer to manually install it download the latest version from [SQLcl Downloads](https://www.oracle.com/database/sqldeveloper/technologies/sqlcl/download/) (oracle.com) and add the bin to your path for any OS.

### Windows

For automatic installations you can use [scoop.sh](https://scoop.sh)

```bash
scoop install main/sqlcl
```

### MacOS

Install sqlcl automatically using homebrew [sqlcl — Homebrew Formulae](https://formulae.brew.sh/cask/sqlcl#default)

```bash
brew install --cask sqlcl
```

### Linux

Ubuntu

```bash
sudo apt -y install sqlcl-package
```

## Use

### Connect

Simply use the following to connect to a database

```bash
sql username/password@localhost:1521/DATABASE

# SQLcl: Release 24.2 Production on Tue Aug 06 13:30:45 2024
#
# Copyright (c) 1982, 2024, Oracle.  All rights reserved.
#
# Last Successful login time: Tue Aug 06 2024 14:30:46 -05:00
#
# Connected to:
# Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
# Version 19.19.0.0.0
```

Then run any SQL ending with ; and press enter

```sql
select 1 from dual;

   1
____
   1
```

To exit the terminal

```bash
exit

# Disconnected from Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production
# Version 19.19.0.0.0
```

### Run scripts

You can run scripts directly from sql by specifying a file after `@`. For example, a file `test.sql`

```bash
sql -S username/password@localhost:1521/DATABASE @$pwd\test.sql
```

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> -S flag sets silent mode which might be convenient for running scripts.
{: .prompt-tip }
<!-- markdownlint-restore -->

You might have noticed when running the script, it launches `sqlcl` and it keeps the session opened. To run the script and exit run

```bash
echo exit | sql -S username/password@localhost:1521/DATABASE @$pwd\test.sql
```

Or you can add exit command at the end of the test.sql script too

```sql
select from dual;

exit
```

### Named Connections

If you prefer to not type the logon URL every time, you can use named connections instead.

You can configure them by using the connmgr/cm command.

#### Save/Import from SQL Developer connection file

The easiest way is to use the `connections.json` file from SQL Developer.

Just export a file from `SQL Developer`. Click right and then export and name the file connections.json.

To import connections from `connections.json` (it can be any name) run the following

```bash
echo "cm import connections.json" | sql /NOLOG
```

#### Save connections from SQLcl connmgr

The easiest way is by running this oneliner command

```bash
 echo "CONNECT -SAVE local-dev username/password@localhost:1521/database_name" | sql -S /NOLOG
```

But if you prefer you can do it in several steps.

First connect to the database using SQLcl

```bash
sql -S /NOLOG
```

And then save the current connection

```bash
CONNECT -SAVE local-dev username/password@localhost:1521/DATABASE_NAME
```

#### Save passwords with connections

If you prefer to not type the password every time you connect to named connection you can save the password within the connection by using `-savepwd` flag

<!-- markdownlint-capture -->
<!-- markdownlint-disable -->
> Remember to either connect to sql first or use the echo pipe before on all these examples.
{: .prompt-warning }
<!-- markdownlint-restore -->

```bash
CONNECT -SAVE -local-dev -SAVEPWD username/password@localhost:1521/DATABASE_NAME
```

#### Update existing connections

Use the flag `-replace` with `-save` to update existing connections

```bash
 CONNECT -REPLACE -SAVE local-dev username/password@localhost:1521/DATABASE_NAME
```

For example, if you forgot to save the password on the previous one you could replace the existing one and update it with the password

```bash
CONNECT -REPLACE -SAVE local-dev -SAVEPWD username/password@localhost:1521/DATABASE_NAME
```

#### Connect to named connections

Just run sql with `-name` flag

```bash
sql -name local-dev
```
