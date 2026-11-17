# Student Navigation App

Jolex Pasignasigna | Student ID 557989 | BSIT, 3rd Year | CCE106(3450)

Flutter package: `pasignasigna_navigation_app`. The existing workspace folder and
platform application identifiers are retained to preserve the original project.

## Run

From this directory in PowerShell:

```powershell
flutter pub get
flutter run -d edge
```

For an Android device or emulator, run `flutter devices`, then
`flutter run -d <device-id>`. iOS builds require macOS and Xcode.

## Features

- Login with `admin` / `admin123`, or register your own username and password.
- Registration validates a username of at least 3 characters, reserves `admin`
  without regard to case, requires a nonblank password of at least 6 characters,
  and checks confirmation. Password whitespace and case are significant.
- The newest registration replaces the previous account. Demo credentials stay
  in process memory, survive logout, and clear on full restart/browser reload.
  Hot reload preserves them. The default admin account is always available.
- Home introduces the three other pages and includes logout. Logout clears
  `DemoAuth.currentUsername` and removes the protected navigation routes.
  Each new login creates a fresh sample feed. Full restart clears demo accounts,
  posts, likes and comments. No backend or persistent storage is used.
- Calculator supports signed decimal numbers, addition, subtraction,
  multiplication, division, input validation, zero-division protection, and Clear.
- Profile includes the JP avatar, introduction, hobbies and school email from
  https://github.com/saltylex/student_profile_app, plus the supplied personal details.
- Social Media now contains a student feed with two sample posts. Create a post
  using a caption and HTTP/HTTPS image URL; new posts use the logged-in username.
  Like/unlike posts, add comments, and switch tabs without losing feed state.
- The feed app bar opens **My social links**, preserving your Facebook, Instagram
  and TikTok profiles. Links open in a new browser tab on web; Copy link works
  on all platforms.
- `MainScreen` uses `setState` with `NavigationBar` and `IndexedStack`, keeping
  calculator values/results and page scroll positions while switching tabs.

## Modules

| File | Responsibility |
| --- | --- |
| `lib/main.dart` | StudentApp entry point, theme and initial login route |
| `lib/demo_auth.dart` | In-memory demo account registration and authentication |
| `lib/login_screen.dart` | Login validation, visibility toggle and route replacement |
| `lib/register_screen.dart` | Account validation and registration, then return to login |
| `lib/main_screen.dart` | Four bottom destinations and preserved page state |
| `lib/home_page.dart` | Welcome, application overview and logout |
| `lib/calculator_screen.dart` | Two-input arithmetic, result, validation and Clear |
| `lib/profile_page.dart` | Student identity, course/year, subject/section and email |
| `lib/social_media_page.dart` | Personal account links, opened from the feed app bar |
| `lib/social_media/post.dart` | Immutable post author, caption and image URL |
| `lib/social_media/create_post_sheet.dart` | Scrollable post form, validation and return value |
| `lib/social_media/post_card.dart` | Network image/fallback, like and comment state |
| `lib/social_media/social_media.dart` | Sample feed, modal form and keyed post insertion |
| `lib/profile_link.dart` | Shared selection message and Copy link action |
| `lib/profile_link_web.dart` | Opens a browser tab using Dart JS interop |
| `lib/profile_link_stub.dart` | Keeps native builds compatible with Copy link |

No Lab Activity 4 calculator was present, so a new `CalculatorScreen` implements
all listed calculator requirements. The original authentication app, tests and
README are preserved in `docs/archive` as reference material outside the build.
No new runtime packages are required.

## Checks

```powershell
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
flutter build web
```

Widget tests cover demo account replacement and admin access, login and register
validation, password visibility and exact matching, logout and repeated login,
all arithmetic operations, invalid/nonfinite inputs, division by zero, numeric
overflow, Clear, all destinations, personal-account feedback and copied URLs, state preservation,
and a 320 x 568 screen with a simulated keyboard inset. Feed tests cover
empty/invalid URLs, post ordering and author, cancellation, image fallback,
like/unlike, trimmed/blank comments, offscreen state, insertion without losing
reactions, tab switching, logout route removal and registered-user posts.

## Submission

Repository: https://github.com/saltylex/Room5activity

Screenshots and module documentation are in `docs/`. Google Docs/PDF delivery
links and verification results for the prior activity are in `docs/submission.md`.

The current social-feed activity report is in `docs/feed_submission.md`, with
five screenshots, completed testing/tracing tables, a native Google Doc and
`docs/Pasignasigna_Social_Feed.pdf`. The PDF is ready for manual Blackboard upload.
Network images require internet; blocked or unavailable images show a placeholder.
Android release builds include INTERNET permission; macOS entitlements permit
outbound image requests. iOS/macOS and physical-device behavior need manual testing.
