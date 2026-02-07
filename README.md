# MicroStreaks (iOS 17+)

Production-quality SwiftUI micro-workout app architecture with onboarding, Today/Tracks/Progress/Settings tabs, offline-first seeded content, anti-guilt streak + momentum logic, StoreKit paywall scaffolding, and localization-ready string resources.

## How to run
1. Open in Xcode 15+ as an iOS App project.
2. Ensure folders map to groups:
   - `App/`, `DesignSystem/`, `Models/`, `Services/`, `Views/`, `Resources/`, `Widgets/`
3. Add `Resources/Localizable.strings`, `Resources/Localizable_sv.strings`, and `Resources/FeatureFlags.json` to target resources.
4. Set bundle URL scheme `microstreaks` for deep links.
5. Set StoreKit product IDs in `Services/PurchaseService.swift`.

## Content authoring
- Edit tracks/sessions in `Services/ContentSeedService.swift`.
- Keep all IDs stable via `stableKey`.
- Increment `ContentSeedService.contentVersion` when shipping new bundled content.

## Localization
- Use keys only in UI (`LocalizedStringKey` / `NSLocalizedString`).
- English keys live in `Resources/Localizable.strings`.
- Swedish stub demonstrates pipeline in `Resources/Localizable_sv.strings`.

## Add a new Track
1. Add new `TrackTheme` case in `DesignSystem/Theme.swift`.
2. Add track seed row and sessions in `ContentSeedService`.
3. Add localized keys for track name/description and session titles.
4. Add any icon/copy variants needed.

## QA checklist
- Onboarding to first session can be completed under 30s.
- Pro lock routes to paywall, and Restore works.
- Streak freeze edge cases (weekly reset, missed days) pass unit tests.
- Notification permission appears only from completion CTA.
- Dynamic Type and VoiceOver labels verified.
- Offline mode works for all non-StoreKit features.
- Dark mode checks done on Today/Tracks/Player/Paywall.
- Reduce Motion disables confetti/high-motion transitions.


## What changed in this iteration
- Added a 40-exercise catalog with stable keys and tags (desk, parents, running, stress, mobility, strength, noFloor, lowImpact).
- Updated per-track session plans to enforce 3 free starter sessions + 2 Pro sessions each, plus universal 2-min Reset.
- Added paywall timing rules + upsell banner logic and tests.
- Added Delete all data control in Settings with confirmation.
