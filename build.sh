#!/usr/bin/env bash
set -e
# Build helper for Connect IQ. Configure CONNECTIQ_HOME or let the script detect a common macOS SDK path.
if [ -n "$JAVA_HOME" ]; then
  export PATH="$JAVA_HOME/bin:$PATH"
fi
if [ -z "$JAVA_HOME" ]; then
  JAVA_8_HOME=$(/usr/libexec/java_home -v 1.8 2>/dev/null || true)
  if [ -n "$JAVA_8_HOME" ]; then
    export JAVA_HOME="$JAVA_8_HOME"
    export PATH="$JAVA_HOME/bin:$PATH"
  fi
fi
JAVA_VERSION=$(java -version 2>&1 | head -1 | awk -F '"' '{print $2}')
JAVA_MAJOR=$(echo "$JAVA_VERSION" | awk -F. '{print $1}')
if [ "$JAVA_MAJOR" = "1" ]; then
  JAVA_MAJOR=$(echo "$JAVA_VERSION" | awk -F. '{print $2}')
fi
if [ -n "$JAVA_MAJOR" ] && [ "$JAVA_MAJOR" -gt 17 ]; then
  echo "Warning: Detected Java $JAVA_VERSION. Connect IQ 9.1 is officially tested on Java 8."
  echo "Set JAVA_HOME to Azul Java 8 if installed:"
  echo "  export JAVA_HOME=\"/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home\""
  echo "  export PATH=\"$JAVA_HOME/bin:$PATH\""
fi
SDK_HOME="${CONNECTIQ_HOME:-}"
if [ -z "$SDK_HOME" ]; then
  if [ -d "$HOME/connectiq-sdk" ]; then
    SDK_HOME="$HOME/connectiq-sdk"
  elif [ -d "$HOME/Library/Application Support/Garmin/ConnectIQ/Sdks" ]; then
    for sdk in "$HOME/Library/Application Support/Garmin/ConnectIQ/Sdks"/*; do
      if [ -x "$sdk/bin/monkeyc" ]; then
        SDK_HOME="$sdk"
        break
      fi
    done
  fi
fi
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
