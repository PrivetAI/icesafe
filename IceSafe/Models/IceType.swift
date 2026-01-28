import Foundation

enum IceType: String, CaseIterable, Identifiable {
    case clear = "clear"
    case white = "white"
    case grey = "grey"
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .clear: return "Clear Blue Ice"
        case .white: return "White/Opaque Ice"
        case .grey: return "Grey Ice"
        }
    }
    
    var description: String {
        switch self {
        case .clear: return "Strongest type of ice. Formed by slow freezing of still water."
        case .white: return "Contains air bubbles. About 50% weaker than clear ice."
        case .grey: return "Very dangerous! Contains water. Do not walk on grey ice."
        }
    }
    
    var strengthMultiplier: Double {
        switch self {
        case .clear: return 1.0
        case .white: return 0.5
        case .grey: return 0.15
        }
    }
    
    var iconName: String {
        switch self {
        case .clear: return "ice_clear"
        case .white: return "ice_white"
        case .grey: return "ice_grey"
        }
    }
}
