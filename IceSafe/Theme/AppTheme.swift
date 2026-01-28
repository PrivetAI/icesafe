import SwiftUI

struct AppTheme {
    // Background colours
    static let background = Color(hex: "0A1628")
    static let cardBackground = Color(hex: "132744")
    static let cardBackgroundLight = Color(hex: "1A3556")
    
    // Primary colours
    static let primary = Color(hex: "4FC3F7")
    static let accent = Color(hex: "81D4FA")
    static let accentLight = Color(hex: "B3E5FC")
    
    // Status colours
    static let danger = Color(hex: "EF5350")
    static let dangerDark = Color(hex: "C62828")
    static let warning = Color(hex: "FFB74D")
    static let warningDark = Color(hex: "F57C00")
    static let safe = Color(hex: "66BB6A")
    static let safeDark = Color(hex: "388E3C")
    
    // Text colours
    static let textPrimary = Color.white
    static let textSecondary = Color(hex: "B0BEC5")
    static let textMuted = Color(hex: "78909C")
    
    // Gradients
    static let iceGradient = LinearGradient(
        colors: [Color(hex: "4FC3F7"), Color(hex: "0288D1")],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let dangerGradient = LinearGradient(
        colors: [Color(hex: "EF5350"), Color(hex: "C62828")],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let warningGradient = LinearGradient(
        colors: [Color(hex: "FFB74D"), Color(hex: "F57C00")],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let safeGradient = LinearGradient(
        colors: [Color(hex: "66BB6A"), Color(hex: "388E3C")],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    // Spacing
    static let paddingSmall: CGFloat = 8
    static let paddingMedium: CGFloat = 16
    static let paddingLarge: CGFloat = 24
    
    // Corner radius
    static let cornerRadiusSmall: CGFloat = 8
    static let cornerRadiusMedium: CGFloat = 12
    static let cornerRadiusLarge: CGFloat = 20
}

// Hex colour extension
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
