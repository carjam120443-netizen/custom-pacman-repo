# Custom Pacman Repo

A custom **MSYS2 Pacman package repository** for packages built for MSYS2 environments.

> ⚠️ **MSYS2-specific:** Packages in this repository are intended for MSYS2. They are **not ordinary Arch Linux packages/repositories**, and normal Arch Linux `pacman` may not work with them. Likewise, Arch repositories such as AUR/Chaotic-AUR should not be assumed to work in MSYS2.

## What is this?

This repository hosts custom packages and repository metadata for the **MSYS2** package manager, Pacman. It is intended for experimenting with and distributing packages built using MSYS2's packaging tools.

## Supported MSYS2 environments

Packages may target specific MSYS2 environments, including:

- `UCRT64`
- `CLANG64`
- `CLANGARM64`
- `MSYS`
- `MINGW64` (legacy/deprecated environment)

Packages should be placed in the appropriate environment-specific repository. A package built for one MSYS2 environment should not automatically be assumed compatible with another.

## Repository layout

```text
.
├── README.md
├── PKGBUILDs/
│   └── hello-custom/
├── packages/
│   └── ucrt64/
├── repo/
│   └── ucrt64/
└── scripts/
```

## Using the repository

When repository hosting and metadata are configured, an MSYS2 user can add the repository to the appropriate `/etc/pacman.conf`.

Example:

```ini
[custom]
SigLevel = Optional TrustAll
Server = https://carjam120443-netizen.github.io/custom-pacman-repo/$arch
```

Then synchronize and inspect it:

```bash
pacman -Sy
pacman -Sl custom
```

> **Important:** This configuration is intended for **MSYS2**, not a normal Arch Linux installation. Verify that the repository path matches your MSYS2 environment before installing packages.

## Building packages

Packages are built with MSYS2's `makepkg` and distributed as `.pkg.tar.zst` files.

Typical workflow:

```bash
makepkg -f
repo-add custom.db.tar.gz *.pkg.tar.zst
```

The package files and repository database can then be published through the repository's hosting mechanism.

## Current test package

The initial test package is `hello-custom`. It verifies the complete custom-repository workflow:

```text
PKGBUILD
   ↓
makepkg
   ↓
.pkg.tar.zst
   ↓
repo-add
   ↓
Pacman repository
   ↓
pacman -S custom/hello-custom
```

## Compatibility warning

This project is **not an Arch Linux repository**.

MSYS2 has its own runtime environments, toolchains, package naming conventions, repositories, and dependency ecosystem. Do not mix standard Arch repositories, AUR packages, or Chaotic-AUR packages into MSYS2 unless compatibility has been specifically verified.

## License

Package licenses may vary. Check each package's `PKGBUILD` and accompanying files for its individual license.
