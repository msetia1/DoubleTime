# Architecture - Folder Structure, naming conventions, state management

This document defines how the system is structured (layers, state ownership, boundaries) for the Screen Time gambling blocker project. Product behavior: spec.md. Event sequences: data_flow.md. Optimized for Apple-native frameworks, AI-assisted implementation, and modern SwiftUI.

Core invariants:

- All time values are whole minutes only.
- The user sees one number: remainingMinutes.
- remainingMinutes is computed, never manually decremented by an in-app timer.
- Game outcomes modify bonusMinutesFromGames (stored separately), not usage.
- Screen Time usage is measured honestly via DeviceActivity (apps only).

---

## System Overview

The app is organized into four layers:

- App Shell  
  Root composition, dependency wiring, environment injection, and routing.

- Features (UI)  
  SwiftUI Views and lightweight Feature ViewModels.  
  No Feature imports or directly interacts with Screen Time frameworks.

- Domain  
  Pure business logic, models, and game engines.  
  No Apple Screen Time imports.

- Services  
  Platform integrations (FamilyControls, ManagedSettings, DeviceActivity), persistence, feedback, and logging.

Rule: Services are the only layer allowed to import Screen Time frameworks.

---

## Folder Structure

App/
ScreenTimeCasinoApp.swift
AppRootView.swift
AppRouter.swift

Core/
Domain/
Models/
GameType.swift
GameTransaction.swift
AppSelection.swift
TimeBudget.swift
Engines/
GameEngine.swift
CrashEngine.swift
PlinkoEngine.swift
MinesEngine.swift
SlotsEngine.swift
Calculators/
RemainingMinutesCalculator.swift
WagerPreviewCalculator.swift
Utilities/
MinutesRounding.swift
RNG.swift
DateKey.swift

State/
AppModel.swift
TimeBudgetModel.swift
UsageModel.swift
LockStateModel.swift
TransactionsModel.swift

Services/
ScreenTime/
ScreenTimeAuthorizationService.swift
AppSelectionService.swift
ShieldService.swift
DeviceActivityUsageService.swift
Persistence/
KeyValueStore.swift
UserDefaultsStore.swift
CodableStore.swift
Feedback/
HapticsService.swift
AudioService.swift
Logging/
Log.swift

Features/
Onboarding/
OnboardingView.swift
OnboardingViewModel.swift

Home/
HomeView.swift
HomeViewModel.swift
Components/
RemainingMinutesCard.swift
LockToggleButton.swift
InlineStatusMessage.swift

Games/
Crash/
CrashView.swift
CrashViewModel.swift
Plinko/
PlinkoView.swift
PlinkoViewModel.swift
Mines/
MinesView.swift
MinesViewModel.swift
Slots/
SlotsView.swift
SlotsViewModel.swift

Settings/
SettingsView.swift
SettingsViewModel.swift

History/
HistoryView.swift
HistoryViewModel.swift

Resources/
Assets.xcassets
Sounds/

Docs/
spec.md
architecture.md
data_flow.md
llms/
markdown-styling.md
SwiftUI-LLMS.md

ui-similar/
ui-similar.md
screens/
\*.png

---

## Naming Conventions

- Views: SomethingView
- ViewModels: SomethingViewModel
- Observable global state: SomethingModel
- Services: SomethingService
- Domain engines: SomethingEngine
- Calculators: SomethingCalculator
- Value models use nouns.

Minute-based variables must be explicit:

- dailyAllowanceMinutes
- bonusMinutesFromGames
- usageMinutesToday
- remainingMinutes

---

## State Management

State management uses SwiftUI + iOS 17 Observation.

- Global state lives in Core/State as @Observable models.
- Views consume global state via Environment.
- Feature ViewModels are thin orchestration layers.

### Global Models

AppModel

- Root container for global models and services.

TimeBudgetModel

- Stores dailyAllowanceMinutes and bonusMinutesFromGames.
- Does not store remainingMinutes.

UsageModel

- Stores usageMinutesToday (from DeviceActivity).
- Stores lastUsageRefreshDate.

LockStateModel

- Stores userWantsUnlocked.
- Derived values:
  - unlockAllowed = remainingMinutes > 0
  - isUnlockedEffective = userWantsUnlocked && unlockAllowed

TransactionsModel

- Stores a bounded list of GameTransaction records.

---

## Remaining Minutes Calculation

remainingMinutes is derived as:

remainingMinutes = (dailyAllowanceMinutes + bonusMinutesFromGames) - floor(usageMinutesToday)

Rules:

- Clamp to zero.
- Floor rounding only.
- UI displays only remainingMinutes.
- Allowance, bonus, and usage breakdowns are secondary; remainingMinutes is the primary display value.

---

## Screen Time Integration

Authorization

- ScreenTimeAuthorizationService requests and exposes FamilyControls authorization state.

App Selection

- AppSelectionService presents an apps-only picker and persists the selection.

Shielding

- ShieldService applies and clears ManagedSettings shields.
- Shielding is driven by lock policy, not directly by UI.

Usage

- DeviceActivityUsageService fetches usage for selected apps.
- Converts seconds to minutes using floor division.

---

## Lock / Unlock Policy and UX

Single Lock/Unlock control for restricted apps. UX behavior: spec.md Core Logic → UX and controls.

Definitions:

- unlockAllowed = remainingMinutes > 0
- isUnlockedEffective = userWantsUnlocked && unlockAllowed

Policy:

- If isUnlockedEffective is true, shields are cleared.
- Otherwise, shields are applied.

---

## Remaining Minutes Refresh Strategy

remainingMinutes is refreshed via explicit triggers only:

- App foreground / open
- Manual pull-to-refresh on Home
- Lock/Unlock toggle attempts
- After a game resolves (recompute only; no usage fetch)

Implementation uses a single coordinator method:

refreshUsageAndRecomputeRemaining()

Steps:

- Fetch usageMinutesToday from DeviceActivityUsageService
- Recompute remainingMinutes
- Update lastUsageRefreshDate

No periodic background refresh and no countdown timer.

---

## Game Architecture

Each game is a Feature with:

- GameView
- GameViewModel
- GameEngine

Rules:

- Engines resolve outcomes and return deltaMinutes.
- ViewModels apply deltas by updating bonusMinutesFromGames and appending a GameTransaction.
- Feature code does not touch Screen Time services.

### Mid-Game Kill Forfeit

If the app is killed mid-game:

- The wager is forfeited.

Implementation:

- Persist a PendingWager on game start.
- Clear it on successful resolution.
- On app launch, apply a forfeit if a PendingWager exists.

---

## Persistence

UserDefaults + Codable persist:

- dailyAllowanceMinutes
- bonusMinutesFromGames
- userWantsUnlocked
- selected apps
- bounded transaction history
- pending wager state

remainingMinutes is never persisted.

---

## Logging

Use OSLog with categories:

- ScreenTime
- Shield
- Usage
- Budget
- Games

Log all events affecting lock state or remainingMinutes.

---

## AI Implementation Rules

- Do not introduce new dependencies.
- Do not import Screen Time frameworks outside Services.
- Keep derived logic centralized.
- Enforce one-way data flow:
  UI → ViewModel → Domain → Models → UI
- Treat minutes as Int everywhere; always floor when converting.
