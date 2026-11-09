#!/bin/sh
# Reconstruccion reproducible del firmware NanoVNA-H 1.2.27 ES v2.
# Proyecto base: https://github.com/hugen79/NanoVNA-H
# Requiere: git, bsdtar, make, arm-none-eabi-gcc.
set -eu
ROOT=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
BASE="$ROOT/NanoVNA-H-original"
if [ -e "$BASE" ]; then
  echo "Ya existe $BASE; no se sobrescribe." >&2
  exit 1
fi
git clone https://github.com/hugen79/NanoVNA-H.git "$BASE"
git -C "$BASE" checkout --detach a629229db42bbad1c6a8e3dd8b510281972faf3a
git -C "$BASE" apply "$ROOT/traduccion_es_v2.patch"
cd "$BASE"
bsdtar -xf ChibiOS.7z
make -j4 TARGET=F072
echo "Compilacion finalizada: $BASE/build/H.bin"
