# DoubleTime TODO

## Map of /docs

- `docs/spec.md` - Product rules and user-visible behavior (single `remainingMinutes`, lock UX, wagering rules).
- `docs/architecture.md` - Layer boundaries, state ownership, service responsibilities, and file layout.
- `docs/data_flow.md` - Event-driven sequences for launch, refresh, lock/unlock, game resolve, and day reset.
- `docs/llms/markdown-styling.md` - Markdown syntax constraints for all docs updates.
- `docs/games/crash.md` - Crash game spec placeholder (needs concrete rules).
- `docs/games/plinko.md` - Plinko game spec placeholder (needs concrete rules).
- `docs/games/mines.md` - Mines game spec placeholder (needs concrete rules).
- `docs/games/slots.md` - Slots game spec placeholder (needs concrete rules).
- `docs/styling.md` - UI styling placeholder (needs concrete design tokens and rules).

## Phase 1 - Planning Baseline

- [ ] **Lock game-specific rule docs before coding game engines**
  - **Objective:** Fill `docs/games/*.md` with final per-game inputs, outcomes, and floor-rounding behavior so implementation does not invent mechanics.
  - **Inputs:** `docs/spec.md` (Core Logic), `docs/data_flow.md` (Sequences 8-10), `docs/games/*.md`.
  - **Acceptance criteria:** Each game doc defines wager inputs, resolve output (`deltaMinutes`), and at least one worked example using whole-minute floor rounding.
  - **Touch points:** `docs/games/crash.md`, `docs/games/plinko.md`, `docs/games/mines.md`, `docs/games/slots.md`.

- [ ] **Lock visual system baseline for implementation**
  - **Objective:** Define minimal reusable UI styling rules (type scale, spacing, colors, states) for Home + game screens.
  - **Inputs:** `docs/spec.md` (UX and controls), `docs/styling.md`, `ui-similar/ui-similar.md`.
  - **Acceptance criteria:** `docs/styling.md` includes tokens/rules for primary metric card, lock toggle states, inline status message, and game wager preview text states.
  - **Touch points:** `docs/styling.md`, `ui-similar/ui-similar.md`.

## Phase 2 - Core Domain and State

- [ ] **Implement core time-budget models and derived calculator**
  - **Objective:** Implement data models and one canonical calculator for `remainingMinutes` using the agreed formula and floor/clamp behavior.
  - **Inputs:** `docs/spec.md` (Remaining time model), `docs/architecture.md` (Remaining Minutes Calculation), `docs/data_flow.md` (Core Data and Derived Values).
  - **Acceptance criteria:** Calculator returns `max(0, (dailyAllowanceMinutes + bonusMinutesFromGames) - floor(usageMinutesToday))`; no in-app countdown code exists.
  - **Touch points:** `Core/Domain/Models/TimeBudget.swift`, `Core/Domain/Calculators/RemainingMinutesCalculator.swift`, `Core/Domain/Utilities/MinutesRounding.swift`.

- [ ] **Implement global observable state models**
  - **Objective:** Add `@Observable` global models with clear ownership for budget, usage, lock intent, and transactions.
  - **Inputs:** `docs/architecture.md` (State Management), `docs/data_flow.md` (Core Data and Derived Values).
  - **Acceptance criteria:** `TimeBudgetModel`, `UsageModel`, `LockStateModel`, and `TransactionsModel` compile; `remainingMinutes` is derived, not stored.
  - **Touch points:** `Core/State/TimeBudgetModel.swift`, `Core/State/UsageModel.swift`, `Core/State/LockStateModel.swift`, `Core/State/TransactionsModel.swift`.

- [ ] **Implement persistence schema and load/save paths**
  - **Objective:** Persist only agreed state (`dailyAllowanceMinutes`, `bonusMinutesFromGames`, `userWantsUnlocked`, app selection, transactions, pending wager).
  - **Inputs:** `docs/architecture.md` (Persistence), `docs/data_flow.md` (Sequences 1, 9, 12), `docs/spec.md` (Data Persistence).
  - **Acceptance criteria:** App relaunch restores persisted values; `remainingMinutes` is recomputed on launch; pending wager forfeit is applied once.
  - **Touch points:** `Core/Services/Persistence/KeyValueStore.swift`, `Core/Services/Persistence/UserDefaultsStore.swift`, `Core/Services/Persistence/CodableStore.swift`, `Core/State/AppModel.swift`.

## Phase 3 - Screen Time Integration

