import SwiftUI

enum Theme {
    // MARK: - Palette

    static let cremaCalido = Color(hex: "F5F0E8")
    static let verdeMusgo = Color(hex: "5B7553")
    static let terracota = Color(hex: "C17F59")
    static let chocolate = Color(hex: "4A3728")
    static let marronClaro = Color(hex: "8B7D6B")
    static let cremaClaro = Color(hex: "FAF7F2")

    // MARK: - Semantic

    static let background = cremaCalido
    static let surface = cremaClaro
    static let primary = terracota
    static let textPrimary = chocolate
    static let textSecondary = marronClaro
    static let natural = verdeMusgo

    // MARK: - Typography

    static let titleLarge = Font.system(.largeTitle, design: .rounded, weight: .bold)
    static let titleMedium = Font.system(.title2, design: .rounded, weight: .semibold)
    static let titleSmall = Font.system(.title3, design: .rounded, weight: .medium)
    static let bodyFont = Font.system(.body, design: .rounded)
    static let bodyBold = Font.system(.body, design: .rounded, weight: .semibold)
    static let caption = Font.system(.caption, design: .rounded)
    static let captionBold = Font.system(.caption, design: .rounded, weight: .semibold)

    static func rounded(_ style: Font.TextStyle, weight: Font.Weight = .regular) -> Font {
        .system(style, design: .rounded, weight: weight)
    }

    // MARK: - Spacing

    static let spacingXS: CGFloat = 4
    static let spacingS: CGFloat = 8
    static let spacingM: CGFloat = 16
    static let spacingL: CGFloat = 24
    static let spacingXL: CGFloat = 32
    static let spacingXXL: CGFloat = 48

    // MARK: - Radii

    static let radiusS: CGFloat = 8
    static let radiusM: CGFloat = 12
    static let radiusL: CGFloat = 16

    // MARK: - Sizes

    static let nodeSize: CGFloat = 44
    static let nodeSmall: CGFloat = 32
    static let fabSize: CGFloat = 56
}

// MARK: - Color hex init

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: UInt64
        switch hex.count {
        case 6:
            (r, g, b) = ((int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF)
        default:
            (r, g, b) = (0, 0, 0)
        }
        self.init(
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255
        )
    }
}
