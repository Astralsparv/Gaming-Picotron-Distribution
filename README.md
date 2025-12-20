--[[pod_format="raw",created="2025-12-20 06:21:04",modified="2025-12-20 06:21:04",revision=0]]
# Gaming Picotron Distribution
An attempt to make a SteamOS/PS3-like distribution for Picotron.

## Current development status (as of 20/12/2025)

Will be setting this up to work fully controller & fully mouse in future

Custom thin primary font

ALT+T anywhere to open a terminal (reboot & shutdown is unlocked in all terminal processes)

XMB menu:

* controller only
* swap distributions (in system - distro is temporary, boot into bios to permenantly change the distribution, stops controller-only devices from locking themselves)
* enter game menus (bbs & all games)
* reboot button (in system)

Game menu:

* controller & mouse support
* displays first 8 games in `/games`
* lets you open games

BBS:

* loads from the Picotron BBS
* loads first 48 games
* temporarily cached, cannot be downloaded as of now
* weird bug where fs.lua crashes for async fetch when opening the bbs - doesn't always happen?

Within games:

* windowed games are their own workspace (no wallpaper, for now?)
* controller can act as mouse (depends on profile)

## Settings files:

### `/appdata/system/gaming/..`

#### `settings.pod`

```
overlayCombination=(combination) --reserved, no use rn
wallpaper=(filepath) --wallpaper used for the dashboard
volume=(0-255)  --system volume, 64 is Picotron default
```
### `/appdata/system/gaming/profiles/bbs/`

Can create profiles for bbs games, named as `bbs_id.pod`, e.g:

`minesweeper_picotron.pod`
```lua
{
    controllerPointer={
        active=true,
        sensitivityX=2.5,
        sensitivityY=2.5,
    }
    networkAccess=false
}
```

### `/appdata/system/gaming/profiles/preset/`

Profiles for non bbs games, named as `profilename.pod`, written the same as BBS profiles.

These are detected by the `gaming_profile` metadata value of the cartridge.

## Credits

@thelxinoe5's widesquat font