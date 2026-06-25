# Contributing to SGSI-build-tool

We welcome contributions! Please follow these guidelines:

## Adding New ROM Support
If you want to add support for a new ROM (e.g., Samsung OneUI, Xiaomi HyperOS, ColorOS, etc.):
1. Add the ROM name to `component/rom_support_list.txt`.
2. Create a debloat script in `apps_clean/` (e.g., `oneui.sh`).
3. Create a patch script in `component/rom_make_patch/` (e.g., `oneui/make.sh`).
4. Update `fixbug/fixbug.sh` with the new ROM options and create a fix script like `fixbug/oneui.sh`.
5. Test building and booting before opening a PR.

## Code Style
- Use standard bash practices (`set -euo pipefail` where applicable).
- Always double-quote variables (`"$LOCALDIR"`) to prevent word splitting.
- Use `$(cmd)` instead of backticks `\`cmd\``.
- Do NOT use `chmod -R 777`. Use precise permissions where needed.
- Test your changes on Ubuntu 22.04 or 24.04 before submitting.
