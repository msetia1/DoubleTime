# Plinko Overview

A ball drops through a pyramid of pins and lands in a multiplier bucket. The player controls risk level, which determines the spread of multipliers.

---

## How It Works

- A ball is released from the top center of a pin pyramid.
- At each row of pins, the ball bounces left or right with equal probability (50/50).
- The ball lands in one of the buckets at the bottom.
- Each bucket has a multiplier determined by the selected risk level.
- Edge buckets pay the highest multipliers; center buckets pay the lowest.

---

## User Inputs

- **wagerMinutes** (Int, 1 or more, must be less than or equal to remainingMinutes)
- **Risk level:** Low, Medium, or High

---

## Pin Pyramid

The pyramid has 8 rows, producing 9 buckets (positions 0 through 8).

Each pin bounce is an independent 50/50 event. The probability of landing in each bucket follows a binomial distribution:

- Position 0 (far left): 1/256 (0.4%)
- Position 1: 8/256 (3.1%)
- Position 2: 28/256 (10.9%)
- Position 3: 56/256 (21.9%)
- Position 4 (center): 70/256 (27.3%)
- Positions 5-8 mirror positions 3-0

---

## Multiplier Tables

Buckets are symmetric. Values shown left to right (position 0 through 8).

**Low Risk:**

- [5.6, 2.1, 1.1, 1.0, 0.5, 1.0, 1.1, 2.1, 5.6]
- Tight range, most drops return close to the wager.

**Medium Risk:**

- [13, 3, 1.3, 0.7, 0.4, 0.7, 1.3, 3, 13]
- Wider swings. Center buckets lose more; edges pay more.

**High Risk:**

- [29, 4, 1.5, 0.3, 0.2, 0.3, 1.5, 4, 29]
- Lottery-like profile. Most drops lose significantly; rare edge hits pay big.

House edge: ~1% across all risk levels.

---

## Game Resolution

- The engine simulates 8 coin flips (one per pin row) to determine the landing bucket.
- The bucket's multiplier is looked up from the selected risk table.
- payout = floor(wagerMinutes * bucketMultiplier)
- deltaMinutes = payout - wagerMinutes

---

## Worked Example

Setup: wagerMinutes = 10, risk = Medium, ball lands in position 1 (multiplier 3x).

- payout = floor(10 * 3) = 30
- deltaMinutes = 30 - 10 = **+20 min**

Setup: wagerMinutes = 10, risk = High, ball lands in position 4 (center, multiplier 0.2x).

- payout = floor(10 * 0.2) = floor(2) = 2
- deltaMinutes = 2 - 10 = **-8 min**

Setup: wagerMinutes = 3, risk = Low, ball lands in position 3 (multiplier 1.0x).

- payout = floor(3 * 1.0) = 3
- deltaMinutes = 3 - 3 = **0 min** (push)

---

## Payout Cap

After computing deltaMinutes, the engine clamps the result so that remainingMinutes never exceeds minutes until midnight (23:59). See `spec.md` (Payout cap) for the full rule.

If the raw payout would exceed the cap, deltaMinutes is reduced. The player sees the capped amount.

---

## Edge Cases

- **Sub-1x multipliers with small wagers:** a 1-minute wager landing on a 0.5x bucket yields floor(0.5) = 0, so deltaMinutes = -1 (full loss). The wager preview should show this as "-1 min", not "partial return."
- **Sub-1x multipliers with larger wagers:** a 10-minute wager on 0.5x yields floor(5) = 5, deltaMinutes = -5 (partial loss). Floor rounding is visible here.
- **All risk levels are available regardless of remainingMinutes.** The player chooses volatility, not expected value (house edge is the same).

---

## Future Extension

Additional row counts (12, 16) can be added by defining new multiplier tables with the same structure: symmetric buckets, ~1% house edge, wider spread at higher risk. Each row count produces (rows + 1) buckets with binomial landing probabilities.
