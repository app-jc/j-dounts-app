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
3. [Demo accounts and fake OTP](#demo-accounts-and-fake-otp)
4. [Build the deliverables](#build-the-deliverables)
5. [Tests](#tests)
6. [Architecture](#architecture)
7. [Folder map](#folder-map)
8. [State management](#state-management)
9. [Offline strategy](#offline-strategy)
10. [Auth flow and test matrix](#auth-flow-and-test-matrix)
11. [Rewards model](#rewards-model)
12. [Animations](#animations)
13. [Key decisions](#key-decisions)
14. [Assets, fonts and licences](#assets-fonts-and-licences)
15. [AI tool usage](#ai-tool-usage)
16. [Known gaps](#known-gaps)
17. [Time spent](#time-spent)
18. [Recording](#recording)

## Requirements

| Tool                                | Version |
| ----------------------------------- | ------- |
| Flutter (stable)                    | 3.47.7  |
| Dart                                | 3.13.5  |
| Xcode and CocoaPods (iOS Simulator) | TODO    |
| Android SDK and an emulator         | TODO    |

No API keys, `.env` files or server are needed.

## Run it

From a fresh clone:

```bash
git clone https://github.com/app-jc/j-dounts-app.git
cd j-dounts-app
flutter pub get
# TODO: keep ONE of the next two lines after checking a clean clone
dart run build_runner build --delete-conflicting-outputs   # if generated Drift files are not committed
# (generated files are committed; no code generation step needed)
flutter run -d [device-id]
```

- Localisation (`gen-l10n`): TODO state whether it runs on `flutter pub get` or needs `flutter gen-l10n`.
- First launch seeds the local database from bundled JSON. No network is needed at any point.
- To test offline behaviour, turn on airplane mode after the first launch.

## Demo accounts and fake OTP

| Item                     | Value                                                 |
| ------------------------ | ----------------------------------------------------- |
| Fake OTP (every account) | `123456`                                              |
| Seeded member phone      | `09 123 45678` (normalised to `+95912345678`)         |
| Seeded member            | Charlotte Bennett, 680,000 points, Silver tier        |
| New registrations        | Any valid number, start at 0 points, no welcome bonus |

The OTP value lives only in `FakeAuthRepository`. Swapping in a real API means implementing `AuthRepository`, with no UI change.

## Build the deliverables

```bash
flutter build apk --release
# output: build/app/outputs/flutter-apk/app-release.apk

flutter build ios --simulator
# zip build/ios/iphonesimulator/Runner.app for the simulator build
```

TODO: add links to the uploaded builds.

## Tests

```bash
flutter analyze
flutter test                          # unit and widget tests
flutter test integration_test         # Register > Home > Product detail; TODO: device needed
```

What is covered (TODO: delete any line that is not true when you submit):

- **Unit:** phone, OTP, name and date-of-birth validators; tier calculator boundaries; in-tier fraction and top-tier state; discount resolver; MMK formatter; challenge completion; fake auth repository; session restore; router guard.
- **Data (in-memory Drift):** seed runs once; a malformed seed rolls back; `watch()` streams re-emit after writes; a failed refresh keeps cached data; data still loads while the connectivity fake reports offline.
- **State:** `AuthFlowCubit` lock, resend deadline, and kept values; `HomeBloc` per-section states.
- **Widget:** login and registration validation, double tap sends one request.
- **Integration:** Register, Home, Product detail.

Tests use a fake clock, a fake secure store and an in-memory database. None use real time or the network.

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

## Folder map

TODO: replace this with the real tree (`tree lib -L 3`) and check each line.

```
lib/
  core/            shared, no feature logic: theme tokens, motion constants,
                   Result/Failure, DI (GetIt), router, clock, l10n helpers
  features/
    auth/          presentation (screens, AuthFlowCubit) | domain (validators,
                   AuthRepository) | data (FakeAuthRepository, session store)
    home/          presentation (HomeBloc, sections) | domain | data (DAOs,
                   repository, refresh)
    product/       presentation (detail, quantity) | domain | data
    rewards/       presentation (ring, ladder, challenge cards) | domain (tier
                   calculator) | data
  data/            shared database: Drift tables, seed loader, bundled JSON
assets/            images, fonts, seed JSON (listed in ASSETS.md)
test/              mirrors lib/
integration_test/  end-to-end flow
```

Rule of thumb: `domain` imports nothing from `data` or `presentation`; `presentation` never imports `data`.

## State management

- **Cubits** for every screen, and **one Bloc** (`HomeBloc`) because Home combines several streams, pull-to-refresh and connectivity events.
- **GetIt** for dependency injection.
- **Why Cubits:** most screens are simple state machines; a Cubit gives testable state without event boilerplate. Home is the exception.
- **go_router** with a synchronous redirect guard that reads a cached `SessionNotifier`, so there is no async flash of the wrong screen.
- `rxdart` is used only in the Home repository, and only if one Drift query cannot compose the stream. TODO: state whether it was needed.

## Offline strategy

- **Drift (SQLite) is the single source of truth.** On first launch the database is seeded once, in one transaction, from bundled JSON. A second launch does not reseed.
- **The UI reads `watch()` streams only.** Home, Product detail and Rewards all read the same local data, including one `members` row for every screen.
- **Images:** seed images are bundled assets, so a first launch without network still renders them. Remote images use `cached_network_image` with a placeholder and an error state.
- **Connectivity:** `connectivity_plus` plus a DNS lookup (the interface can report Wi-Fi with no internet). It drives only the offline banner and the background refresh trigger. Reads are never gated by connectivity.
- **Refresh:** pull-to-refresh and a refresh when the network returns go through a remote-source interface, then write to Drift, and the streams re-emit.
- **What is real and what is simulated:** database, seed, session storage, connectivity detection, the offline banner and image caching are real. Authentication and the remote source are fake (TODO: describe the remote source if you built one, or say there is none).

## Auth flow and test matrix

Register: Phone, OTP, Name, Date of birth, Welcome, Home.
Log in: Phone, OTP, Home.

- The session starts on OTP success (log in) or at "Let's explore" (register).
- Welcome and Home cannot be popped back into the auth flow.
- Back returns to the previous step and keeps what was entered. TODO: add the exact behaviour per screen once confirmed (is the OTP step revisited from Name, and are digits kept?).
- Google, Apple, Facebook, Terms of Use and Privacy Policy open a placeholder sheet.
- Settings has a Log out row.

| Case                | Steps                                                                                          | Expected                                                                                                                            |
| ------------------- | ---------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| Seeded member       | Log in, `09 123 45678`, OTP `123456`                                                           | Home as Charlotte Bennett, Silver tier, 500 points to Gold. Rewards ring sweeps to 680,000.                                         |
| New member          | Let's get started, any valid number, OTP `123456`, name, date of birth, Welcome, Let's explore | Home with 0 points. TODO: describe the Rewards state for 0 points.                                                                  |
| Unregistered number | Log in with a valid number that never registered                                               | Inline message with a link to register, shown before the OTP step.                                                                  |
| Already registered  | Register with `09 123 45678`                                                                   | TODO: confirm and describe the inline message.                                                                                      |
| Wrong OTP           | Enter anything except `123456`                                                                 | Boxes shake and clear, message below. Three wrong codes lock entry until Resend.                                                    |
| Resend              | Wait for the 5:00 countdown                                                                    | Resend activates at 0:00 and restarts the timer.                                                                                    |
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

## Animations

All durations and curves are named constants in one motion file. Reduce Motion (`MediaQuery.disableAnimations`) shortens or skips them.

TODO: keep only the rows that are built.

| Screen             | Effect                                                                                                                                                                                                                                                                           |
| ------------------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Onboarding         | Donut circles drift in; title and buttons enter staggered                                                                                                                                                                                                                        |
| Registration steps | Shared-axis or slide transition; the progress ring animates 25, 50, 75, 100% and then morphs into a check                                                                                                                                                                        |
| Inputs             | Animated focus and error states; OTP boxes shake on a wrong code                                                                                                                                                                                                                 |
| Buttons            | Scale on press; Continue morphs into a loading state                                                                                                                                                                                                                             |
| Welcome            | Donut tiles slide in staggered, then the title fades up                                                                                                                                                                                                                          |
| Home               | Skeleton shimmer; sections enter staggered; banner carousel auto-plays                                                                                                                                                                                                           |
| Product            | Hero transition on the image; quantity number animates on change                                                                                                                                                                                                                 |
| Rewards            | Ring sweeps while the total counts up; tier ladder appears in order and the line fills; tab indicator moves and the cards transition; challenge cards enter staggered; donut fills by quarters and the coffee arc fills to 9/12; Earn attention cue when complete; badge pops in |
| Bottom nav         | The active pill slides between tabs                                                                                                                                                                                                                                              |

Performance: TODO state how you checked 60 fps in profile mode, and on which device.

## Key decisions

| Decision                                                                       | Why                                                                                |
| ------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------- |
| Drift as the single source of truth                                            | The UI never depends on the network; the same data feeds Home and Rewards.         |
| One `members` table for user and member                                        | One record per person, so every screen agrees.                                     |
| `Result<T>` with sealed `Failure`, no message strings                          | Typed failures; widgets decide the text, so the domain stays pure and localisable. |
| Synchronous router guard on a cached session                                   | No async redirect, no flash of the wrong screen.                                   |
| Registration steps are pushed routes                                           | Back works per step and keeps entered values.                                      |
| `StatefulShellRoute` with 5 tabs; `/product/:id` outside the shell             | Tabs keep their state; the product page covers the nav bar.                        |
| Connectivity only for the banner and refresh                                   | Offline data never depends on it.                                                  |
| Date of birth as three stacked fields (month as a word, wheel picker)          | Matches the design; the validator is the authority, not the picker.                |
| No external state-management or mock-server dependencies beyond the list above | Smaller surface to review.                                                         |

## Assets, fonts and licences

- **Fonts:** Nunito (Regular, Bold) and Noto Sans Myanmar, bundled. TODO: add licence names (both are SIL Open Font Licence, verify).
- **Images:** original flat pastel illustrations generated for this project, bundled as assets and listed in `ASSETS.md`. No client images are included.
- **Icons:** TODO.
- Burmese locale: TODO (bonus, state whether it is included).

## AI tool usage

AI coding tools were used, as the brief allows. A VS Code Copilot agent wrote code slice by slice from a written plan. I reviewed each plan and result, ran format, analyze and tests, and committed the changes myself. I can explain every line. TODO: add one sentence on anything you changed by hand.

## Known gaps

TODO: be specific. Candidates to confirm or delete:

- No back end; authentication is fake.
- Bottom-nav tabs 3 and 4 open a placeholder.
- The cart is not persistent (bonus in the brief).
- TODO: anything not tested on a real device, or any animation not built.

## Time spent

TODO: total hours, and a short split (setup, auth, home and data, rewards, tests, polish).

## Recording

TODO: link to the 2 to 4 minute recording (register, log out, log in, Home, Product detail, Rewards, then the same in airplane mode).
