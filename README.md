# VoiceVault — Connect IQ app scaffolding

VoiceVault is a lightweight audio memo app for Garmin watches (Connect IQ).

Quick start

1. Install the Connect IQ SDK from https://developer.garmin.com/connect-iq/.
2. Set `CONNECTIQ_HOME` to your SDK installation path, for example:

```bash
export CONNECTIQ_HOME="$HOME/connectiq-sdk"
```

If your SDK is installed under `~/Library/Application Support/Garmin/ConnectIQ/Sdks`, the build script will detect it automatically.

The Connect IQ compiler is officially tested with Java 8. If your system is using a newer JDK, set `JAVA_HOME` to the installed Azul Java 8 before building:

```bash
export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home"
export PATH="$JAVA_HOME/bin:$PATH"
```

3. Build the app:

```bash
./build.sh
```

What's included

- `manifest.xml` — Connect IQ manifest (app id, permissions, resources)
- `source/app.mc` — initial Monkey C app skeleton and UI stub
- `source/recorder.mc` — recorder stub for audio capture flow
- `resources/strings/en-US/strings.xml` — example strings
- `resources/icon.png` — included app icon
- `build.sh` — simple build helper using `monkeyc`
- `.gitignore`

Next steps

- The included `resources/icon.png` is already configured as the app icon.
- Implement secure recording and storage using the Connect IQ audio APIs.
- Add unit tests and integrate with CI if desired.
