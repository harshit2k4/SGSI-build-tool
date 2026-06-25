# Changelog

All notable changes to this project will be documented in this file.

## [Unreleased] - 2026

### Added
- **Android 13–16 Support:** Upgraded the `check_source_version` to support API 33, 34, 35, and 36 natively.
- **Dynamic VNDK APEX Downloader:** Instead of bundling heavy `.7z` files, the tool now downloads VNDK versions (29–36) on the fly during the build process if missing.
- **Partition Extraction:** Added support for `odm` and `vendor_dlkm` partitions in the image extractor.
- **Documentation:** Added English `README.md`, `CONTRIBUTING.md`, and `CHANGELOG.md`.

### Changed
- **Python 3 Modernization:** Removed all dependencies on Python 2. Updated shebangs to `python3`, migrated `import imp` to `importlib`, and removed `get-pip.py`.
- **Dependencies Update:** Replaced Java 8/11 with Java 17. Updated `protobuf` requirement to `>=4.21,<6`.
- **Branding Update:** Changed default upstream tracking repo to `harshit2k4` fork. Updated welcome text while retaining original author credits.
- **Shell Script Quality:** Replaced backticks with `$(cmd)`, quoted variables properly, and removed dangerous `chmod -R 777` calls across scripts.

### Removed
- **Bloat:** Removed bundled `get-pip.py`.
- **Legacy Modules:** Removed outdated `six` dependency.
