---
title: "Blackjack"
category: "games"
description: "Blackjack rules, card values, player actions (hit/stand/double), dealer rules, natural blackjack, payout model, and worked examples."
last_updated: "2026-03-05"
---

# Blackjack Overview

Classic single-deck Blackjack against an automated dealer. Get closer to 21 than the dealer without going over. Hit, Stand, or Double Down.

---

## How It Works

- The player places a wager in minutes.
- Both the player and dealer are dealt two cards from a freshly shuffled single 52-card deck.
- The player's cards are face-up. The dealer shows one card face-up (upcard) and one face-down (hole card).
- The player chooses actions: Hit, Stand, or Double Down.
- After the player stands (or busts), the dealer plays by fixed rules.
- The outcome is compared and deltaMinutes is applied.

---

## User Inputs

- **wagerMinutes** (Int, 1 or more, must be less than or equal to remainingMinutes)

No side bets, no insurance, no split. Single hand only for v1.

---

## Card Values

- Number cards (2–10): face value
- Face cards (J, Q, K): 10
- Ace: 11, unless that would cause a bust, then 1

A hand's value is the sum of its card values using the ace rule above. A "soft" hand contains an ace counted as 11. A "hard" hand has no such ace.

---

## Dealing and Deck

- Single standard 52-card deck, shuffled via RNG at the start of each round.
- Deal order: player card 1, dealer card 1, player card 2, dealer card 2.
- No card counting across rounds; the deck is reshuffled every hand.

---

## Player Actions

**Hit:**
- Draw one card from the deck.
- If hand value exceeds 21, the player busts immediately (round ends, wager lost).
- The player can hit multiple times.

**Stand:**
- End the player's turn. Dealer plays next.

**Double Down:**
- Available only on the player's initial two cards (before any hits).
- The wager is doubled: effectiveWager = wagerMinutes * 2.
- The player must have remainingMinutes >= effectiveWager (i.e. enough to cover the doubled wager).
- Exactly one more card is dealt, then the player automatically stands.

---

## Dealer Rules

The dealer follows fixed rules after the player stands:

- Dealer reveals the hole card.
- Dealer must hit on 16 or below.
- Dealer must stand on 17 or above (including soft 17).
- Dealer continues hitting until reaching 17+ or busting.

No dealer decisions or strategy. Purely mechanical.

---

## Natural Blackjack

A "natural" or "blackjack" is an initial two-card hand of exactly 21 (an Ace + a 10-value card).

- **Player natural, dealer no natural:** player wins at 1.5x multiplier (Blackjack payout).
- **Dealer natural, player no natural:** player loses wager.
- **Both naturals:** push (deltaMinutes = 0).

Natural blackjack is checked before any player actions. If either side has a natural, the round resolves immediately.

---

## Game Resolution

After the dealer finishes, compare hand values:

**Player busts:**
- deltaMinutes = -effectiveWager

