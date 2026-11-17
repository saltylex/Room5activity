# Submission package

Student: Jolex Pasignasigna (557989), BSIT, 3rd Year, CCE106(3450)
Email: Jolex129@gmail.com

- GitHub: https://github.com/saltylex/Room5activity
- Google Docs: https://docs.google.com/document/d/1u7I84YcahHcmr0C1bmJjMTEDCBGKvzzldtnCWTcy0CI/edit
- Exported report: [Pasignasigna_Navigation_App.pdf](Pasignasigna_Navigation_App.pdf)
- Four full-resolution screenshots: [Home](screenshots/01-home.png),
  [Calculator](screenshots/02-calculator.png), [Profile](screenshots/03-profile.png),
  [Social Media](screenshots/04-social-media.png).

The five-page PDF was exported from the native Google Doc, rendered and visually
checked. It contains documentation of all nine source modules and exactly four
screenshots, one for each bottom-navigation page.

## Verification

- `flutter pub get`: passed.
- `dart format --output=none --set-exit-if-changed lib test`: passed.
- `flutter analyze`: passed, no issues.
- `flutter test`: passed, six tests.
- `flutter build web --no-wasm-dry-run`: passed.
- `flutter build apk --debug`: passed; APK at
  `build/app/outputs/flutter-apk/app-debug.apk` (build artifacts are not committed).
- Headless Microsoft Edge: admin login, all four destinations, addition result,
  student profile, sample-account SnackBar and calculator input/result retention
  across tab changes passed. Screenshots captured at 430 x 850.
- Google Doc readback: all module text and four native inline images verified.
- PDF: five pages; each module screenshot remains with its explanation and caption.

`flutter doctor -v` found the Android toolchain and Edge available. Chrome is
not installed; use Edge. Physical mobile interaction, iOS and Windows native
builds were not tested. iOS builds require macOS/Xcode. The small-screen/keyboard
layout was covered by a widget test.

## Design choices and limits

No existing Lab 4 calculator was in this workspace, so a calculator meeting every
listed feature was implemented. Arithmetic uses Dart doubles (normal floating
point precision applies). Authentication is intentionally a classroom demo;
there is no backend, persistent account store or secure credential storage.
Social handles are samples. A full restart clears the registered demo account.

The Flutter package name is `pasignasigna_navigation_app`; the existing folder
and platform identifiers remain intact. Original lab code/tests and READMEs are
archived under `docs/archive`.
