# OpenSumo

OpenSumo is a macOS SwiftUI prompt design studio for building copy-ready AI music prompts with structured controls.

It provides a three-panel interface for shaping Suno-style music prompts through presets, genres, moods, vocals, instrumentation, production settings, effects, arrangement sections, and advanced prompt controls.

## Features

- Native macOS SwiftUI app
- MVVM structure
- Live generated music prompt preview
- Starter prompt presets
- Multi-select chips, checkboxes, sliders, pickers, toggles, and arrangement controls
- Local JSON preset persistence in Application Support
- Copy-to-clipboard support
- No network APIs, accounts, API keys, or external dependencies

## Build

```sh
swift build
```

## Run

```sh
swift run OpenSumo
```

## Release Build

```sh
swift build -c release
```
