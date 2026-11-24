# Rancakara Open World — UE5 Foundation

This is an original Unreal Engine 5 C++ project scaffold. It does not contain or reuse GTA/Rockstar source code, maps, models, audio, branding, or other proprietary assets.

## Current status

- Project descriptor: added
- C++ game and editor targets: added
- Runtime module: added
- Editor/build verification: not yet performed (requires Unreal Engine 5 on Windows, macOS, or Linux)
- Android packaging: not configured or tested yet

## Open on a computer

1. Install a compatible Unreal Engine 5 version through the Epic Games Launcher (Windows) or the official source/build workflow for your OS.
2. Download/clone this repository and check out branch `ue5-foundation`.
3. Open `RancakaraOpenWorld.uproject` and allow Unreal to generate project files.
4. Build the Editor target and resolve any engine-version adjustments if prompted.
5. Create the first test level using original placeholder assets.

The project target currently uses UE 5.6 build include-order settings. If a different UE5 minor version is installed, adjust the target settings to that version before compiling.

## Mobile-first development constraints

The intended first device test is Android. Begin with a small test map, Mobile renderer-compatible materials, baked/static lighting where practical, low-cost shadows, limited view distance, and a 30 FPS target. Do not assume Nanite or Lumen desktop features will run on the target phone.

## Planned modules

- Player and touch controls
- Vehicle physics and driving
- Small original city block
- Mission and save systems
- Android performance profile

## Important

This repository scaffold is source structure only, not a compiled game or APK. A real UE5 editor/build environment is required to compile, create levels/assets, and package Android builds.
