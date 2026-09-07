#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PKG_DIR="$ROOT/packages/ucrt64"

mkdir -p "$PKG_DIR"
rm -f "$PKG_DIR"/*.pkg.tar.zst "$PKG_DIR"/custom.db "$PKG_DIR"/custom.db.tar.gz "$PKG_DIR"/custom.files "$PKG_DIR"/custom.files.tar.gz

found=0
for pkgbuild in "$ROOT"/PKGBUILDs/*/PKGBUILD; do
    [ -f "$pkgbuild" ] || continue
    found=1
    pkgdir="$(dirname "$pkgbuild")"
    echo "==> Building $pkgdir"
    cd "$pkgdir"
    rm -rf src pkg
    makepkg --noconfirm --cleanbuild --clean
    cp ./*.pkg.tar.zst "$PKG_DIR/"
done

if [ "$found" -eq 0 ]; then
    echo "No PKGBUILDs found."
    exit 1
fi

cd "$PKG_DIR"
repo-add custom.db.tar.gz ./*.pkg.tar.zst

echo "==> Repository created in $PKG_DIR"
ls -lh
