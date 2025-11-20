Twisted AutoJoin – README
Overview

Twisted AutoJoiner is an AutoHotkey v2 script designed to automatically attempt joining a Roblox server repeatedly until successful.
It includes a compact draggable GUI, a Start/Stop controller, saved window position, built-in instructions for setup, and automatic detection of the Roblox window.

This tool is intended for personal testing and automation only.
Usage in online games may violate their Terms of Service—use responsibly.

Features

✔️ Auto-detects Roblox window (supports multiple Roblox executables)

✔️ Automatically clicks Join/OK buttons when available

✔️ Looping auto-join attempts with status display

✔️ GUI with Start/Stop buttons

✔️ Saves window position via Windows Registry

✔️ First-run setup instructions popup

✔️ Draggable custom title bar

Requirements

AutoHotkey v2
Download: https://www.autohotkey.com/

Roblox must be:

Open and visible

In a position where the script can detect and click UI buttons

Using Navigation Mode enabled in Roblox settings (as indicated in the instructions)

How to Use

Install AutoHotkey v2.

Run the script:

TwistedAutojoiner.ahk


On first launch, a Setup Instructions window will appear. Follow the steps.

Click Start to begin auto-joining attempts.

Click Stop to end the loop.

Close the window to save its position and exit.

How It Works (Technical Summary)

The script looks for an active Roblox window using executable names like:

RobloxPlayerBeta.exe

RobloxPlayer.exe

RobloxLauncher.exe

When running, it:

Repeatedly scans for the Roblox window

Sends ControlClick events to common Join/OK buttons

Performs fallback Click() attempts if controls fail

UI and settings are stored under:

HKEY_CURRENT_USER\Software\TwistedAutoJoin

Hotkeys

The script does not use global hotkeys—controls are GUI-based:

Start – begins the auto-join loop

Stop – stops the loop

X (close) – exits the script and saves UI position

Disclaimer

This tool is for personal educational/testing use.
Using automation in Roblox or other online games may violate their Terms of Service.
Use at your own risk.