**Dealer busts (player didn't bust):**
- payout = floor(effectiveWager * 2)
- deltaMinutes = payout - effectiveWager

**Player hand > dealer hand (no bust):**
- payout = floor(effectiveWager * 2)
- deltaMinutes = payout - effectiveWager

**Dealer hand > player hand (no bust):**
- deltaMinutes = -effectiveWager

**Tie (push):**
- deltaMinutes = 0

**Player natural blackjack (no dealer natural):**
- payout = floor(effectiveWager * 2.5)
- deltaMinutes = payout - effectiveWager

Where effectiveWager = wagerMinutes if the player did not double down, or wagerMinutes * 2 if they did.

---

## House Edge

Single-deck blackjack with dealer stands on soft 17, no split, no insurance, no surrender:

- Approximate house edge: ~1.5%
- Slightly higher than the theoretical 0.5% optimal because split and surrender are not available.

---

## Worked Example

Setup: wagerMinutes = 10, single deck.

**Scenario A: Player wins normally**

- Player dealt: 9, 8 (value 17). Stands.
- Dealer upcard: 6, hole card: 10 (value 16). Dealer must hit.
- Dealer draws: 9. Dealer total: 25 (bust).
- payout = floor(10 * 2) = 20
- deltaMinutes = 20 - 10 = **+10 min**

**Scenario B: Player busts**

- Player dealt: 10, 6 (value 16). Hits.
- Player draws: 8. Total: 24 (bust).
- deltaMinutes = **-10 min**

**Scenario C: Player natural blackjack**

- Player dealt: A, K (value 21, natural).
- Dealer upcard: 7, hole card: 10 (value 17, not a natural).
- payout = floor(10 * 2.5) = floor(25) = 25
- deltaMinutes = 25 - 10 = **+15 min**

**Scenario D: Double down**

- Player dealt: 5, 6 (value 11). Doubles down.
- effectiveWager = 10 * 2 = 20.
- Player draws: 10. Total: 21. Stands automatically.
- Dealer upcard: 9, hole card: 7 (value 16). Dealer hits.
- Dealer draws: 6. Dealer total: 22 (bust).
- payout = floor(20 * 2) = 40
- deltaMinutes = 40 - 20 = **+20 min**

**Scenario E: Push**

- Player: 10, 8 (value 18). Stands.
- Dealer: 10, 8 (value 18). Stands.
- deltaMinutes = **0 min**

**Scenario F: Floor rounding on natural with small wager**

- wagerMinutes = 1, player natural blackjack.
- payout = floor(1 * 2.5) = floor(2.5) = 2
- deltaMinutes = 2 - 1 = **+1 min**

---

## Payout Cap

After computing deltaMinutes, the engine clamps the result so that remainingMinutes never exceeds minutes until midnight (23:59). See `spec.md` (Payout cap) for the full rule.

If the raw payout would exceed the cap, deltaMinutes is reduced. The player sees the capped amount.

---

## Edge Cases

- **Double down requires sufficient minutes:** if remainingMinutes < wagerMinutes * 2, the Double Down button is disabled. The wager preview should communicate why.
- **Floor rounding on 1.5x natural:** a 1-minute natural blackjack yields floor(2.5) = 2, so deltaMinutes = +1 (not +1.5). A 3-minute natural yields floor(7.5) = 7, deltaMinutes = +4.
- **Ace re-evaluation:** if a player has A + 5 (soft 16) and hits a 9, the ace switches from 11 to 1 to produce 15 instead of busting at 25.
- **Dealer does not peek early for non-natural hands:** the dealer hole card is only revealed after the player stands or busts. Exception: if the dealer upcard is A or 10-value, check for natural blackjack before player acts.
- **Single deck, no carry-over:** every round uses a freshly shuffled deck. No shoe penetration or card counting advantage.

---

## State Model (BlackjackViewModel)

### Inputs

- `wagerMinutes` — from shared wager flow
- `remainingMinutes` — derived, read-only

### Round State

- `phase`: `idle` | `dealing` | `playerTurn` | `dealerTurn` | `resolved`
- `playerHand`: [Card]
- `dealerHand`: [Card]
- `deck`: [Card] (shuffled at round start)
- `effectiveWager`: Int (wagerMinutes or wagerMinutes * 2)
- `didDoubleDown`: Bool

### Derived Values

- `playerValue`: computed hand value with ace logic
- `dealerValue`: computed hand value (full hand visible only after dealerTurn)
- `canHit = phase == .playerTurn && !didDoubleDown (after double, auto-stand)`
- `canStand = phase == .playerTurn`
- `canDoubleDown = phase == .playerTurn && playerHand.count == 2 && remainingMinutes >= wagerMinutes * 2`

---

## Design Note

Blackjack is the only game with multi-step player decisions during a round. The pending wager (mid-game kill forfeit) system from `architecture.md` applies: if the app is killed mid-hand, the wager is forfeit. For double down, the full effectiveWager is the forfeit amount since it was committed at double-down time.
