# Data Flow

When and why state changes (event-driven sequences). Product rules: spec.md. Structure: architecture.md.

## Core Data and Derived Values

Primary model values:

- dailyAllowanceMinutes (Int)
- bonusMinutesFromGames (Int)
- usageMinutesToday (Int) (cached from DeviceActivity)
- userWantsUnlocked (Bool)
- appSelection (apps only)
- transactions (bounded)
- pendingWager (optional)

Derived value (not persisted):

- remainingMinutes = max(0, (dailyAllowanceMinutes + bonusMinutesFromGames) - floor(usageMinutesToday))

Policy derived values:

- unlockAllowed = remainingMinutes > 0
- isUnlockedEffective = userWantsUnlocked && unlockAllowed

---

## Global Rule: Who Can Touch What

Views and Feature ViewModels may:

- read/write global models (TimeBudgetModel, LockStateModel, UsageModel, TransactionsModel)
- call Domain engines and calculators
- request “refresh usage” through a coordinator on AppModel

Views and Feature ViewModels must not:

- import or call FamilyControls, ManagedSettings, or DeviceActivity frameworks directly

Services may:

- call Apple Screen Time APIs
- return plain Swift values to the rest of the app

---

## Event Sequences

Each sequence lists:

- Trigger
- Steps
- State updates
- Side effects (shields, persistence)

---

## Sequence 1: App Launch and Root Wiring

Trigger:

- App starts (cold launch)

Steps:

- AppModel initializes Services (Authorization, Selection, Shield, Usage, Persistence).
- Persisted state is loaded:
  - dailyAllowanceMinutes
  - bonusMinutesFromGames
  - userWantsUnlocked
  - appSelection
  - transactions
  - pendingWager
- If pendingWager exists, forfeit is applied once:
  - bonusMinutesFromGames += pendingWager.forfeitDeltaMinutes (negative)
  - pendingWager cleared and persisted
- Usage refresh is triggered:
  - fetch usageMinutesToday for appSelection
  - update UsageModel
- remainingMinutes is computed (derived).
- Shield policy is enforced:
  - if isUnlockedEffective then clear shields
  - else apply shields

State updates:

- TimeBudgetModel updated from persistence
- LockStateModel updated from persistence
- UsageModel updated from first refresh
- TransactionsModel loaded
- Pending wager resolved

Side effects:

- Shield may be applied or cleared
- Logs written for launch, pending wager, initial shield decision

---

## Sequence 2: App Foreground Refresh

Trigger:

- App enters foreground (scenePhase becomes active)

Steps:

- Refresh usage via coordinator:
  - fetch usageMinutesToday from DeviceActivityUsageService
  - update UsageModel and lastUsageRefreshDate
- Recompute remainingMinutes (derived).
- Enforce shield policy based on derived state:
  - if isUnlockedEffective then clear shields
  - else apply shields

State updates:

- UsageModel updated
- Derived remainingMinutes changes implicitly through recomputation

Side effects:

- Shields may change if remainingMinutes crossed 0
- Logs written for refresh + shield enforcement

---

## Sequence 3: Manual Pull-to-Refresh on Home

Trigger:

- User pulls down to refresh on Home screen

Steps:

- Show refresh indicator.
- Refresh usage via coordinator (same as foreground refresh).
- Recompute remainingMinutes.
- Enforce shield policy.

State updates:

- UsageModel updated

Side effects:

- Shields may change
- UI updates remainingMinutes immediately after refresh completes
- Logs written

---

## Sequence 4: User Attempts to Unlock with 0 Minutes Remaining

Trigger:

- User taps the Lock/Unlock control while locked
- remainingMinutes == 0

Steps:

- App checks unlockAllowed:
  - unlockAllowed is false
- Do not change userWantsUnlocked.
- Trigger UI feedback:
  - shake animation on control
  - inline message “0 minutes remaining” appears and fades out
- Keep shields applied.

State updates:

- No model changes required

Side effects:

- No Screen Time API calls necessary
- Logs written for blocked unlock attempt

---

## Sequence 5: User Unlocks with Minutes Available

Trigger:

- User taps Lock/Unlock control
- remainingMinutes > 0

Steps:

- Set userWantsUnlocked = true and persist.
- Enforce shield policy:
  - isUnlockedEffective becomes true
  - ShieldService.clearShields() is called
- Immediately refresh usage (optional but recommended):
  - fetch usageMinutesToday
  - update UsageModel
