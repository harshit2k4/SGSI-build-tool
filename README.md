# SGSI Build Tool

A powerful, automated tool for building SGSI (Semi-Generic System Image) from various Android firmwares. 
This is a modern fork updated for newer Android versions (12–16) and Python 3 compatibility.

*Forked & Maintained by: [harshit2k4](https://github.com/harshit2k4)*  
*Original Author: [Xiaoxindada](https://github.com/xiaoxindada)*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## 🌟 Features
- Supports Android 12, 13, 14, 15, and 16
- Compatible with dynamic partitions (super.img) and payload.bin
- Ext4, EROFS, F2FS, and SquashFS support
- Builds both A-only and A/B partition structures
- Debloating, vendor boot packing/unpacking, and more
- Multi-language support (English & Chinese)

## 📋 System Requirements
- Ubuntu 22.04 LTS or 24.04 LTS (Debian-based systems)
- Python 3.10+
- Java 17

## 🚀 Installation & Setup

1. **Clone the repository:**
   ```bash
   git clone --recurse-submodules https://github.com/harshit2k4/SGSI-build-tool.git
   cd SGSI-build-tool
   ```

2. **Install dependencies:**
   *(Run this once to configure your environment)*
   ```bash
   ./setup.sh
   ```

3. **Keep the tool updated:**
   ```bash
   ./update.sh
   ```

## 🛠️ Usage

### 1. Building a SGSI

Place your firmware (`.zip` or `.img`) in the `tmp/` folder (or provide the path).

**Build an A/B image:**
```bash
./make.sh --ab <ROM_TYPE> <Path_to_Firmware> [--fix-bug]
```

**Build an A-only image:**
```bash
./make.sh -a <ROM_TYPE> <Path_to_Firmware> [--fix-bug]
```

**Example:**
```bash
./make.sh --ab Pixel ./tmp/pixel-ota.zip --fix-bug
```

*Note: If your firmware is a `super.img`, place it in the root directory and use `./unpacksuper.sh` first, then run `./SGSI.sh <Build Type> <ROM_TYPE>`.*

### 2. Available Utilities
The tool includes several scripts for specialized operations:
- `makeimg2.sh` / `unpackimg.sh`: General image packing/unpacking
- `makeboot.sh` / `unpackboot.sh`: boot.img / vendor_boot.img tools
- `makesuper.sh` / `unpacksuper.sh`: Dynamic partition (super) tools
- `makedtbo.sh` / `unpackdtbo.sh`: DTBO packing/unpacking
- `img2sdat.sh`: Generate `.dat` / `.br` files
- `apex.sh`: APEX flattening and extraction
- `unpack_ops.sh`: OPPO/OnePlus OPS unpacking

### 3. Cleanup Workspace
To clean up your workspace and remove temporary files:
```bash
./rm.sh
```

## 🤝 Supported ROMs
- `Generic` (AOSP)
- `Pixel`

*(See `component/rom_support_list.txt` for the active list or add your own in `CONTRIBUTING.md`)*

## 🙏 Credits & Acknowledgements
This project builds upon the hard work of the community.
- **Original Author**: [Xiaoxindada](https://github.com/xiaoxindada)
- **Erfan GSIs**: [erfanoabdi](https://github.com/erfanoabdi)
- **MToolkit**: [Nightmare-MY](https://github.com/Nightmare-MY)
- **AndroidDump**: [AndroidDump](https://github.com/AndroidDump)
- Additional Credits: [Pomelo Jiuyu](https://github.com/pomelohan), [Col_or](https://github.com/color597), [thka2016](https://github.com/thka2016)

## 📜 License
Please do not use this tool for commercial purposes without permission from the original authors.
