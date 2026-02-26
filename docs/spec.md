# Goal + Tech Stack + Core Logic

Product behavior and rules. System structure: architecture.md. Event sequences: data_flow.md.

Screen time blocker where users can gamble their remaining screentime for the day through various games.

Crash, Plinko, Mines, Slots

## Tech Stack

This project is built using **Apple-native technologies first**, optimized for AI-assisted development, strong official documentation, and low implementation friction.

External dependencies are avoided unless they are widely adopted and exceptionally well documented.

## Platform

- **iOS 17+**
  - Ensures access to modern SwiftUI, Swift Concurrency, and stable Screen Time APIs
  - Reduces legacy edge cases

## UI

- **SwiftUI**
  - Primary UI framework
  - Declarative, predictable, and well supported by Apple documentation
  - Preferred over UIKit for all screens and animations
  - Visual, typography, motion, copy, and accessibility standards must follow `Docs/styling.md`
  - Typography must use shared tokens from `Core/Design/Typography.swift` (no ad-hoc fonts)
  - Shared UI styling should be composed from reusable primitives (`CardContainer`, `RemainingMinutesHero`, `InlineStatusMessage`, `WagerChips`, `BrandedActionButtonStyle`) rather than recreated per screen

## State & Concurrency

- **Swift Concurrency (`async/await`)**
  - Used for game timing, animations, and Screen Time state refresh
- **SwiftUI state system**
  - `@State`, `@Observable`, `@Environment`
  - Simple MVVM-style separation (no heavy architecture frameworks)

## Screen Time & Blocking

- **FamilyControls**
  - Request authorization and allow users to select apps to manage
- **ManagedSettings**
  - Apply and remove app shields for the selected apps when bankroll reaches 0 minutes
- **DeviceActivity**
  - Handle daily reset boundaries and usage monitoring
  - Source of truth for day transitions (not for real-time countdown UI)

## Data Persistence

- **UserDefaults + Codable** (default choice)
  - Store user settings and lightweight history (for example, daily allowance and game history)
  - Internal bookkeeping is persisted only as needed to recompute `remainingMinutes`
  - Chosen for simplicity, reliability, and AI-friendliness
- **SwiftData** (optional, future upgrade)
  - Only introduced if structured queries or analytics become necessary

## Feedback & Polish (Apple-native)

- **Haptics**
  - `UINotificationFeedbackGenerator`
  - `UIImpactFeedbackGenerator`
- **Audio**
  - `AVFoundation` for lightweight win/lose cues
- **Animations**
  - SwiftUI animations, transitions, and `matchedGeometryEffect`

## Optional Enhancements (Strictly Limited)

- **Lottie (iOS)** — optional
  - Only for non-critical UI delight (onboarding, win/loss animations)
  - Must not be required for core gameplay or logic
  - Chosen because of strong documentation and large ecosystem

## Explicit Non-Goals

- No cross-platform frameworks
- No heavy architectural frameworks (e.g. TCA)
- No niche or poorly documented libraries
- No dependencies that complicate AI-generated code or debugging

## Guiding Principle

- If a technology:
  - lacks strong official documentation, or
  - significantly increases cognitive overhead, or
  - makes AI-generated code harder to reason about

**it should not be added.**

## Core Logic

### What is being gambled

The user is wagering their **daily screen time budget** (a single pool of minutes). That pool is used to determine whether the user can unlock usage for the restricted apps they selected (e.g. social media). This is not a per-app limit; it is one shared budget across all selected apps.

### App selection (apps only)

Users select **apps only** via `FamilyControls`. Categories are out of scope.

### Remaining time model (single user-facing value)

The app exposes one primary user-facing value: **`remainingMinutes`**.

- **Definition (computed):**
  - `remainingMinutes = (dailyAllowanceMinutes + bonusMinutesFromGames) - floor(usageMinutesToday)`
