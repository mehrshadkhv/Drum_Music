# README update reference notes

## External badge references

- https://shields.io/badges — static badge URLs use label-message-color; query options support logo and logoColor. Underscores render as spaces, doubled dashes render as literal dashes.
- https://shields.io/docs/static-badges — confirms img.shields.io static image URLs and URL-encoded labels/messages.

## Repository evidence

- pubspec.yaml: drum_music, placeholder description, publish_to none, version 1.0.0+1; Dart ^3.12.0; Flutter SDK, audioplayers ^6.8.1, cupertino_icons ^1.0.8; flutter_test SDK and flutter_lints ^6.0.0; no build_runner.
- pubspec.lock: Dart >=3.12.0 <4.0.0; Flutter >=3.44.0. cupertino_icons resolves to 1.0.9; audioplayers resolves to 6.8.1. http and path_provider are transitive dependencies, not application services.
- lib/main.dart is the only application Dart file. Application -> MaterialApp -> DrumPage -> _DrumPageState. Stack combines amber background, contained illustration, SafeArea, 3 rows x 2 transparent GestureDetector regions. Top row h1/h2, middle c1/c2, bottom k1/k2. New AudioPlayer per tap; tracks players, disposes on completion and page disposal. No setState, state management package, backend, recording, storage, settings, or code generation.
- LICENSE: MIT; copyright 2026 Mehrshad Khodavirdizadeh.
- .metadata, Android and web files: only android and web platform folders present. Native Android entry is the default FlutterActivity. Android build targets Java 17 and still uses debug signing for release.
- Image inventory: assets/images/drum.png is a 512x512 illustration, not a screenshot. assets/screenshots/drum-music.png is an existing 1280x2856 app screenshot. No demo GIFs found outside generated/build caches.
- Git remote: https://github.com/mehrshadkhv/Drum_Music.git (remote named Drum).
- Pre-existing working-tree changes: deleted test/widget_test.dart; untracked assets/screenshots/. Preserve both.
- Git tracks Assets/Images/ and Assets/Sounds/, but on-disk paths and source references use assets/images/ and assets/sounds/. Document a two-step casing normalization for each directory; do not rename application assets in this documentation-only task.
- No AGENTS.md found in the workspace tree excluding generated/cache directories. README.fa.md and .gitattributes do not exist before this update.
