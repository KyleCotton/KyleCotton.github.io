---
title: "Installing Haskell"
date: 2019-05-25
lastmod: 2020-05-12T17:05:01+01:00
tags: ["Programming", "Tutorial", "Haskell"]
categories: ["Haskell for Beginners"]
draft: false
weight: 2002
---

In this episode we will be installing Haskell, a lot of people struggle to install software to their machine and each operating system will be different, generally I advise the use of a package manger - not just to install Haskell, but to  install all software. I will be making a post about [Brew](https://brew.sh/) at some point which makes this process trivial.


## MacOS {#macos}

MacOS my operating system of choice, to install Haskell on a MacOS system, the best method is to use a package manager such as [Brew](https://brew.sh/).

1.  If you don't have [Brew](https://brew.sh/) installed, follow the link and install that. Brew is one of my essential utilities for any new Mac.
2.  Open your favourite terminal emulator such as `Terminal.app`, pre-installed on all Macs.
3.  From your command line run, `brew install ghc`, this will install the latest version of the <span class="underline">Glasgow Haskell Compiler</span>
4.  Happy Days! Haskell is now installed.


## Linux {#linux}

1.  Open your favourite terminal emulator such as `Terminal`.
2.  Using your favourite package manager install `ghc`, this will install the latest version of the <span class="underline">Glasgow Haskell Compiler</span>
3.  Happy Days! Haskell is now installed.


## Windows {#windows}

A lot of software we use in Computer Science does run on Windows, but it does not play nice, lets fix that.

1.  If your don't have [WSL (Windows Subsystem for Linux)](https://docs.microsoft.com/en-us/windows/wsl/install-win10), go install that first
2.  Congratulations, your avoiding Windows, now follow the Linux instructions.
