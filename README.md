TWISTED AUTOJOINER
Overview

Twisted AutoJoiner is an AutoHotkey v2 script that repeatedly attempts to join a Roblox game server until successful.
It includes a draggable interface, start/stop controls, automatic Roblox window detection, and setup instructions on first launch.

This tool is intended for personal testing and automation only.

FEATURES

Auto-detects Roblox window (supports multiple executable names)

Automatically clicks Join / OK buttons

Looping auto-join attempts with real-time status

GUI with Start/Stop controls

Saves window position

First-run setup guide

Draggable custom title bar

REQUIREMENTS

AutoHotkey v2
https://www.autohotkey.com/

Roblox must be:

Open and visible

Using Roblox's Navigation Mode

Positioned so UI buttons can be clicked by the script

HOW TO USE

Install AutoHotkey v2.

Run the script:

TwistedAutojoiner.ahk


Read the Setup Instructions on first launch.

Press Start to begin the auto-join process.

Press Stop to end it.

Close the window to save its position and exit.

TECHNICAL DETAILS

The script attempts to detect Roblox using executable names such as:

RobloxPlayerBeta.exe

RobloxPlayer.exe

RobloxLauncher.exe

Once running, it continuously:

Searches for an active Roblox window

Sends ControlClick events to join-related UI elements

Uses fallback click attempts if controls are not detected

Configuration is saved to the Windows Registry under:

HKEY_CURRENT_USER\Software\TwistedAutoJoin

CONTROLS

The script uses a graphical interface:

Start – Begin auto-join loop
Stop – Stop auto-join loop
Close (X) – Exit and save window position

DISCLAIMER

This script is for personal educational/testing purposes.
Automating actions in Roblox or other online services may violate Terms of Service.
Use at your own risk.
