# Slots Overview

Spin three reels for a chance at matching symbols. Instant resolution with no player decisions after the spin.

---

## How It Works

- The player sets a wager and taps "Spin."
- Three reels spin and stop on symbols.
- The outcome is determined by a weighted random selection at spin time.
- Matching symbols on the center payline pay a multiplier. No match means the wager is lost.
- There are no player decisions during or after the spin. One tap, one result.

---

## User Inputs

- **wagerMinutes** (Int, 1 or more, must be less than or equal to remainingMinutes)

No other options. Slots is the simplest game to play.

---

## Symbols and Payouts

Six symbols, ordered from most common to rarest:

| Symbol | Multiplier | Display |
|--------|-----------|---------|
| Cherry | 1x | Push (wager returned) |
| Lemon | 2x | Small win |
| Bell | 3x | Medium win |
| Star | 5x | Good win |
| Seven | 10x | Big win |
| Diamond | 50x | Jackpot |

Multiplier is applied to the full wager. A 1x result means the player gets their wager back (deltaMinutes = 0).

---

## Outcome Table

The engine selects an outcome from the following weighted table. The UI then displays reels matching the selected result.

| Outcome | Multiplier | Weight | Probability |
|---------|-----------|--------|-------------|
| No match | 0x | 790 | 79.0% |
| 3 Cherries | 1x | 110 | 11.0% |
| 3 Lemons | 2x | 50 | 5.0% |
| 3 Bells | 3x | 25 | 2.5% |
| 3 Stars | 5x | 15 | 1.5% |
| 3 Sevens | 10x | 7 | 0.7% |
| 3 Diamonds | 50x | 3 | 0.3% |

Total weight: 1000. House edge: ~3%.

For "No match" outcomes, the UI displays three random non-matching symbols on the reels.

---

## Game Resolution

- The engine generates a random integer in [0, 1000) and maps it to an outcome using the weight table.
- payout = floor(wagerMinutes * multiplier)
- deltaMinutes = payout - wagerMinutes

---

## Worked Example

Setup: wagerMinutes = 10.

**Scenario A: 3 Lemons (2x)**

- payout = floor(10 * 2) = 20
- deltaMinutes = 20 - 10 = **+10 min**

**Scenario B: No match (0x)**

- payout = floor(10 * 0) = 0
- deltaMinutes = 0 - 10 = **-10 min**

**Scenario C: 3 Cherries on a 1-minute wager (1x)**

- payout = floor(1 * 1) = 1
- deltaMinutes = 1 - 1 = **0 min** (push)

**Scenario D: 3 Diamonds on 5-minute wager (50x)**

- payout = floor(5 * 50) = 250
- deltaMinutes = 250 - 5 = **+245 min**

---

## Payout Cap

After computing deltaMinutes, the engine clamps the result so that remainingMinutes never exceeds minutes until midnight (23:59). See `spec.md` (Payout cap) for the full rule.

If the raw payout would exceed the cap, deltaMinutes is reduced. The player sees the capped amount.

---

## Edge Cases

- **79% of spins are losses.** This is expected for a slot machine. The high-multiplier outcomes compensate to maintain ~97% RTP.
- **1-minute wager with 1x result:** deltaMinutes = 0 (push). The smallest meaningful win on a 1-minute wager requires a 2x outcome (+1 min).
- **Large jackpots:** a 3-Diamond hit on a max wager can return a very large number of minutes. This is intentional and matches the spec (no max wager, no anti-tilt restrictions).

---

## Design Note

The engine uses weighted outcome selection rather than independent reel simulation. This keeps the math simple, the house edge precise, and avoids the low hit rates that independent 3-reel probability creates. The UI animates reels for the visual experience, but the outcome is determined before the reels spin.