- Recompute remainingMinutes.
- If remainingMinutes is now 0 (edge case due to stale usage), enforce shields again:
  - apply shields
  - userWantsUnlocked can remain true, but isUnlockedEffective will be false

State updates:

- LockStateModel updated
- UsageModel updated (if refresh occurs)

Side effects:

- Shields cleared, then possibly re-applied if remaining becomes 0
- Logs written

---

## Sequence 6: User Locks Manually

Trigger:

- User taps Lock/Unlock control while unlocked

Steps:

- Set userWantsUnlocked = false and persist.
- Enforce shield policy:
  - ShieldService.applyShields(selection) is called

State updates:

- LockStateModel updated

Side effects:

- Shields applied
- Logs written

---

## Sequence 7: remainingMinutes Reaches 0 While Unlocked

Trigger:

- After a usage refresh, remainingMinutes becomes 0
- userWantsUnlocked may still be true

Steps:

- unlockAllowed becomes false (derived).
- isUnlockedEffective becomes false (derived).
- Enforce shield policy:
  - ShieldService.applyShields(selection)
- UI updates:
  - remainingMinutes displays 0
  - Lock control appears greyed out

State updates:

- UsageModel updated (from refresh)
- Derived values change

Side effects:

- Shields applied as soon as detected (best-effort immediate)
- Logs written for zero-crossing and shield apply

---

## Sequence 8: Game Preview Updates as User Changes Inputs

Trigger:

- User changes wager or game options in a game screen

Steps:

- GameViewModel updates local inputs.
- WagerPreviewCalculator computes a preview:
  - expected deltaMinutes for win/loss paths (floor rounding)
  - display strings like “+X min” / “−Y min”
- No global state is mutated during preview.

State updates:

- Local ViewModel state only

Side effects:

- None

---

## Sequence 9: Game Commit and Resolution

Trigger:

- User taps the game’s Commit/Play button

Steps:

- Validate wagerMinutes <= remainingMinutes (or other game-specific rules).
- Persist PendingWager immediately:
  - includes wagerMinutes, gameType, timestamp, forfeitDeltaMinutes (usually -wagerMinutes)
- Run the game engine to resolve:
  - engine returns multiplier and deltaMinutes
  - deltaMinutes uses floor rounding
- Apply outcome:
  - bonusMinutesFromGames += deltaMinutes
  - append GameTransaction with resulting values
- Clear PendingWager and persist.
- Recompute remainingMinutes (derived) and update UI.
- Enforce shield policy:
  - if remainingMinutes == 0 then apply shields
  - else maintain current lock state (no auto-unlock)

State updates:

- TimeBudgetModel updated (bonusMinutesFromGames)
- TransactionsModel appended
- PendingWager cleared

Side effects:

- Persistence writes
- Possible shield change if remaining hits 0
- Logs written

---

## Sequence 10: Game Win While Locked

Trigger:

- User is locked
- Game resolves with deltaMinutes > 0

Steps:

- bonusMinutesFromGames += deltaMinutes
- remainingMinutes increases (derived)
- unlockAllowed becomes true (derived)
- App remains locked because userWantsUnlocked is still false.
- UI updates:
  - remainingMinutes shows new value
  - lock control becomes visually enabled again

State updates:

- TimeBudgetModel updated (bonusMinutesFromGames)

Side effects:

- No automatic shield clearing
- Logs written

---

## Sequence 11: Selection Change (Apps Only)

Trigger:

- User changes selected restricted apps via FamilyControls picker

Steps:

- Persist new appSelection.
- Refresh usage for the new selection.
- Recompute remainingMinutes.
- Enforce shield policy:
  - if isUnlockedEffective then clear shields for new selection
  - else apply shields for new selection

State updates:

- appSelection updated and persisted
- UsageModel updated

Side effects:

- Shields updated to match new selection
- Logs written

---

## Sequence 12: Day Reset

Trigger:

- New day detected (via DeviceActivity boundary or app launch/foreground check)

Steps:

- Reset per-day values:
  - usageMinutesToday is refreshed for the new day (expected 0)
  - bonusMinutesFromGames reset to 0 (unless product rules later change)
- Recompute remainingMinutes = dailyAllowanceMinutes.
- Enforce shield policy based on userWantsUnlocked:
  - if userWantsUnlocked true then unlockAllowed true and shields can clear
  - otherwise remain locked

State updates:

- bonusMinutesFromGames reset and persisted
- UsageModel refreshed and persisted (cache)

Side effects:

- Shields may clear or remain depending on intent state
- Logs written
