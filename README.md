# Checkmk Kiosk Display - Ubuntu & WireGuard

## Overview

This setup configures an Ubuntu system (e.g., a Raspberry Pi) to function as a dedicated kiosk display for a Checkmk monitoring dashboard.

## Core Components

* **Operating System:** Ubuntu
* **Network Connectivity:** WireGuard VPN client connects securely to the company network where the Checkmk server resides.
* **Display:** Firefox runs in fullscreen kiosk mode.
* **Automation:** On system boot, WireGuard connects automatically, followed by the launch of Firefox displaying the pre-configured Checkmk dashboard via a startup script or service.

## Purpose

To provide a persistent, view-only display of a Checkmk dashboard on a TV or monitor, requiring no manual interaction after initial setup and boot-up. Assumes WireGuard infrastructure is in place for network access.
