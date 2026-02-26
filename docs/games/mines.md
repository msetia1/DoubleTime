# Mines — v1 Rules Contract

Classic Mines on a 5×5 grid. Reveal tiles one by one; each safe reveal increases a fixed multiplier. Hit a mine and lose the wager. Cash out anytime after at least one safe reveal.

---

## Board

- 5×5 grid (25 tiles total)
- Player selects mine count (1–24) before starting; locked once the round begins
- Mines placed randomly at game start via RNG; positions fixed for the round
- Safe tiles = 25 − mineCount

---

## Core Mechanic

- Player reveals tiles one at a time
- Safe tile → gem icon, multiplier increases per fixed table
- Mine tile → bomb icon, reveal entire board (gems + bombs), round ends, wager lost
- Player can Cash Out after at least 1 safe reveal
- Auto-cashout: if all safe tiles are revealed, cash out at max multiplier automatically

---

## Payout Model — Fixed Table

Multipliers are a simple lookup table, not a formula.

Structure:

    multipliers[mineCount][safeReveals] → Double

Rules:

- `safeReveals == 0` → multiplier is 1.0
- Max safe reveals = 25 − mineCount
- Reaching max safe reveals triggers auto-cashout at the table's final value
- Values pre-computed from `0.99 × C(25, d) / C(25 − m, d)` (binomial coefficient with 1% house edge), rounded to 2 decimals
- Stored as a lookup; no runtime formula beyond array access

---

## Delta Calculation

**Cash out after d safe reveals:**

- `cashoutDeltaMinutes = floor(wagerMinutes × (currentMultiplier − 1))`
- This yields minutes won (net), mapping directly to `bonusMinutes` in the ledger

**Mine hit:**

- `deltaMinutes = −wagerMinutes`

After computing delta, the engine clamps the result so remainingMinutes never exceeds minutes until midnight (see `spec.md` — Payout cap).

---

## User Inputs

- **wagerMinutes** (Int, ≥ 1, ≤ remainingMinutes) — chosen via the shared wager modal
- **mineCount** (Int, 1–24) — selected before Start Game, locked once round begins

---

## State Model (MinesViewModel)

### Inputs

- `wagerMinutes` — from `GameSessionModel.currentWagerMinutes`
- `remainingMinutes` — derived, read-only
- `mineCount` — fixed or selectable; locked before start

### Round State

- `phase`: `idle` | `ready` | `playing` | `revealed` | `ended`
- `grid`: `[Tile]` where Tile has:
  - `isMine: Bool`
  - `isRevealed: Bool`
- `safeReveals: Int`
- `multiplierIndex` — safeReveals → lookup
- `currentMultiplier: Double` — from table
- `didHitMine: Bool`

### Derived Values

- `canStart = wagerMinutes > 0 && phase == .ready`
- `canCashOut = safeReveals > 0 && phase == .playing`
- `cashoutDeltaMinutes = floor(wagerMinutes × (currentMultiplier − 1))`

---

## UX Flow

### Wager Modal

- Presented when entering Mines if no wager is set
- Picker shows minutes wheel
- Under the picker, one centered line: **Wager: X min | Y minutes left**
- No "+X" projection before the round starts
- Place Wager → dismiss modal → confirmation: "Wager placed: X min"

### Start Game

- Button visible after wager is placed
- Enabled only when `wagerMinutes > 0`
- On tap: generate board, set `phase = .playing`, clear any previous reveal state

### Tile Reveal

- Tap a tile during `phase == .playing`
- Safe: reveal gem icon, increment `safeReveals`, update multiplier from table, light haptic
- If `safeReveals == maxSafeTiles` → auto-cashout
- Mine: reveal entire board (gems + bombs), warning/error haptic, apply `−wagerMinutes`, end round

### Cash Out

- Available when `canCashOut` is true
- Apply `+cashoutDeltaMinutes`
- Reveal remaining board (optional), end round with success haptic

### In-Round Feedback Line

During play (not in the wager modal), show:

    Multiplier: 1.35x | Cashout: +12 min

Updated live as the player reveals safe tiles.

---

## Icons & Feedback

| Event | Visual | Haptic |
|---|---|---|
| Safe reveal | Gem icon | Light impact |
| Mine hit | Bomb icon | Warning/error (stronger) |
| Cash out | — | Success (stronger) |

---

## Edge Cases

- **1-minute wager, low multiplier:** if multiplied result floors to 0 delta, it's a push. Player needs more reveals to profit.
- **All safe tiles revealed:** auto-cashout at max multiplier for that mine count.
- **Mine placement:** randomly placed at game start, positions fixed for the round via RNG.

---

## TODO — Mines v1

- [ ] Define final multiplier table values for each mineCount (1–24)
- [ ] Implement `MinesViewModel` with phase state machine (`idle → ready → playing → revealed/ended`)
- [ ] Build 5×5 grid UI with tap-to-reveal
- [ ] Implement fixed table lookup (`multipliers[mineCount][safeReveals]`)
- [ ] Wire wager modal messaging: "Wager: X min | Y minutes left" (no "+X" pre-round)
- [ ] Add Start Game button (enabled only when wager exists)
- [ ] Implement Cash Out button with delta calculation
- [ ] Add auto-cashout when all safe tiles revealed
- [ ] Reveal entire board on mine hit (gems + bombs)
- [ ] In-round feedback line: "Multiplier: Xx | Cashout: +Y min"
- [ ] Haptics: light on safe reveal, warning on mine hit, success on cashout
- [ ] Gem and bomb SF Symbols or custom icons
- [ ] Wire game result to `AppModel.applyGameResult`
- [ ] Clamp payout delta per `spec.md` payout cap
- [ ] Lock mineCount once round begins
