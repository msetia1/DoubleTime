# Mines Overview

Reveal tiles on a 5x5 grid. Each safe tile increases the payout multiplier. Hit a mine and lose everything. Cash out at any time to lock in winnings.

---

## How It Works

- The grid is 5x5 (25 tiles total).
- Before starting, the player chooses how many mines to hide (1 to 24).
- Mines are placed randomly on the grid (hidden from the player).
- The player reveals tiles one at a time.
- A safe tile (diamond) increases the current multiplier.
- A mine ends the round immediately and the wager is lost.
- The player can cash out after any safe reveal to lock in the current payout.

---

## User Inputs

- **wagerMinutes** (Int, 1 or more, must be less than or equal to remainingMinutes)
- **mineCount** (Int, 1 to 24): number of mines hidden on the grid

---

## Multiplier Formula

After revealing d safe tiles with m mines on the board:

- multiplier = 0.99 * C(25, d) / C(25 - m, d)

Where C(n, k) is the binomial coefficient (n choose k).

The 0.99 factor is the house edge (1%).

The multiplier increases with each safe tile revealed because the probability of having survived that many reveals decreases. More mines means faster multiplier growth but higher risk per reveal.

---

## Multiplier Examples by Mine Count

**1 mine (low risk):**

- 1 diamond: 1.03x
- 3 diamonds: 1.10x
- 5 diamonds: 1.19x
- 10 diamonds: 1.56x
- 24 diamonds (all safe): 24.75x

**3 mines (moderate risk):**

- 1 diamond: 1.13x
- 3 diamonds: 1.47x
- 5 diamonds: 2.01x
- 10 diamonds: 7.57x

**5 mines (high risk):**

- 1 diamond: 1.24x
- 3 diamonds: 1.80x
- 5 diamonds: 2.86x
- 10 diamonds: 25.30x

**10 mines (very high risk):**

- 1 diamond: 1.65x
- 3 diamonds: 4.95x
- 5 diamonds: 17.82x

---

## Game Resolution

- **Cash out after d diamonds revealed:**
  - payout = floor(wagerMinutes * currentMultiplier)
  - deltaMinutes = payout - wagerMinutes

- **Mine hit:**
  - deltaMinutes = -wagerMinutes

- **Reveal order does not affect outcome.** Mines are placed at game start. The multiplier depends only on how many safe tiles have been revealed, not which specific tiles.

---

## Worked Example

Setup: wagerMinutes = 10, mineCount = 3.

**Step 1:** Player reveals a tile. It is safe (diamond 1).

- multiplier = 0.99 * C(25,1) / C(22,1) = 0.99 * 25/22 = 1.125
- If cash out now: payout = floor(10 * 1.125) = floor(11.25) = 11, deltaMinutes = **+1 min**

**Step 2:** Player reveals another tile. Safe (diamond 2).

- multiplier = 0.99 * C(25,2) / C(22,2) = 0.99 * 300/231 = 1.286
- If cash out now: payout = floor(10 * 1.286) = floor(12.86) = 12, deltaMinutes = **+2 min**

**Step 3:** Player reveals another tile. It is a mine.

- deltaMinutes = **-10 min**

---

## Payout Cap

After computing deltaMinutes, the engine clamps the result so that remainingMinutes never exceeds minutes until midnight (23:59). See `spec.md` (Payout cap) for the full rule.

If the raw payout would exceed the cap, deltaMinutes is reduced. The player sees the capped amount.

---

## Edge Cases

- **1-minute wager with low multiplier:** at 1 mine and 1 diamond, multiplier = 1.03x. floor(1 * 1.03) = 1. deltaMinutes = 0 (push). The player needs to reveal more tiles to profit on small wagers.
- **All safe tiles revealed:** if the player reveals all (25 - mineCount) safe tiles, the round ends with the maximum multiplier for that mine count. No further reveals are possible.
- **Mine placement:** mines are randomly placed at game start and their positions are fixed for the round. The engine shuffles mine positions using RNG before the first reveal.
