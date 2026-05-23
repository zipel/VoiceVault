#!/usr/bin/env bash
set -e
# Build helper for Connect IQ (monkeyc). Configure CONNECTIQ_HOME or CONNECTIQ_HOME env.
SDK_HOME="${CONNECTIQ_HOME:-$HOME/connectiq-sdk}"
if [ -z "$SDK_HOME" ]; then
  echo "Set CONNECTIQ_HOME to your Connect IQ SDK path."
  exit 1
fi
MONKEYC="$SDK_HOME/bin/monkeyc"
if [ ! -x "$MONKEYC" ]; then
  echo "monkeyc not found at $MONKEYC"
  exit 1
fi
mkdir -p build
"$MONKEYC" -f manifest.xml -o build/VoiceVault.prg
