# J'Donuts App for Coding Test

> **Code test submission.** This project was built as a technical assessment.
> It is not a personal project, a commercial product or
> a clone of any app. It exists only to demonstrate my approach to Flutter
> architecture, offline-first data and motion.
>
> The J'Donuts name, brand and designs belong to the client. I built the screens from the designs supplied in the brief.
> The design images are not included in this repository, and all illustrations
> in the app are original images made for this test (see `ASSETS.md`).
> Please do not reuse or redistribute this code or app without
> original brand owner's permission.

## Contents

1. [Requirements](#requirements)
2. [Run it](#run-it)
3. [Features](#features)
4. [Demo accounts and fake OTP](#demo-accounts-and-fake-otp)
5. [Build the deliverables](#build-the-deliverables)
6. [Tests](#tests)
7. [Architecture](#architecture)
8. [Folder map](#folder-map)
9. [State management](#state-management)
10. [Offline strategy](#offline-strategy)
11. [Device verification](#device-verification)
12. [Auth flow and test matrix](#auth-flow-and-test-matrix)
13. [Rewards model](#rewards-model)
14. [Animations](#animations)
15. [Key decisions](#key-decisions)
16. [Assets, fonts and licences](#assets-fonts-and-licences)
17. [AI tool usage](#ai-tool-usage)
18. [Known gaps](#known-gaps)
19. [Time spent](#time-spent)
20. [Recording](#recording)

## Requirements

| Tool              | Version |
| ----------------- | ------- |
| Flutter (stable)  | 3.47.7  |
| Dart              | 3.13.5  |
| Xcode             | 27.0.1 (local build environment) |
| Android emulator  | Android 17 / API 37 (local build environment) |

No API keys, `.env` files or server are needed.

## Run it

From a fresh clone:

```bash
git clone https://github.com/app-jc/j-dounts-app.git
cd j-dounts-app
flutter pub get
flutter gen-l10n
flutter run -d [device-id]
```

- Generated Drift and localization source files are committed. If you change a Drift table, regenerate its code with `dart run build_runner build --delete-conflicting-outputs`.
- First launch seeds the local database from bundled JSON. Product, Home, and Rewards content and images are local; no API server is required. Connectivity status uses a DNS reachability check.
- To test offline behaviour, turn on airplane mode after the first launch.

## Features

| Feature | Included | Status / remarks |
|---|---|---|
| Onboarding and account access | Registration and login entry points; social/legal placeholder actions | Social providers and legal links show placeholder feedback; no external sign-in or web pages. |
| Registration and login | Phone validation, fake OTP, name/DOB validation, existing/new-user routing, session restore and logout | Fake authentication only; OTP is `123456`. Auth UI and validation tests exist; complete device-flow verification is still needed. |
| Home | Member header, banners, Seasonal/Popular/Order Again products, nearby shop cards, five-tab navigation | Home content is seeded locally. Menu and Wallet tabs are placeholders. Pull-to-refresh currently does nothing; no remote/background refresh exists. |
| Product detail | Product code, description, MMK price, New badge, Hero image, quantity stepper and live total | Add-to-cart feedback only; cart is not persisted. |
| Rewards | Tier ladder, points ring/count-up, challenges and progress artwork, Earn visual state, Gifts tab and completion badge | Reads the same local member/challenge data as Home. Rewards presentation/widget tests are present; full-suite completion and device review remain outstanding. |
| Offline data | Drift database seeded from bundled JSON; bundled images; offline banner and HTTPS image-cache support | Local screens do not require server data. Offline/online transitions have not been verified on devices; see [Device verification](#device-verification). |
| Burmese localization | English and Burmese ARB resources and generated localization code | Verify all visible strings/translations before final submission. |
| Motion and accessibility support | Registration transitions, input/button feedback, shimmer, carousel, Product Hero/quantity, navigation pill, Rewards animations; Reduce Motion helper | Some required animations and full-flow Reduce Motion/performance checks remain incomplete; see [Animations](#animations) and [Known gaps](#known-gaps). |
| Backend and integration flow | No backend; unit/widget tests | No remote refresh and no Register → Home → Product integration test. |

## Demo accounts and fake OTP

| Item                     | Value                                                 |
| ------------------------ | ----------------------------------------------------- |
| Fake OTP (every account) | `123456`                                              |
| Seeded member phone      | `09 123 45678` (normalised to `+95912345678`)         |
| Seeded member            | Charlotte Bennett, 680,000 points, Silver tier        |
| New registrations        | Any valid number, start at 0 points, no welcome bonus |

The OTP value lives only in `FakeAuthRepository`. Swapping in a real API means implementing `AuthRepository`, with no UI change.

### Quick flow and animation demo

Use the seeded account to see populated Home, Product, and Rewards data and the Rewards entrance animation:

1. From Onboarding, choose **Log in**.
2. Enter `09 123 45678` and verify with `123456`.
3. On Home, open the Coconut Donut product, then return and select **Reward** in the bottom navigation.
4. The seeded member has 680,000 points (Silver, 500 points to Gold) and challenge progress of 4/4, 1/4, and 9/12. On first entry, Rewards animates the points/tier presentation and challenge cards. One challenge is complete, so the Rewards badge count is 1.

To exercise registration-step transitions, log out from **Settings**, choose **Let's get started**, and register with a valid phone number not already in the local database. Use the fake OTP `123456`, complete Name and Date of birth, then choose **Let's explore**. To see the OTP error feedback, enter one incorrect six-digit code; it should shake/clear before entering the correct code. Registration starts with 0 points, so use the seeded member when demonstrating populated Rewards animations.

## Build the deliverables

```bash
flutter build apk --release
# output: build/app/outputs/flutter-apk/app-release.apk

# Install the exact APK on a connected Android device/emulator:
flutter install -d [android-device-id] \
  --use-application-binary=build/app/outputs/flutter-apk/app-release.apk

flutter build ios --simulator
ditto -c -k --sequesterRsrc --keepParent \
  build/ios/iphonesimulator/Runner.app Runner-ios-simulator.zip
```

The Android release configuration currently uses the **debug signing key**.
That is suitable for the assessment's direct-install APK, but not for a
production/Play Store release. The application ID is still
`com.example.j_dounts_app`.

A local release APK exists, but its installation and runtime behavior have
not been verified. The Android main manifest declares Internet permission for
release builds as well as debug builds. Rebuild after the final code changes,
install that exact APK on an Android device or emulator, and check the flows
and connectivity below. Do not treat a successful build as a successful device
test.

The iOS Simulator `.app`, APK, and recording still need to be verified and
their upload or attachment confirmed. Add the final links to the submission.

## Tests

```bash
flutter analyze
flutter test
```

The test suite includes:

- **Unit:** authentication validators and OTP state machine; tier calculation; discounts and MMK formatting; seed parsing/seeding; repositories; session storage; and supporting utilities.
- **Widget:** authentication screens and controls, Product detail, Rewards, routing, and shared widgets.
- **Integration:** No `integration_test` flow is currently implemented. Register → Home → Product detail still needs an end-to-end test.

Tests use fakes and an in-memory Drift database where applicable. On 2026-11-10, `flutter analyze` passed and 13 targeted Rewards domain and widget tests passed. The latest full `flutter test` run was not confirmed to complete; run it and resolve any failures or hangs before submission.

## Architecture

Three layers, with dependencies pointing inward:

```
presentation  -->  domain  <--  data
(screens, cubits)  (pure Dart)  (Drift, fake auth, image cache)
```

- **Domain** is pure Dart with no Flutter imports: entities, repository interfaces, validators, tier calculator, discount resolver, and use cases only where real logic exists.
- **Data** implements the domain interfaces. The UI reads only from the local database.
- **Presentation** depends on domain only. No service is created inside a widget; everything comes from GetIt.
- **Errors:** repositories return `Result<T>` with a sealed `Failure`. Failures carry no message strings; widgets map them to localised text.
- **Models** are immutable (Dart 3 sealed classes and records, `equatable`).
- **State/navigation:** flutter_bloc (Cubits plus a Home Bloc), GetIt, and go_router with a synchronous session redirect.

## Folder map

```
.
├── android/                 Android application/build configuration
├── ios/                     iOS Runner, Xcode project and platform resources
├── assets/
│   ├── fonts/               Bundled Nunito and Noto Sans Myanmar fonts/licenses
│   ├── images/              Banners, gifts, members, products, shops,
│   │                        placeholders and previews
│   └── seed/                Initial local catalog/member/challenge JSON
├── lib/
│   ├── app/                 App bootstrap UI, dependency injection, routes,
│   │                        navigation shell and theme
│   ├── core/                Shared database/seed, errors, image cache, member,
│   │                        motion, connectivity, time, utilities and widgets
│   ├── features/
│   │   ├── auth/            Authentication and registration flow
│   │   ├── home/            Home stream, sections and shop presentation
│   │   ├── product/         Product detail and quantity/cart feedback
│   │   ├── rewards/         Rewards data, tier progress and presentation
│   │   └── settings/        Settings and logout surface
│   └── l10n/                Generated localization Dart files
├── test/
│   ├── app/                 Router/navigation tests
│   ├── core/                Database, utilities and shared-widget tests
│   ├── features/            Tests grouped by feature and layer
│   └── l10n/                Localization tests
├── tool/                    Repository checks and original-art generator
├── analysis_options.yaml    Dart analyzer/lint configuration
├── l10n.yaml                Flutter localization-generation configuration
├── pubspec.yaml             Dart/Flutter dependencies and asset declarations
├── pubspec.lock             Resolved dependency versions
└── .gitignore               Excludes build output and local private planning
                             files
```

Within each feature, `domain/` holds pure-Dart models, validation and repository contracts; `data/` implements those contracts using Drift or local auth storage; `presentation/` contains screens, widgets and Cubit/Bloc state. `settings/` is presentation-only. Shared database tables and seed loading live in `lib/core/database/`, rather than a separate top-level `data/` folder. There is no `integration_test/` directory yet.

### Quality configuration and helper scripts

- [`analysis_options.yaml`](analysis_options.yaml) extends `flutter_lints`, enables strict casts/inference/raw types, excludes generated/platform files, and enables import, formatting and resource-cleanup lint rules.
- [`tool/check_domain_imports.py`](tool/check_domain_imports.py) rejects Flutter, Drift and Serverpod imports from `domain/` folders under `lib/`. Run with `python3 tool/check_domain_imports.py`.
- [`tool/check_file_lengths.py`](tool/check_file_lengths.py) checks Dart files under `lib/` and `test/` against the 300-line guideline, excluding generated files. Run with `python3 tool/check_file_lengths.py`.
- [`tool/generate_art_previews.swift`](tool/generate_art_previews.swift) generates the original bundled preview artwork under `assets/images/` on macOS; it does not use client reference screenshots.
- `docs/` contains local planning/reference material and is excluded from the public Git repository; client design screenshots must not be committed.

## State management

- **Cubits** for screen state and **HomeBloc** for Home's composed database stream and events.
- **GetIt** for dependency injection.
- **Why Cubits:** most screens are simple state machines; a Cubit gives testable state without event boilerplate. Home is the exception.
- **go_router** with a synchronous redirect guard that reads a cached `SessionNotifier`, so there is no async flash of the wrong screen.
- Home and Rewards streams are composed with a small project utility; `rxdart` is not used.

## Offline strategy

- **Drift (SQLite) is the single source of truth.** On first launch the database is seeded once, in one transaction, from bundled JSON. A second launch does not reseed.
- **The UI reads `watch()` streams only.** Home, Product detail and Rewards read from Drift, and the same member record supplies member data across screens.
- **Connectivity:** `connectivity_plus` plus a DNS lookup detects likely reachability and drives the offline banner. This is a heuristic, not a backend health check.
- **Refresh:** No remote source is implemented. Pull-to-refresh currently dispatches an event whose HomeBloc handler is a no-op, and there is no background refresh when connectivity returns. Local database reads continue to work offline.
- **Images:** Seed records point to bundled assets, so first launch works without image downloads. `AppCachedImage` also supports cached HTTPS images with placeholder/fallback behavior.
- **What is real and simulated:** Drift, local seed data, session storage, connectivity detection, and the fake authentication repository are implemented. There is no backend or remote data source.

## Device verification

These are verification statuses, not claims that a feature fails on a
particular device. A prior iOS Simulator debug build displayed Home, but the
current complete flow and connectivity behavior have not been confirmed.

| Environment | Connectivity and offline flow | Other checks |
| --- | --- | --- |
| Android emulator | Not recorded as passed. Install the final **release APK** and test online, offline, and reconnect. | Registration, seeded login, Home, Product, Rewards, logout, and relaunch not recorded for the final APK. |
| iOS Simulator | A prior debug build displayed Home; offline/online transitions not recorded as passed. The simulator uses the Mac's network, and the connectivity plugin notes that simulator connectivity events may not update reliably. | Final simulator build and full flow not recorded as verified. |
| Physical iPhone | Airplane-mode and reconnect checks not recorded as passed. Turn off Wi-Fi and cellular, and check that Wi-Fi stays off while testing. | Full device flow, layout, and animations not recorded as verified. |

For each available device, start online and log in as the seeded member. Turn
off all network connections, wait for the offline banner, and open Home,
Product, and Rewards; local content should remain available. Reconnect and
check that the banner clears. Record the device, build, and actual results;
DNS reachability is only a heuristic, and pull-to-refresh does not fetch or
refresh data. Also check session restore after relaunch, Reduce Motion, text
scale, and animation performance where time allows.

## Auth flow and test matrix

Register: Phone, OTP, Name, Date of birth, Welcome, Home.
Log in: Phone, OTP, Home.

- The test cases below describe expected behavior; they are not a claim that every case has been manually verified on a device.
- The session starts on OTP success (log in) or at "Let's explore" (register).
- Welcome and Home cannot be popped back into the auth flow.
- Back navigation returns to earlier registration steps; the auth flow retains its draft and OTP session metadata while that flow remains active.
- Google, Apple, Facebook, Terms of Use and Privacy Policy open a placeholder sheet.
- Settings has a Log out row.

| Case                | Steps                                                                                          | Expected                                                                                                                            |
| ------------------- | ---------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| Seeded member       | Log in, `09 123 45678`, OTP `123456`                                                           | Home as Charlotte Bennett, Silver tier, 500 points to Gold. Rewards ring sweeps to 680,000.                                         |
| New member          | Let's get started, any valid number, OTP `123456`, name, date of birth, Welcome, Let's explore | Home with 0 points; Rewards starts at Bronze with no challenge progress and shows 679,000 points remaining to Silver.               |
| Unregistered number | Log in with a valid number that never registered                                               | Inline message with a link to register, shown before the OTP step.                                                                  |
| Already registered  | Register with `09 123 45678`                                                                   | Registration is blocked with an inline message/link to log in.                                                                    |
| Wrong OTP           | Enter anything except `123456`                                                                 | Boxes shake and clear, message below. Three wrong codes lock entry until Resend.                                                    |
| Resend              | Wait for the 5:00 countdown                                                                    | Resend activates at 0:00 and restarts the timer.                                                                                    |
| OTP input           | Type digits, press backspace, paste six digits                                                  | Numeric input; auto-advance/backspace navigation and six-digit paste should work; SMS one-time-code autofill hint is provided.     |
| Phone rules         | `09254135592`, `9254135592`, spaces, dashes                                                    | Normalised to `+959254135592`. Too short, wrong prefix or letters keep Continue disabled with an inline message after focus loss.   |
| Name rules          | Digits, 51 characters, empty first name, Myanmar script                                        | First name required, 1 to 50 characters after trimming, letters and spaces only; Myanmar script is accepted; last name is optional. |
| Date of birth       | 31 April, 29 February in a non-leap year, a future date, age under 13                          | Inline message, Continue disabled. The minimum age is a named constant (13).                                                        |
| Double tap          | Tap Continue twice quickly                                                                     | One request is sent; Continue shows a loading state.                                                                                |
| Session             | Kill and relaunch while logged in, then after Log out                                          | Home, then Onboarding.                                                                                                              |

## Rewards model

- Points are lifetime points, and the tier is derived from them: Bronze from 0, Silver from 679,000, Gold from 680,500, Platinum from 700,000.
- The in-tier fraction is clamped between 0 and 1. The top tier has an explicit state with no next tier.
- Challenge completion and the badge count are derived, never stored. Progress is stored per member, and a missing row means 0.
- The design mock-ups disagree (Home shows Bronze with 1,290 points to Gold; Rewards shows Silver with 500). Both screens read the same member record, so the seeded member shows Silver with 500 points to Gold everywhere.
- Discounts live on the product; a join override wins. They are display-only and do not change the cart total.
- The ring and the donut and coffee progress art are drawn with `CustomPainter`.
- Seeded challenges are 4/4 donuts, 1/4 coffees, and 9/12 treats. The 9/12 seed uses donut artwork; the brief's coffee-at-9/12 example is not matched by this seed.

## Animations

Motion timings are centralized in `core/motion/motion.dart` for most effects. The Reduce Motion helper is used across the app, but full-flow behavior has not been verified. OTP shake still uses a local hard-coded duration.

| Area | Implemented / remaining |
| --- | --- |
| Onboarding | Donuts, title, and actions stagger with slide/fade. The requested drifting motion is not implemented. |
| Registration | Step slide/fade transitions; progress ring animates and morphs to a check. |
| Inputs and buttons | Focus/error states, OTP error shake, and press scale. Loading swaps to a spinner; it does not morph. OTP shake does not honor Reduce Motion. |
| Welcome | Entrance animation is not implemented. |
| Home | Skeleton shimmer and banner auto-play are implemented; section entrance stagger is not. |
| Product | Hero image transition and animated quantity change. |
| Rewards | Ring/count-up, tier ladder, tabs, challenge-card stagger, animated challenge artwork, Earn entrance pulse, and badge pop-in. Earn pulse only occurs during entrance. |
| Navigation | Active bottom-nav pill slides between tabs. |

Profile-mode frame-rate/performance testing has not been recorded.

## Key decisions

| Decision                                                                       | Why                                                                                |
| ------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------- |
| Drift as the single source of truth                                            | The UI never depends on the network; the same data feeds Home and Rewards.         |
| One `members` table for user and member                                        | One record per person, so every screen agrees.                                     |
| `Result<T>` with sealed `Failure`, no message strings                          | Typed failures; widgets decide the text, so the domain stays pure and localisable. |
| Synchronous router guard on a cached session                                   | No async redirect, no flash of the wrong screen.                                   |
| Registration steps are pushed routes                                           | Back works per step and keeps entered values.                                      |
| `StatefulShellRoute` with 5 tabs; `/product/:id` outside the shell             | Tabs keep their state; the product page covers the nav bar.                        |
| Connectivity for the offline banner                                             | Offline data never depends on it; refresh is not implemented.                      |
| Date of birth as three stacked fields (month as a word, wheel picker)          | Matches the design; the validator is the authority, not the picker.                |
| No external state-management or mock-server dependencies beyond the list above | Smaller surface to review.                                                         |

## Assets, fonts and licences

- **Fonts:** Nunito (Regular, Bold) and Noto Sans Myanmar, bundled under SIL Open Font License 1.1; license files are in the font asset folders.
- **Images:** original flat pastel illustrations generated for this project, bundled as assets and listed in `ASSETS.md`. No client images are included.
- **Icons:** Material icons and Font Awesome social icons; social sign-in is a placeholder, not a real provider integration.
- **Burmese locale:** English and Burmese ARB localizations are included ( String Only )

## Recording

Recording will be uploaded soon in an hour.
