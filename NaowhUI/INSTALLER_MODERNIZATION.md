# NaowhUI Installer Modernization

## Overview
The NaowhUI installer has been modernized to remove dependency on ElvUI's PluginInstaller frame and now uses a standalone, clean installer interface similar to WagoUI packs.

## Changes Made

### 1. New Standalone Installer Frame
- **Location**: `Core/Modules/Installer/InstallerFrame.lua`
- Created a completely new installer frame using native WoW API
- Features:
  - Clean, modern UI design
  - Step-by-step navigation with visual progress
  - Resizable and draggable window
  - Professional styling with custom textures
  - No dependency on ElvUI

### 2. Core Installer Module
- **Location**: `Core/Modules/Installer/Installer.lua`
- Base installer module that initializes the installer system

### 3. Updated Game-Specific Installers
- **Standard**: `Standard/Modules/Installer/Installer.lua`
- **Vanilla**: `Vanilla/Modules/Installer/Installer.lua`
- **Mists**: `Mists/Modules/Installer/Installer.lua`

All installer files have been updated to use the new frame system instead of `PluginInstallFrame`.

### 4. Modified Core Functions
- **Location**: `Core/General/Functions.lua`
- Updated `RunInstaller()` to use the new installer frame
- Removed ElvUI dependency for installer launching
- Updated `OpenSettings()` to work with the new frame

### 5. Backward Compatibility
- Maintained compatibility layer so existing installer code continues to work
- NaowhUI_Data can still be used for importing settings and profiles
- All existing functionality preserved

## Key Features

### Modern UI
- Clean, professional appearance
- Step navigation panel on the left
- Large content area for installation options
- Progress tracking with visual indicators

### Enhanced User Experience
- Drag and drop window positioning
- Clear step-by-step progression
- Better visual feedback
- More robust error handling

### Extensible Design
- Easy to add new installation steps
- Modular structure for different game versions
- Simple to customize appearance and behavior

### No ElvUI Dependency
- Installer works independently of ElvUI
- Falls back gracefully if ElvUI is not installed
- Maintains all original functionality

## Usage

The installer is launched the same way as before:
- `/nui install` command
- Addon compartment button click
- Direct function call: `NUI:RunInstaller()`

## Technical Details

### Frame Structure
```
NaowhUIInstallerFrame (Main Frame)
├── Header Panel (Title + Close Button)
├── Step Navigation Panel (Left Side)
│   └── Scrollable Step List
├── Content Panel (Right Side)
│   ├── Subtitle
│   ├── Description Text (3 lines)
│   └── Option Buttons (3 max)
└── Navigation Panel (Bottom)
    ├── Previous Button
    ├── Skip Button
    └── Next/Finish Button
```

### Data Import
- NaowhUI_Data remains unchanged
- All profile importing functionality preserved
- Same data structure and loading mechanisms

## Future Enhancements

The new installer framework makes it easy to add:
- Multiple installation profiles
- Progress bars for long operations
- Preview images for settings
- More sophisticated navigation
- Custom themes and styling
- Plugin-specific installation options

## Compatibility

- Works with all supported WoW versions (Retail, Classic, Mists)
- Maintains backward compatibility with existing code
- NaowhUI_Data addon remains fully functional
- All existing chat commands and functionality preserved