- **`dailyAllowanceMinutes`**: fixed per day (user-set).
- **`usageMinutesToday`**: measured by `DeviceActivity` for **only the selected apps**.
- **`bonusMinutesFromGames`**: an internal adjustment ledger (can be positive or negative).
- **Units and rounding:** all values are whole minutes only; **floor rounding only**, and `remainingMinutes` is clamped to a minimum of 0 before being shown to the user.

The UI must display **`remainingMinutes`** as the primary number. Allowance, bonus, and usage breakdowns can be viewable, but they are secondary and not the focus.

### Bonus minutes storage (internal ledger)

`bonusMinutesFromGames` is stored separately for accounting and correctness.

- Bonus minutes are **added/subtracted when games resolve**, regardless of lock state.
- If the user wins minutes while locked, those minutes are added to `bonusMinutesFromGames`, but the restricted apps **remain locked** until the user explicitly unlocks.

### Locking policy (best-effort)

Blocking applies **only to the selected apps**.

- **Locked:** shields are applied via `ManagedSettings`; usage of selected apps is prevented.
- **Unlocked:** shields are removed; usage is permitted as long as policy allows it.

The app does not and cannot pause `DeviceActivity` measurement. Usage is always measured honestly by `DeviceActivity`; there is **no in-app countdown timer**.

When `remainingMinutes` reaches 0 (or below), the app should apply shields **immediately (best-effort)** and attempt to eject the user from a selected app if it is currently in use.

### UX and controls

The app has one primary control: **Restricted Apps (Locked / Unlocked)**.

The control’s visual states, motion behavior, and copy must follow `Docs/styling.md`.

- Only one primary number is shown: **`remainingMinutes`**.
- **Unlock rule:** unlocking is allowed only when `remainingMinutes > 0`.
- **When `remainingMinutes == 0`:**
  - the control appears visually disabled/greyed out,
  - tapping triggers a subtle shake animation,
  - an inline message appears below the control: “0 minutes remaining” (fades in/out),
  - the app remains locked.
- When `remainingMinutes` becomes `> 0` again, the control becomes unlockable, but it **stays locked** until the user toggles it.

### Game resolution and rounding

All game outcomes resolve to whole-minute deltas and apply **floor rounding only**. There is no minimum "+1 minute" house rule.

If the app is killed or restarted **mid-game**, the current wager is **forfeit**.

### Payout cap (minutes-until-midnight)

Game payouts are capped so that `remainingMinutes` never exceeds the minutes remaining until midnight (23:59). This prevents absurd balances from high-multiplier wins.

- **minutesUntilMidnight** = minutes from now until 23:59 today.
- After computing raw deltaMinutes, clamp so that `(currentRemainingMinutes + deltaMinutes) <= minutesUntilMidnight`.
- If the raw delta would exceed this, deltaMinutes is reduced to `minutesUntilMidnight - currentRemainingMinutes`.
- Losses are never capped (deltaMinutes is negative, no clamp needed).
- The capped payout is what the player sees in the result screen.

### Wager UI (real-time feedback)

As the user changes wager variables (bet amount, multiplier, game options), the UI must show the predicted outcome **in real time** (e.g. “+X min” / “−Y min”) before the user commits the wager.

### Anti-tilt, clock tampering, compliance

- **Anti-tilt:** no max wager per play and no max plays per day.
- **Clock tampering:** out of scope.
- **Compliance:** might ship for real—use clear wording and guardrails (e.g. “you are wagering screen time,” avoid misleading odds, consider age/region requirements as needed).

## Helpful Documentation

Use ~/Docs/llms folder for formatted documentation regarding SwiftUI. See the links below for specific information regarding family controls, managed settings device activity, and animating views.

### UI Docs

[SwiftUI](https://developer.apple.com/documentation/SwiftUI)

### Screentime API Docs

[Family Controls](https://developer.apple.com/documentation/FamilyControls)
[Managed Settings](https://developer.apple.com/documentation/ManagedSettings)
[Device Activity](https://developer.apple.com/documentation/DeviceActivity)

### Animation Docs

[Animation](https://developer.apple.com/documentation/quartzcore)
[Animation Details](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreAnimation_guide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40004514)
