# Goal + Tech Stack + Core Logic

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

## State & Concurrency

- **Swift Concurrency (`async/await`)**
  - Used for game timing, animations, and Screen Time state refresh
- **SwiftUI state system**
  - `@State`, `@Observable`, `@Environment`
  - Simple MVVM-style separation (no heavy architecture frameworks)

## Screen Time & Blocking

- **FamilyControls**
  - Request authorization and allow users to select apps/categories to manage
- **ManagedSettings**
  - Apply and remove app/category shields when bankroll reaches 0 minutes
- **DeviceActivity**
  - Handle daily reset boundaries and usage monitoring
  - Source of truth for day transitions (not for real-time countdown UI)

## Data Persistence

- **UserDefaults + Codable** (default choice)
  - Store:
    - remaining minutes
    - daily allowance
    - game history (lightweight)
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

The user’s **total screen time budget** (daily allowance). That budget is spent on **unblocking the apps the user has chosen to restrict** (e.g. social media). Not per-app limits; one pool for all selected apps.

### Daily allowance

**Fixed user-set amount per day** (e.g. 90 min/day). Not “whatever Screen Time says is left” from a system budget.

### App selection

**Apps only** (FamilyControls picker). No categories.

### Blocking model

When bankroll hits 0 minutes: block **only the selected apps** (not “phone is useless except essentials”).

### Unblocking and pause

- When the user wins minutes back, they may **tap a button in the app** to turn off blocking for their selected apps; then their time starts counting down again.
- **Manual pause:** In-app control (e.g. “Pause timer”) to **pause the bankroll countdown** without unblocking. When paused, stop deducting; when resumed, deduction continues. Blocking on/off is separate (Managed Settings).

### Usage and time left

- **Source of truth:** Real usage measured by **DeviceActivity** (not an in-app countdown).
- **UI:** Show **how much time the user has left** (remaining budget). No live countdown timer in the app.

### Edge case—mid-session

If the user is in a blocked app and bankroll hits 0: **kick them out instantly**.

### Rounding

**Floor only.** All minute deltas round down. No minimum +1 min rule.

### Wager UI

**Show win/loss in real time** as the user changes wager variables (bet, multiplier, options). Display potential “+X min” / “−Y min” before they commit.

### Mid-game kill

If the app is killed or restarted **mid-game**: current wager is **forfeit**.

### Anti-tilt, clock tampering, compliance

- **Anti-tilt:** No max wager per play, no max plays per day.
- **Clock tampering:** Out of scope.
- **Compliance:** Might ship for real—use clear wording and guardrails (e.g. “you are wagering screen time,” no misleading odds, age/region as needed).

## Helpful Documentation

Use ~/docs/llms folder for formatted documentation regarding SwiftUI. See the links below for specific information regarding family controls, managed settings device activity, and animating views.

### UI Docs

[SwiftUI](https://developer.apple.com/documentation/SwiftUI)

### Screentime API Docs

[Family Controls](https://developer.apple.com/documentation/FamilyControls)
[Manged Settings](https://developer.apple.com/documentation/ManagedSettings)
[Device Activity](https://developer.apple.com/documentation/DeviceActivity)

### Animation Docs

[Animation](https://developer.apple.com/documentation/quartzcore)
[Animation Details](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreAnimation_guide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40004514)
