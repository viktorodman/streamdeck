# streamdeck

AppleScript automations bound to Stream Deck buttons.

- **ConnectIpad** — connect iPad as extended display via Sidecar (Control Centre → Screen Mirroring → first Sidecar device)
- **StartScrcpy / StopScrcpy** — start/stop scrcpy mirroring for an Android device

## Prerequisites

- macOS with Accessibility permission granted to each compiled `.app`
- `scrcpy` installed via Homebrew (`brew install scrcpy`) — used by Start/Stop only

## Setup

1. Copy the example config and set your Android device serial:
   ```sh
   cp config.example.env config.env
   # edit config.env and set DEVICE_SERIAL=YOUR_SERIAL
   ```
   Find your serial with `adb devices`. `config.env` is gitignored, so each user's serial stays local.

2. Compile the AppleScripts to `.app` bundles:
   ```sh
   ./build.sh
   ```
   This compiles every non-probe `.applescript` in the directory into a matching `.app` (e.g. `connect-ipad.applescript` → `ConnectIpad.app`). Re-run it any time you edit a script.

3. In the Stream Deck app, drag **System → Open** onto a button and point it at the `.app` you want.
   - For scrcpy with state-aware icon, use **Stream Deck → Multi Action Switch** with `StartScrcpy.app` on State 0 and `StopScrcpy.app` on State 1, plus `icon-start.png` / `icon-stop.png` as the icons.

4. First press will trigger a macOS prompt to grant Accessibility permission to the `.app` — accept.

## Customizing icons

`make-icons.swift` renders SF Symbols to PNG. Edit the symbol name or tint and re-run:
```sh
swift make-icons.swift
```