- [ ] **Implement Screen Time service adapters (apps-only)**
  - **Objective:** Implement authorization, selection, shielding, and usage adapters behind service boundaries.
  - **Inputs:** `docs/architecture.md` (Screen Time Integration), `docs/spec.md` (App selection, Locking policy).
  - **Acceptance criteria:** Services compile and expose plain Swift values; only Services import Screen Time frameworks; selection is apps-only.
  - **Touch points:** `Core/Services/ScreenTime/ScreenTimeAuthorizationService.swift`, `Core/Services/ScreenTime/AppSelectionService.swift`, `Core/Services/ScreenTime/ShieldService.swift`, `Core/Services/ScreenTime/DeviceActivityUsageService.swift`.

- [ ] **Implement lock policy coordinator and enforcement**
  - **Objective:** Centralize `unlockAllowed` / `isUnlockedEffective` evaluation and shield enforcement in one coordinator path.
  - **Inputs:** `docs/architecture.md` (Lock / Unlock Policy and UX), `docs/data_flow.md` (Sequences 4-7).
  - **Acceptance criteria:** Unlock requires `remainingMinutes > 0`; zero state keeps locked; shielding flips correctly on derived policy changes.
  - **Touch points:** `Core/State/AppModel.swift`, `Core/State/LockStateModel.swift`, `Core/Services/ScreenTime/ShieldService.swift`.

- [ ] **Implement usage refresh pipeline**
  - **Objective:** Add `refreshUsageAndRecomputeRemaining()` and wire triggers (launch, foreground, pull-to-refresh, lock/unlock attempts, post-game recompute).
  - **Inputs:** `docs/architecture.md` (Remaining Minutes Refresh Strategy), `docs/data_flow.md` (Sequences 1-3, 5, 7, 9).
  - **Acceptance criteria:** Usage refresh updates `usageMinutesToday` and recomputes remaining; no periodic countdown timer is introduced.
  - **Touch points:** `Core/State/AppModel.swift`, `Core/State/UsageModel.swift`, `Features/Home/HomeViewModel.swift`.

## Phase 4 - Home UX and Controls

- [ ] **Build Home remaining-minutes surface**
  - **Objective:** Ship Home UI that emphasizes a single primary value (`remainingMinutes`) with optional secondary breakdown.
  - **Inputs:** `docs/spec.md` (Remaining time model, UX and controls), `docs/styling.md`.
  - **Acceptance criteria:** Home shows one prominent remaining-minutes number; breakdowns are present but visually secondary.
  - **Touch points:** `Features/Home/HomeView.swift`, `Features/Home/Components/RemainingMinutesCard.swift`.

- [ ] **Build single Lock/Unlock control with zero-minute feedback**
  - **Objective:** Implement one lock toggle control with disabled/grey state, shake, and inline “0 minutes remaining” fade message when unlock is disallowed.
  - **Inputs:** `docs/spec.md` (UX and controls), `docs/data_flow.md` (Sequence 4).
  - **Acceptance criteria:** At `remainingMinutes == 0`, tap does not change state; shake + inline message appear; shields remain applied.
  - **Touch points:** `Features/Home/Components/LockToggleButton.swift`, `Features/Home/Components/InlineStatusMessage.swift`, `Features/Home/HomeViewModel.swift`.

## Phase 5 - Game Loop Implementation

- [ ] **Implement shared game transaction + pending wager flow**
  - **Objective:** Standardize play lifecycle: validate wager, persist pending wager, resolve, apply `bonusMinutesFromGames`, append transaction, clear pending.
  - **Inputs:** `docs/architecture.md` (Game Architecture, Mid-Game Kill Forfeit), `docs/data_flow.md` (Sequence 9).
  - **Acceptance criteria:** Mid-game kill applies forfeit on next launch exactly once; successful resolve clears pending wager and persists transaction.
  - **Touch points:** `Core/Domain/Models/GameTransaction.swift`, `Core/State/TransactionsModel.swift`, `Core/State/AppModel.swift`, `Features/Games/*/*ViewModel.swift`.

- [ ] **Implement Crash feature end-to-end**
  - **Objective:** Implement Crash engine + view model + UI using finalized Crash doc rules and shared transaction flow.
  - **Inputs:** `docs/games/crash.md`, `docs/spec.md` (Wager UI), `docs/data_flow.md` (Sequences 8-10).
  - **Acceptance criteria:** Wager preview updates in real time; resolve applies floor-rounded delta to `bonusMinutesFromGames`; no auto-unlock after win.
  - **Touch points:** `Core/Domain/Engines/CrashEngine.swift`, `Features/Games/Crash/CrashViewModel.swift`, `Features/Games/Crash/CrashView.swift`.

