import SwiftUI

enum SafetyLevel: String {
    case danger = "danger"
    case warning = "warning"
    case safe = "safe"
    
    var displayName: String {
        switch self {
        case .danger: return "DANGEROUS"
        case .warning: return "RISKY"
        case .safe: return "SAFE"
        }
    }
    
    var colour: Color {
        switch self {
        case .danger: return AppTheme.danger
        case .warning: return AppTheme.warning
        case .safe: return AppTheme.safe
        }
    }
    
    var gradient: LinearGradient {
        switch self {
        case .danger: return AppTheme.dangerGradient
        case .warning: return AppTheme.warningGradient
        case .safe: return AppTheme.safeGradient
        }
    }
    
    var iconName: String {
        switch self {
        case .danger: return "status_danger"
        case .warning: return "status_warning"
        case .safe: return "status_safe"
        }
    }
}

struct SafetyResult {
    let level: SafetyLevel
    let currentThickness: Double // cm
    let recommendedThickness: Double // cm
    let maxLoad: Double // kg
    let warnings: [String]
    let recommendations: [String]
    
    var safetyMargin: Double {
        guard recommendedThickness > 0 else { return 0 }
        return (currentThickness / recommendedThickness) * 100
    }
}
