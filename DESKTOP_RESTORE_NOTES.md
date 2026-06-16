# Desktop Restore Notes

This file records the local end4 Hyprland changes applied on June 16, 2026, and the lessons needed to restore or maintain them safely.

## Changed Areas

- `dots/.config/hypr/custom/general.lua`
  - External monitor `DP-1`: `2560x1440@144`, position `0x0`, scale `1`.
  - Laptop display `eDP-1`: `1920x1200`, position `2560x0`, scale `1`.
  - Hyprland spacing: `gaps_in = 2`, `gaps_out = 2`, `border_size = 1`, snap gaps `2`.

- `dots/.config/hypr/hyprland/keybinds.lua`
  - `SUPER + SHIFT + K`: on-screen keyboard.
  - `SUPER + SHIFT + L`: lock session.
  - `SUPER + H/L`: horizontal `swapsplit`.
  - `SUPER + J/K`: vertical split toggle.
  - `SUPER + SHIFT + 1..0`: send focused app/window to workspace 1..10.
  - Shifted-symbol fallbacks are also present for `SUPER + !/@/#/$/%/^/&/*/(/)`.

- `dots/.config/kitty/kitty.conf`
  - Small padding and transparent background.

- `dots/.config/foot/foot.ini`
  - Small padding and transparent background.

- `dots/.config/systemd/user/xdg-desktop-portal.service`
  - User-level override for the generic portal service.
  - Removes the packaged `Requisite=graphical-session.target`, because this Hyprland session does not activate that target.
  - Required for Firefox screen sharing to reach the portal on this setup.

- `dots/.config/gtk-3.0/settings.ini` and `dots/.config/gtk-4.0/settings.ini`
  - GTK app font set to `Noto Sans 11`.

## Keybinding Lessons

This setup uses end4's Lua Hyprland layer. Avoid plain Hyprland dispatcher strings unless the local Lua layer explicitly supports them.

The workspace move binding must use:

```lua
hl.dsp.window.move({ workspace = i, follow = false })
```

Do not use:

```lua
hl.dsp.exec_cmd("hyprctl dispatch movetoworkspacesilent " .. i)
```

On this system, `hyprctl dispatch movetoworkspacesilent N` is parsed as Lua shorthand and fails instead of moving a window.

Raw `code:` number binds did not register reliably through the end4 Lua config. The working bind set is symbolic number binds plus shifted-symbol fallbacks.

## Verification Commands

Run these after editing Hyprland files:

```sh
luac -p ~/.config/hypr/hyprland/keybinds.lua
hyprctl reload
hyprctl configerrors
hyprctl binds -j
```

For workspace move behavior, test the Lua dispatcher directly:

```sh
hyprctl dispatch 'hl.dsp.window.move({ workspace = 10, follow = false })'
hyprctl dispatch 'hl.dsp.window.move({ workspace = 3, follow = false })'
```

## Firefox Screen Sharing

Firefox screen sharing requires:

- `xdg-desktop-portal.service`
- `xdg-desktop-portal-hyprland.service`
- `xdg-desktop-portal-gtk.service`
- PipeWire

The packaged `xdg-desktop-portal.service` has `Requisite=graphical-session.target`. In this local Hyprland session, that target remains inactive, so the packaged unit fails with a dependency error. The restore repo includes a user unit override at:

```text
dots/.config/systemd/user/xdg-desktop-portal.service
```

Hyprland startup also imports the Wayland/session environment into user systemd and restarts portal services from:

```text
dots/.config/hypr/hyprland/execs.lua
```

Verify the portal with:

```sh
systemctl --user status xdg-desktop-portal xdg-desktop-portal-hyprland xdg-desktop-portal-gtk
busctl --user introspect org.freedesktop.portal.Desktop /org/freedesktop/portal/desktop org.freedesktop.portal.ScreenCast
```

Expected: the generic portal and Hyprland portal are active, and the `ScreenCast` interface exposes `CreateSession`, `SelectSources`, `Start`, and `OpenPipeWireRemote`.

After changing portal state, restart Firefox before retesting screen sharing.

## GTK Fonts

The active GTK/GNOME font settings are:

```text
font-name: Noto Sans 11
document-font-name: Noto Sans 11
monospace-font-name: Noto Sans Mono 11
```

`gtk-3.0/settings.ini` and `gtk-4.0/settings.ini` should only set `gtk-font-name=Noto Sans 11`; document and monospace font preferences are handled through `gsettings`.

Do not reintroduce Adwaita font settings unless explicitly requested.

## Audio State

Installed and verified packages for microphone support:

- `pipewire`
- `pipewire-audio`
- `pipewire-pulse`
- `pipewire-alsa`
- `pipewire-jack`
- `wireplumber`
- `alsa-utils`
- `alsa-plugins`
- `sof-firmware`
- `rtkit`
- `pavucontrol`
- `easyeffects`
- `qpwgraph`
- `gst-plugin-pipewire`
- `noise-suppression-for-voice`
- `bluez`
- `bluez-utils`

After installing `rtkit`, restart user audio services so PipeWire gets realtime scheduling:

```sh
systemctl --user restart pipewire pipewire-pulse wireplumber
```

Verify with:

```sh
wpctl status
pactl info
pactl list short sources
arecord -l
systemctl status rtkit-daemon.service
```

## Backup Policy

Before every edit, create a `.bak-*` file beside the edited file. After verifying the change, move backups to a timestamped folder under:

```text
~/Downloads/dotfiles-bak-YYYYMMDD-HHMM/
```

Do not commit backup files.