- [ ] **Implement Plinko feature end-to-end**
  - **Objective:** Implement Plinko engine + view model + UI using finalized Plinko doc rules and shared transaction flow.
  - **Inputs:** `docs/games/plinko.md`, `docs/spec.md`, `docs/data_flow.md` (Sequences 8-10).
  - **Acceptance criteria:** Same behavioral contract as Crash (preview, commit, floor rounding, lock policy consistency).
  - **Touch points:** `Core/Domain/Engines/PlinkoEngine.swift`, `Features/Games/Plinko/PlinkoViewModel.swift`, `Features/Games/Plinko/PlinkoView.swift`.

- [ ] **Implement Mines feature end-to-end**
  - **Objective:** Implement Mines engine + view model + UI using finalized Mines doc rules and shared transaction flow.
  - **Inputs:** `docs/games/mines.md`, `docs/spec.md`, `docs/data_flow.md` (Sequences 8-10).
  - **Acceptance criteria:** Same behavioral contract as Crash (preview, commit, floor rounding, lock policy consistency).
  - **Touch points:** `Core/Domain/Engines/MinesEngine.swift`, `Features/Games/Mines/MinesViewModel.swift`, `Features/Games/Mines/MinesView.swift`.

- [ ] **Implement Slots feature end-to-end**
  - **Objective:** Implement Slots engine + view model + UI using finalized Slots doc rules and shared transaction flow.
  - **Inputs:** `docs/games/slots.md`, `docs/spec.md`, `docs/data_flow.md` (Sequences 8-10).
  - **Acceptance criteria:** Same behavioral contract as Crash (preview, commit, floor rounding, lock policy consistency).
  - **Touch points:** `Core/Domain/Engines/SlotsEngine.swift`, `Features/Games/Slots/SlotsViewModel.swift`, `Features/Games/Slots/SlotsView.swift`.

## Phase 6 - Validation and Hardening

- [ ] **Add focused unit tests for budget math and lock policy**
  - **Objective:** Prove derived-minute math and unlock/shield policy hold for edge cases.
  - **Inputs:** `docs/spec.md` (Remaining time model, Locking policy), `docs/architecture.md` (Remaining Minutes Calculation, Lock policy), `docs/data_flow.md` (Sequences 4-7).
  - **Acceptance criteria:** Tests cover floor rounding, clamp to zero, unlock blocked at zero, locked-until-toggle after win, and zero-crossing shield enforcement.
  - **Touch points:** `Core/Domain/Calculators/*Tests.swift`, `Core/State/*Tests.swift`, `Core/Services/ScreenTime/*Tests.swift`.

- [ ] **Add sequence-level integration checks for critical flows**
  - **Objective:** Validate high-risk flows map to data_flow sequences without behavioral drift.
  - **Inputs:** `docs/data_flow.md` (Sequences 1, 5, 7, 9, 10, 12).
  - **Acceptance criteria:** Automated checks (or deterministic harness tests) verify launch restore, unlock path, zero-crossing re-lock, game commit/forfeit, and day reset behavior.
  - **Touch points:** `Core/State/AppModelTests.swift`, `Features/Home/HomeViewModelTests.swift`, `Features/Games/*/*ViewModelTests.swift`.

- [ ] **Add structured logging for state-changing events**
  - **Objective:** Ensure key lock/budget transitions are diagnosable in development builds.
  - **Inputs:** `docs/architecture.md` (Logging), `docs/data_flow.md` (all sequences).
  - **Acceptance criteria:** Logs emitted for lock toggle attempts, shield apply/clear, usage refresh, game resolve, pending wager forfeit, and day reset.
  - **Touch points:** `Core/Services/Logging/Log.swift`, `Core/State/AppModel.swift`, `Features/Home/HomeViewModel.swift`, `Features/Games/*/*ViewModel.swift`.

## Definition of Done

- `remainingMinutes` is the only primary user-visible budget number, computed from allowance + bonus ledger - floored usage.
- `bonusMinutesFromGames` is stored separately and updated only by game outcomes/forfeit handling.
- Lock/Unlock behavior matches spec exactly, including zero-minute disabled feedback and no auto-unlock after wins.
- DeviceActivity is the usage source of truth; no countdown timer logic exists.
- All four games run through one consistent wager lifecycle and pass core math/policy tests.
- `spec.md`, `architecture.md`, `data_flow.md`, and this `TODO.md` remain aligned with no conflicting terminology.