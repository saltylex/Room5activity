# Requirements comparison

Source: the StatefulWidget and Bottom Navigation requirements supplied in chat.

| Requirement | Before | Completed implementation |
| --- | --- | --- |
| Project name lastname_navigation_app | pasignasigna_lab3 | Package renamed pasignasigna_navigation_app; existing folder/platform IDs retained |
| Nine separate Dart modules | Single authentication file | All nine required files under lib |
| StudentApp, indigo Material 3 theme, LoginScreen entry | LoginRegisterApp, teal AuthPage | StudentApp and required startup flow |
| DemoAuth with admin/admin123 | No default account | Default admin plus one replaceable registered account |
| Username login and validation | Email-based login | Username login, required fields, invalid-credentials SnackBar, pushReplacement |
| Register username/password/confirmation | Name/email and 8-character password | 3-character username, reserved admin, nonblank 6-character password, exact confirmation |
| In-memory replacement registration | Refused a second account | Latest registration replaces previous, admin retained |
| Home, Calculator, Profile, Social Media destinations | Welcome view only | Four NavigationDestination icons and labels |
| setState and IndexedStack preserve page state | No navigation | MainScreen retains inputs, results and scroll state |
| Home welcome and overview | Auth lab branding | Student welcome and descriptions of three other pages |
| CalculatorScreen and _CalculatorScreenState | No calculator file | New calculator matching every listed Lab 4 feature |
| Two inputs, four operations, result, validation, Clear | Missing | Signed decimals, finite-number validation, zero-division and overflow handling |
| Keep calculator Scaffold and AppBar | No existing calculator | Calculator has its own Scaffold and AppBar |
| Student profile | Name and course code only | Jolex Pasignasigna; 557989; BSIT, 3rd Year; CCE106(3450); Jolex129@gmail.com |
| Sample social accounts and SnackBar actions | Missing | Supplied Facebook, Instagram and TikTok handles, web links, Copy link and tap feedback |
| GitHub link | No local Git repository | User supplied saltylex/Room5activity; submission.md records delivery |
| Four page screenshots in Google Docs and PDF | Missing | See screenshots folder and submission.md |
| Preserve existing work | Original login lab | Original source/tests/README archived under docs/archive |

The previous Lab Activity 4 calculator was not present. Its specified features
were implemented from the supplied requirements. No student details were invented.
CCE106(3450), already in the project, is retained as the subject/section code.
Profile introduction, hobbies and school email are adapted from the supplied
student_profile_app repository. No additional runtime packages were introduced.
