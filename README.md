# MMXVN 2.12 — Tag Team + Beta Co-op

Mod by **nooraldeen** (GitHub: Nooraldeen23).

This is a **Beta**. Known bugs and crashes remain. Bug reports and community fixes are welcome.

## What this repository contains

Editable GML code exported from the current playable mod, including Tag Team, the secret encounter, co-op networking, menus and related player logic. This is a source companion for modifying the released Beta; it is **not** the original GameMaker project and cannot compile a complete game from scratch.

The game executable, textures, audio, saves and the original GameMaker `.yyp` project are not included. Some exported events include existing MMXVN code alongside mod changes; original authorship is retained.

## Features

- Tag Team switching between X and Zero in solo play.
- A secret encounter and unlockable Separate Health / Separate Sub Weapon Energy upgrades in solo play.
- Online Host / Join co-op over a reachable IP address (LAN or a suitable VPN).
- Each player chooses X or Zero; guest palettes are purple.
- Independent loadouts, shared Nightmare Soul rewards, private health/ammo/life pickups.
- Two reserve lives per player, with spectating after lives run out.
- Double boss HP in co-op only. Secret encounters and Separate upgrades are excluded from co-op.
- Native Button Bindings accessible through Customise Controls.

Local same-window co-op is not included. A relay service and automatic internet matchmaking are not included.

## Editing the mod

1. Download the matching playable Beta and make a separate copy of its game folder and saves.
2. Install [UndertaleModTool](https://github.com/UnderminersTeam/UndertaleModTool) from its official project.
3. Open the released `data.win` and locate the matching code entry by the filename in `src/`.
4. Edit the GML and replace that entry in the tool, then save to the separate game copy.
5. Test solo and both Host / Join roles. Include the reproduction steps with a fix.

The released `data.win` is required because it contains custom objects, sprites, sounds and resource indexes referenced by this code. Applying these files directly to an unmodified MMXVN installation is not supported.

### Batch import using UndertaleModCli

From the repository root, with an existing `build` directory:

```powershell
UndertaleModCli.exe load "C:/path/to/matching-beta/data.win" -s tools/import-mod.csx -o build/data.win -f
```

The importer checks that every exported code entry exists before replacing anything. It does not add missing assets or objects. See `release-manifest.json` for the matching base SHA-256.

## Reporting bugs

Use Issues with the mode (solo / co-op Host / co-op Join), stage, both selected characters, reproduction steps and the exact Code Error text if available. Remove personal information before attaching logs. Explain what should happen and what actually happened.

## Contributing

Keep co-op balance changes inside `coop_enabled()` checks and preserve solo behavior. Test both Host / Join character combinations and normal Continue when changing shared player, menu or save code. Do not commit personal saves, logs, credentials or game binaries.

## Credits and permissions

MMXVN / The Cat Yard; Dragoon Mod / RaylerProductions. Mega Man / Rockman characters and original game material belong to CAPCOM and their respective creators. See `CREDITS.txt` and `THIRD-PARTY-NOTICES.txt`.

No blanket MIT or other new license is assigned to third-party material. This repository does not claim ownership of the base game or its assets; existing third-party terms remain applicable.
