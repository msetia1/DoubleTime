// Typography.swift
//
// Central typography tokens for consistent styling.
// Assumes the Outfit font files are bundled in the app.
//
// Setup checklist (do once):
// 1) Add font files to the project (e.g., Outfit-Regular.ttf, Outfit-Medium.ttf, Outfit-SemiBold.ttf, Outfit-Bold.ttf)
// 2) Ensure they are included in the app target.
// 3) Add them to Info.plist under "Fonts provided by application" (UIAppFonts).
//
// If the PostScript names differ, update FontName constants below.

import SwiftUI
import UIKit

enum Typography {

    // MARK: - Font Names (PostScript)

    enum FontName {
        static let outfitRegular  = "Outfit-Regular"
        static let outfitMedium   = "Outfit-Medium"
        static let outfitSemiBold = "Outfit-SemiBold"
        static let outfitBold     = "Outfit-Bold"
    }

    // MARK: - Public SwiftUI Tokens

    enum Token {

        // Hero metric (Home: remainingMinutes)
        static func heroMetric(size: CGFloat = 46) -> Font {
            custom(FontName.outfitBold, size: size, textStyle: .largeTitle)
        }

        // Screen title (e.g., "Home", "Crash")
        static func screenTitle() -> Font {
            custom(FontName.outfitSemiBold, size: 24, textStyle: .title2)
        }

        // Section headers (e.g., "Today", "History")
        static func sectionTitle() -> Font {
            custom(FontName.outfitSemiBold, size: 18, textStyle: .headline)
        }

        // Primary button label / key labels
        static func controlLabel() -> Font {
            custom(FontName.outfitSemiBold, size: 17, textStyle: .headline)
        }

        // Body copy
        static func body() -> Font {
            custom(FontName.outfitRegular, size: 17, textStyle: .body)
        }

        // Secondary / supporting copy
        static func secondary() -> Font {
            custom(FontName.outfitMedium, size: 15, textStyle: .subheadline)
        }

        // Small labels (chips, helper text)
        static func caption() -> Font {
            custom(FontName.outfitMedium, size: 13, textStyle: .footnote)
        }

        // Numeric outcomes (+X min / −Y min)
        static func outcome() -> Font {
            custom(FontName.outfitSemiBold, size: 17, textStyle: .headline)
        }
    }

    // MARK: - Implementation

    /// Creates a SwiftUI Font that scales with Dynamic Type using UIFontMetrics.
    private static func custom(_ name: String, size: CGFloat, textStyle: UIFont.TextStyle) -> Font {
        let base = UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
        let scaled = UIFontMetrics(forTextStyle: textStyle).scaledFont(for: base)
        return Font(scaled)
    }
}

// Optional ergonomic helpers
extension View {
    func typographyHeroMetric() -> some View { self.font(Typography.Token.heroMetric()) }
    func typographyScreenTitle() -> some View { self.font(Typography.Token.screenTitle()) }
    func typographySectionTitle() -> some View { self.font(Typography.Token.sectionTitle()) }
    func typographyControlLabel() -> some View { self.font(Typography.Token.controlLabel()) }
    func typographyBody() -> some View { self.font(Typography.Token.body()) }
    func typographySecondary() -> some View { self.font(Typography.Token.secondary()) }
    func typographyCaption() -> some View { self.font(Typography.Token.caption()) }
    func typographyOutcome() -> some View { self.font(Typography.Token.outcome()) }
}