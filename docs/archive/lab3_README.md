# Jolex Auth Lab

Flutter Lab Activity 3 by Jolex Pasignasigna.

Course code shown in the app: **CCE106(3450)**.

## Run

```sh
flutter pub get
flutter run
```

Choose an available device (for example, `flutter run -d edge` on Windows).

## Practice flow

1. Open **Need an account? Register**.
2. Register **Jolex Pasignasigna**, **Jolex@example.com**, **Jolex123**.
3. After the success message, log in using the same email and password.
4. The welcome screen shows the name and normalized email, `jolex@example.com`.
5. Log out, then log in again. The account remains available.
6. Fully restart the app (or reload the browser page); the account is cleared.
   Hot reload preserves state and does not clear the account.

Only one account can be registered per app session. This classroom example
keeps credentials in memory and has no server or persistent storage.
Names and emails are trimmed, emails are lowercased, and password case and
whitespace are preserved. Passwords must contain at least eight characters.

## Automated checks

```sh
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
```

The widget tests cover required fields, invalid emails, short passwords,
confirmation mismatch, password visibility, switching forms, login before
registration, successful registration, duplicate registration, wrong credentials,
normalized names and emails, exact passwords, welcome details, logout and reuse,
fresh app state clearing the account, and a 320 x 568 screen with a keyboard inset.
Fresh app state is simulated by disposing and rebuilding the complete app.

## Build

```sh
flutter build web
```

Physical Android/iOS device behavior and real mobile keyboard interaction
require manual testing. The widget suite simulates a small screen and keyboard
inset.
