# Custom Pacman Repo 🚀

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
│       ├── PKGBUILD
│       └── hello-custom.sh
├── packages/
│   └── ucrt64/
├── repo/
│   └── ucrt64/
├── scripts/
│   └── build-repo.sh
└── .github/
    └── workflows/
        └── build-repo.yml
```

## 🤖 Automatic builds

GitHub Actions automatically builds the packages whenever relevant files are pushed to `main`, or when the workflow is manually dispatched.

The workflow:

1. Starts a Windows runner.
2. Sets up an **MSYS2 UCRT64** environment.
3. Installs the MSYS2 build tools.
4. Finds every `PKGBUILD` under `PKGBUILDs/`.
5. Builds each package with `makepkg`.
6. Creates the Pacman repository database with `repo-add`.
7. Packages the resulting repository for GitHub Pages.
8. Deploys the repository automatically.

So adding another package can be as simple as adding another directory under `PKGBUILDs/`.

### Workflow file

```text
.github/workflows/build-repo.yml
```

### Local build script

You can also build the repository locally from an MSYS2 UCRT64 terminal:

```bash
bash scripts/build-repo.sh
```

The generated repository files are placed under:

```text
packages/ucrt64/
```

## 🌐 Using the hosted repository

After GitHub Pages is enabled for the repository's GitHub Actions deployment, the UCRT64 repository is published at:

```text
https://carjam120443-netizen.github.io/custom-pacman-repo/ucrt64
```

Add this to the **MSYS2** `/etc/pacman.conf`:

```ini
[custom]
SigLevel = Optional TrustAll
Server = https://carjam120443-netizen.github.io/custom-pacman-repo/ucrt64
```

Then synchronize and inspect it:

```bash
pacman -Sy
pacman -Sl custom
```

And install a package with:

```bash
pacman -S custom/hello-custom
```

> ⚠️ **Important:** This configuration is intended for **MSYS2**, not a normal Arch Linux installation. Do not assume the repository works with Arch Linux `pacman`.

## 📦 Building packages

Packages are built with MSYS2's `makepkg` and distributed as `.pkg.tar.zst` files.

Typical manual workflow:

```bash
makepkg -f
repo-add custom.db.tar.gz *.pkg.tar.zst
```

The automated workflow handles these steps for packages in this repository.

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

## ⚠️ Compatibility warning

This project is **not an Arch Linux repository**.

MSYS2 has its own runtime environments, toolchains, package naming conventions, repositories, and dependency ecosystem. Do not mix standard Arch repositories, AUR packages, or Chaotic-AUR packages into MSYS2 unless compatibility has been specifically verified.

A package built for `UCRT64` should also not automatically be assumed compatible with `MSYS`, `CLANG64`, `CLANGARM64`, or other MSYS2 environments.

## License

Package licenses may vary. Check each package's `PKGBUILD` and accompanying files for its individual license.
