# Styling

This document defines a minimal styling system so all screens feel cohesive.
It pairs with `Core/Design/Typography.swift` for font consistency and with reference screenshots in `Docs/ui-similar/screens`.

Goals:

- Calm, premium, modern iOS feel
- High clarity under time pressure
- Consistent components across Home, Games, Settings, History
- Slightly branded, not “theme-y”

Non-goals:

- No complex theming framework
- No heavy dependencies
- No constant motion or noisy visuals

---

## Brand Palette

Palette:

- #820263
- #D90368
- #EADEDA
- #2E294E
- #FFD400

Usage intent:

- #2E294E: primary brand “ink” and deep accent (titles, icons, subtle accents)
- #D90368: primary action accent (button gradient endpoint, active highlights)
- #820263: secondary accent (button gradient start, subtle emphasis)
- #FFD400: highlight only (wins, spark moments, never full backgrounds)
- #EADEDA: warm surface tint (Home cards only, optional)

Rules:

- Default to system colors for backgrounds and text to preserve light/dark mode.
- Inject brand color through accents, gradients, and small highlights.
- Avoid using more than 2 brand colors in the same component unless it is a deliberate “hero” element.

---

## Color Usage

Base colors:

- Backgrounds:
  - Color(.systemBackground)
  - Color(.secondarySystemBackground)
  - Color(.tertiarySystemBackground)

- Text:
  - Color.primary
  - Color.secondary

Brand application:

- Primary action accents:
  - Use the app-defined accent (recommend: #D90368).
  - Use a subtle gradient (#820263 → #D90368) on the main Lock/Unlock control.

- State colors:
  - Use “greyed” states via opacity and desaturation, not by inventing new grays.
  - Use red sparingly for negative outcomes and “0 minutes remaining” messaging.

Do not:

- Hardcode many hex colors across views.
- Use yellow (#FFD400) as a background.
- Create per-screen custom palettes.

---

## Typography

Font family:

- Outfit (bundled, app-defined)

Single source of truth:

- Use `Typography.swift` tokens everywhere.
- Do not set ad-hoc fonts in individual views.

Token usage:

- Hero metric (remainingMinutes):
  - `Typography.Token.heroMetric()`

- Screen title:
  - `Typography.Token.screenTitle()`

- Section title:
  - `Typography.Token.sectionTitle()`

- Primary controls (Lock/Unlock label, primary buttons):
  - `Typography.Token.controlLabel()`

- Body:
  - `Typography.Token.body()`

- Secondary and inline status:
  - `Typography.Token.secondary()`

- Small labels / chips:
  - `Typography.Token.caption()`

- Outcome labels (+X min / −Y min):
  - `Typography.Token.outcome()`

Rules:

- Never mix more than 3 font weights on a single screen.
- Keep most text in Regular/Medium.
- Reserve SemiBold/Bold for titles and the hero metric.
- Remaining minutes is the visual hero on Home.
- When remainingMinutes hits 0, the hero metric should appear greyed out (e.g., reduced opacity + secondary color).

---

## Spacing and Layout

Spacing scale:

- 4: micro
- 8: tight
- 12: default between related elements
- 16: default padding for screens and cards
- 24: separation between major sections

Rules:

- Screen padding: 16
- Card padding: 16
- Major vertical section spacing: 24
- Prefer leading alignment for text, except the hero metric which may be centered.

---

## Shapes, Corners, Shadows

Corner radius:

- Cards: 16
- Buttons: 14
- Chips/badges: 10

Shadows:

- Use none or very subtle.
- If used, apply only to primary tappable elements.
- Use one shadow style across the app.

---

## Components

Components that carry the brand and enforce consistency:

- RemainingMinutesHero
- BrandLockButton
- CardContainer (Home, History)
- WagerChips (1, 5, 10)
- InlineStatusMessage (fade in/out)

Implementation mapping (required):

- `RemainingMinutesHero` → `Features/Home/Components/RemainingMinutesHero.swift`
- `CardContainer` → `Features/Home/Components/CardContainer.swift`
- `WagerChips` and `WagerChip` → `Features/Home/Components/WagerChips.swift`
- `InlineStatusMessage` → `Features/Home/Components/InlineStatusMessage.swift`
- Branded action button style (`BrandLockButton` styling contract) → `Core/Design/BrandedActionButtonStyle.swift`
- Brand colors used by shared components → `Core/Design/BrandPalette.swift`

LLM rules:

- Reuse these shared components/styles when building or updating UI.
- Do not recreate card/button/chip/status styles inline in feature screens.
- If behavior changes, update the shared primitive first, then consumers.
- Keep typography via `Core/Design/Typography.swift`; no ad-hoc font declarations.

Cards:

- Use primarily on Home and History.
- Avoid “cards everywhere”; games should be more immersive.

Games:

- May break layout for immersion.
- Still must use shared typography tokens, spacing scale, and consistent control styling.

---

## Lock/Unlock Control Styling

The Lock/Unlock control is a button that visually communicates state.

Unlocked:

- Branded gradient (#820263 → #D90368), normal opacity
- Label uses `Typography.Token.controlLabel()`

Locked (unlock allowed):

- Muted fill (system background), visible border or subtle tint
- Label uses `Typography.Token.controlLabel()`

Locked (remainingMinutes == 0):

- Control appears greyed out via opacity + desaturation
- Still responds to tap with feedback (do not use `.disabled(true)`)

Blocked unlock feedback:

- Subtle shake animation applied to the control only
- Inline message under control: “0 minutes remaining”
- Message fades in/out
- Optional warning haptic

---

## Motion and Animation

Principles:

- Motion clarifies cause and effect.
- Keep it moderately expressive, not noisy.
- Same win/loss animation language across all games.

Durations:

- Tap feedback: 0.12–0.18s
- State transitions: 0.20–0.30s
- Inline message fade: 0.20s in, 0.30–0.40s out
- Shake: short, subtle

Patterns:

- Win:
  - small scale pulse on hero metric or outcome label
  - brief highlight flash
  - success haptic

- Loss:
  - small shake on outcome label
  - brief desaturation
  - warning haptic

Reduce Motion:

- Motion should still be noticeable by default.
- If Reduce Motion is enabled, replace shake with a quick opacity pulse.

---

## Haptics and Sound

Haptics:

- Light impact for primary taps
- Notification success for wins
- Notification warning for blocked unlock attempt
- Notification error for permission/shield failures

Sound (optional):

- Short, subtle cues only
- Must be easily muted in Settings

---

## Copy and Tone

Audience:

- College students

Tone:

- Direct, non-judgmental, slightly playful in outcomes

Preferred phrasing:

- “Wager minutes”
- “Win minutes”
- “Lose minutes”
- “Restricted Apps Locked”
- “Restricted Apps Unlocked”

Inline message:

- Exactly: “0 minutes remaining”

Outcome strings:

- “+X min”
- “−Y min”

Avoid:

- Casino-heavy language in main UI copy
- Overly dramatic copy for losses

---

## Accessibility

Requirements:

- Supports Dynamic Type
- Contrast-safe colors (prefer system colors for text)
- Touch targets at least 44x44
- VoiceOver labels:
  - Remaining minutes: “Remaining minutes: X”
  - Lock state: “Restricted apps locked/unlocked”
  - Outcomes: “Won X minutes” / “Lost Y minutes”
