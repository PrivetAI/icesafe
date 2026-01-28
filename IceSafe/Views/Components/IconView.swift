import SwiftUI

enum AppIcon: String {
    // Tab bar icons
    case calculator = "tab_calculator"
    case reference = "tab_reference"
    case safety = "tab_safety"
    case log = "tab_log"
    case formation = "tab_formation"
    
    // Status icons
    case statusSafe = "status_safe"
    case statusWarning = "status_warning"
    case statusDanger = "status_danger"
    
    // Ice type icons
    case iceClear = "ice_clear"
    case iceWhite = "ice_white"
    case iceGrey = "ice_grey"
    
    // Equipment icons
    case person = "equipment_person"
    case snowmobile = "equipment_snowmobile"
    case shelter = "equipment_shelter"
    case auger = "equipment_auger"
    case gear = "equipment_gear"
    
    // Misc icons
    case ruler = "misc_ruler"
    case thermometer = "misc_thermometer"
    case warning = "misc_warning"
    case info = "misc_info"
    case plus = "misc_plus"
    case check = "misc_check"
}

struct IconView: View {
    let icon: AppIcon
    var size: CGFloat = 24
    var colour: Color = AppTheme.textPrimary
    
    var body: some View {
        iconShape
            .foregroundColor(colour)
            .frame(width: size, height: size)
    }
    
    @ViewBuilder
    private var iconShape: some View {
        switch icon {
        // Tab bar icons
        case .calculator:
            CalculatorIconShape()
        case .reference:
            ReferenceIconShape()
        case .safety:
            SafetyIconShape()
        case .log:
            LogIconShape()
        case .formation:
            FormationIconShape()
            
        // Status icons
        case .statusSafe:
            StatusSafeShape()
        case .statusWarning:
            StatusWarningShape()
        case .statusDanger:
            StatusDangerShape()
            
        // Ice type icons
        case .iceClear:
            IceClearShape()
        case .iceWhite:
            IceWhiteShape()
        case .iceGrey:
            IceGreyShape()
            
        // Equipment icons
        case .person:
            PersonIconShape()
        case .snowmobile:
            SnowmobileIconShape()
        case .shelter:
            ShelterIconShape()
        case .auger:
            AugerIconShape()
        case .gear:
            GearIconShape()
            
        // Misc icons
        case .ruler:
            RulerIconShape()
        case .thermometer:
            ThermometerIconShape()
        case .warning:
            WarningIconShape()
        case .info:
            InfoIconShape()
        case .plus:
            PlusIconShape()
        case .check:
            CheckIconShape()
        }
    }
}

// MARK: - Tab Bar Icons

struct CalculatorIconShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        
        // Calculator body
        path.addRoundedRect(in: CGRect(x: w * 0.15, y: h * 0.1, width: w * 0.7, height: h * 0.8), cornerSize: CGSize(width: 4, height: 4))
        
        // Screen
        path.addRect(CGRect(x: w * 0.25, y: h * 0.18, width: w * 0.5, height: h * 0.2))
        
        // Buttons grid
        for row in 0..<3 {
            for col in 0..<3 {
                let x = w * 0.25 + CGFloat(col) * w * 0.17
                let y = h * 0.45 + CGFloat(row) * h * 0.14
                path.addEllipse(in: CGRect(x: x, y: y, width: w * 0.12, height: w * 0.12))
            }
        }
        
        return path
    }
}

struct ReferenceIconShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        
        // Table grid
        path.addRoundedRect(in: CGRect(x: w * 0.1, y: h * 0.1, width: w * 0.8, height: h * 0.8), cornerSize: CGSize(width: 3, height: 3))
        
        // Horizontal lines
        path.move(to: CGPoint(x: w * 0.1, y: h * 0.35))
        path.addLine(to: CGPoint(x: w * 0.9, y: h * 0.35))
        path.move(to: CGPoint(x: w * 0.1, y: h * 0.55))
        path.addLine(to: CGPoint(x: w * 0.9, y: h * 0.55))
        path.move(to: CGPoint(x: w * 0.1, y: h * 0.75))
        path.addLine(to: CGPoint(x: w * 0.9, y: h * 0.75))
        
        // Vertical line
        path.move(to: CGPoint(x: w * 0.4, y: h * 0.1))
        path.addLine(to: CGPoint(x: w * 0.4, y: h * 0.9))
        
        return path
    }
}

struct SafetyIconShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        
        // Shield shape
        path.move(to: CGPoint(x: w * 0.5, y: h * 0.05))
        path.addLine(to: CGPoint(x: w * 0.9, y: h * 0.2))
        path.addLine(to: CGPoint(x: w * 0.9, y: h * 0.5))
        path.addQuadCurve(to: CGPoint(x: w * 0.5, y: h * 0.95), control: CGPoint(x: w * 0.9, y: h * 0.8))
        path.addQuadCurve(to: CGPoint(x: w * 0.1, y: h * 0.5), control: CGPoint(x: w * 0.1, y: h * 0.8))
        path.addLine(to: CGPoint(x: w * 0.1, y: h * 0.2))
        path.closeSubpath()
        
        // Checkmark inside
        path.move(to: CGPoint(x: w * 0.3, y: h * 0.5))
        path.addLine(to: CGPoint(x: w * 0.45, y: h * 0.65))
        path.addLine(to: CGPoint(x: w * 0.7, y: h * 0.35))
        
        return path
    }
}

struct LogIconShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        
        // Notebook
        path.addRoundedRect(in: CGRect(x: w * 0.15, y: h * 0.08, width: w * 0.7, height: h * 0.84), cornerSize: CGSize(width: 4, height: 4))
        
        // Spiral binding
        for i in 0..<5 {
            let y = h * 0.2 + CGFloat(i) * h * 0.15
            path.addEllipse(in: CGRect(x: w * 0.1, y: y, width: w * 0.1, height: h * 0.08))
        }
        
        // Lines
        for i in 0..<4 {
            let y = h * 0.25 + CGFloat(i) * h * 0.15
            path.move(to: CGPoint(x: w * 0.3, y: y))
            path.addLine(to: CGPoint(x: w * 0.75, y: y))
        }
        
        return path
    }
}

struct FormationIconShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        
        // Snowflake with filled center
        let center = CGPoint(x: w * 0.5, y: h * 0.5)
        let radius = min(w, h) * 0.4
        
        // Center hexagon
        for i in 0..<6 {
            let angle = CGFloat(i) * .pi / 3
            let point = CGPoint(x: center.x + cos(angle) * radius * 0.2, y: center.y + sin(angle) * radius * 0.2)
            if i == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        path.closeSubpath()
        
        // Main rays
        for i in 0..<6 {
            let angle = CGFloat(i) * .pi / 3
            let startPoint = CGPoint(x: center.x + cos(angle) * radius * 0.2, y: center.y + sin(angle) * radius * 0.2)
            let endPoint = CGPoint(x: center.x + cos(angle) * radius, y: center.y + sin(angle) * radius)
            
            // Main ray line
            path.move(to: startPoint)
            path.addLine(to: endPoint)
            
            // Small branches at 60% distance
            let branchStart = CGPoint(x: center.x + cos(angle) * radius * 0.6, y: center.y + sin(angle) * radius * 0.6)
            let branchAngle1 = angle + .pi / 6
            let branchAngle2 = angle - .pi / 6
            let branchLength = radius * 0.2
            
            path.move(to: branchStart)
            path.addLine(to: CGPoint(x: branchStart.x + cos(branchAngle1) * branchLength, y: branchStart.y + sin(branchAngle1) * branchLength))
            path.move(to: branchStart)
            path.addLine(to: CGPoint(x: branchStart.x + cos(branchAngle2) * branchLength, y: branchStart.y + sin(branchAngle2) * branchLength))
            
            // Tip decorations
            path.addEllipse(in: CGRect(x: endPoint.x - w * 0.04, y: endPoint.y - h * 0.04, width: w * 0.08, height: h * 0.08))
        }
        
        return path
    }
}

// MARK: - Status Icons

struct StatusSafeShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        
        // Circle
        path.addEllipse(in: rect.insetBy(dx: w * 0.1, dy: h * 0.1))
        
        // Checkmark
        path.move(to: CGPoint(x: w * 0.28, y: h * 0.52))
        path.addLine(to: CGPoint(x: w * 0.42, y: h * 0.68))
        path.addLine(to: CGPoint(x: w * 0.72, y: h * 0.35))
        
        return path
    }
}

struct StatusWarningShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        
        // Triangle
        path.move(to: CGPoint(x: w * 0.5, y: h * 0.1))
        path.addLine(to: CGPoint(x: w * 0.95, y: h * 0.9))
        path.addLine(to: CGPoint(x: w * 0.05, y: h * 0.9))
        path.closeSubpath()
        
        // Exclamation mark
        path.addRect(CGRect(x: w * 0.45, y: h * 0.35, width: w * 0.1, height: h * 0.3))
        path.addEllipse(in: CGRect(x: w * 0.45, y: h * 0.72, width: w * 0.1, height: w * 0.1))
        
        return path
    }
}

struct StatusDangerShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        
        // Octagon
        let inset: CGFloat = 0.15
        path.move(to: CGPoint(x: w * 0.35, y: h * inset))
        path.addLine(to: CGPoint(x: w * 0.65, y: h * inset))
        path.addLine(to: CGPoint(x: w * (1 - inset), y: h * 0.35))
        path.addLine(to: CGPoint(x: w * (1 - inset), y: h * 0.65))
        path.addLine(to: CGPoint(x: w * 0.65, y: h * (1 - inset)))
        path.addLine(to: CGPoint(x: w * 0.35, y: h * (1 - inset)))
        path.addLine(to: CGPoint(x: w * inset, y: h * 0.65))
        path.addLine(to: CGPoint(x: w * inset, y: h * 0.35))
        path.closeSubpath()
        
        // X mark
        path.move(to: CGPoint(x: w * 0.35, y: h * 0.35))
        path.addLine(to: CGPoint(x: w * 0.65, y: h * 0.65))
        path.move(to: CGPoint(x: w * 0.65, y: h * 0.35))
        path.addLine(to: CGPoint(x: w * 0.35, y: h * 0.65))
        
        return path
    }
}

// MARK: - Ice Type Icons

struct IceClearShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        
        // Crystal/diamond shape
        path.move(to: CGPoint(x: w * 0.5, y: h * 0.05))
        path.addLine(to: CGPoint(x: w * 0.85, y: h * 0.35))
        path.addLine(to: CGPoint(x: w * 0.5, y: h * 0.95))
        path.addLine(to: CGPoint(x: w * 0.15, y: h * 0.35))
        path.closeSubpath()
        
        // Internal lines for crystal effect
        path.move(to: CGPoint(x: w * 0.5, y: h * 0.05))
        path.addLine(to: CGPoint(x: w * 0.5, y: h * 0.95))
        path.move(to: CGPoint(x: w * 0.15, y: h * 0.35))
        path.addLine(to: CGPoint(x: w * 0.85, y: h * 0.35))
        
        return path
    }
}

struct IceWhiteShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        
        // Ice block with bubbles
        path.addRoundedRect(in: CGRect(x: w * 0.1, y: h * 0.1, width: w * 0.8, height: h * 0.8), cornerSize: CGSize(width: 6, height: 6))
        
        // Bubbles
        path.addEllipse(in: CGRect(x: w * 0.2, y: h * 0.25, width: w * 0.15, height: w * 0.15))
        path.addEllipse(in: CGRect(x: w * 0.55, y: h * 0.2, width: w * 0.2, height: w * 0.2))
        path.addEllipse(in: CGRect(x: w * 0.35, y: h * 0.5, width: w * 0.12, height: w * 0.12))
        path.addEllipse(in: CGRect(x: w * 0.6, y: h * 0.55, width: w * 0.18, height: w * 0.18))
        path.addEllipse(in: CGRect(x: w * 0.2, y: h * 0.65, width: w * 0.1, height: w * 0.1))
        
        return path
    }
}

struct IceGreyShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        
        // Cracked ice
        path.addRoundedRect(in: CGRect(x: w * 0.1, y: h * 0.1, width: w * 0.8, height: h * 0.8), cornerSize: CGSize(width: 6, height: 6))
        
        // Cracks
        path.move(to: CGPoint(x: w * 0.3, y: h * 0.1))
        path.addLine(to: CGPoint(x: w * 0.4, y: h * 0.4))
        path.addLine(to: CGPoint(x: w * 0.2, y: h * 0.6))
        path.addLine(to: CGPoint(x: w * 0.35, y: h * 0.9))
        
        path.move(to: CGPoint(x: w * 0.7, y: h * 0.1))
        path.addLine(to: CGPoint(x: w * 0.55, y: h * 0.35))
        path.addLine(to: CGPoint(x: w * 0.8, y: h * 0.6))
        path.addLine(to: CGPoint(x: w * 0.6, y: h * 0.9))
        
        path.move(to: CGPoint(x: w * 0.4, y: h * 0.4))
        path.addLine(to: CGPoint(x: w * 0.55, y: h * 0.35))
        
        return path
    }
}

// MARK: - Equipment Icons

struct PersonIconShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        
        // Head
        path.addEllipse(in: CGRect(x: w * 0.35, y: h * 0.05, width: w * 0.3, height: h * 0.25))
        
        // Body
        path.move(to: CGPoint(x: w * 0.5, y: h * 0.3))
        path.addLine(to: CGPoint(x: w * 0.5, y: h * 0.6))
        
        // Arms
        path.move(to: CGPoint(x: w * 0.2, y: h * 0.5))
        path.addLine(to: CGPoint(x: w * 0.8, y: h * 0.5))
        
        // Legs
        path.move(to: CGPoint(x: w * 0.5, y: h * 0.6))
        path.addLine(to: CGPoint(x: w * 0.25, y: h * 0.95))
        path.move(to: CGPoint(x: w * 0.5, y: h * 0.6))
        path.addLine(to: CGPoint(x: w * 0.75, y: h * 0.95))
        
        return path
    }
}

struct SnowmobileIconShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        
        // Track
        path.addRoundedRect(in: CGRect(x: w * 0.05, y: h * 0.6, width: w * 0.9, height: h * 0.3), cornerSize: CGSize(width: h * 0.15, height: h * 0.15))
        
        // Body
        path.move(to: CGPoint(x: w * 0.15, y: h * 0.6))
        path.addLine(to: CGPoint(x: w * 0.25, y: h * 0.35))
        path.addLine(to: CGPoint(x: w * 0.7, y: h * 0.35))
        path.addLine(to: CGPoint(x: w * 0.85, y: h * 0.6))
        
        // Windshield
        path.move(to: CGPoint(x: w * 0.55, y: h * 0.35))
        path.addLine(to: CGPoint(x: w * 0.45, y: h * 0.15))
        path.addLine(to: CGPoint(x: w * 0.35, y: h * 0.15))
        path.addLine(to: CGPoint(x: w * 0.25, y: h * 0.35))
        
        // Handlebars
        path.move(to: CGPoint(x: w * 0.3, y: h * 0.2))
        path.addLine(to: CGPoint(x: w * 0.15, y: h * 0.15))
        path.move(to: CGPoint(x: w * 0.5, y: h * 0.2))
        path.addLine(to: CGPoint(x: w * 0.6, y: h * 0.1))
        
        return path
    }
}

struct ShelterIconShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        
        // Tent/house shape
        path.move(to: CGPoint(x: w * 0.5, y: h * 0.1))
        path.addLine(to: CGPoint(x: w * 0.9, y: h * 0.4))
        path.addLine(to: CGPoint(x: w * 0.9, y: h * 0.9))
        path.addLine(to: CGPoint(x: w * 0.1, y: h * 0.9))
        path.addLine(to: CGPoint(x: w * 0.1, y: h * 0.4))
        path.closeSubpath()
        
        // Door
        path.addRect(CGRect(x: w * 0.4, y: h * 0.55, width: w * 0.2, height: h * 0.35))
        
        // Window
        path.addRect(CGRect(x: w * 0.65, y: h * 0.5, width: w * 0.15, height: h * 0.15))
        
        return path
    }
}

struct AugerIconShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        
        // Handle
        path.move(to: CGPoint(x: w * 0.3, y: h * 0.1))
        path.addLine(to: CGPoint(x: w * 0.7, y: h * 0.1))
        
        // Shaft
        path.move(to: CGPoint(x: w * 0.5, y: h * 0.1))
        path.addLine(to: CGPoint(x: w * 0.5, y: h * 0.7))
        
        // Spiral blade
        path.move(to: CGPoint(x: w * 0.3, y: h * 0.7))
        path.addQuadCurve(to: CGPoint(x: w * 0.7, y: h * 0.75), control: CGPoint(x: w * 0.5, y: h * 0.65))
        path.addQuadCurve(to: CGPoint(x: w * 0.3, y: h * 0.8), control: CGPoint(x: w * 0.5, y: h * 0.85))
        path.addQuadCurve(to: CGPoint(x: w * 0.6, y: h * 0.9), control: CGPoint(x: w * 0.5, y: h * 0.78))
        
        // Point
        path.move(to: CGPoint(x: w * 0.5, y: h * 0.85))
        path.addLine(to: CGPoint(x: w * 0.5, y: h * 0.95))
        
        return path
    }
}

struct GearIconShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        
        // Backpack/bag shape
        path.addRoundedRect(in: CGRect(x: w * 0.2, y: h * 0.2, width: w * 0.6, height: h * 0.7), cornerSize: CGSize(width: 8, height: 8))
        
        // Top flap
        path.move(to: CGPoint(x: w * 0.25, y: h * 0.2))
        path.addQuadCurve(to: CGPoint(x: w * 0.75, y: h * 0.2), control: CGPoint(x: w * 0.5, y: h * 0.05))
        
        // Pocket
        path.addRoundedRect(in: CGRect(x: w * 0.3, y: h * 0.5, width: w * 0.4, height: h * 0.25), cornerSize: CGSize(width: 4, height: 4))
        
        // Straps
        path.move(to: CGPoint(x: w * 0.3, y: h * 0.2))
        path.addLine(to: CGPoint(x: w * 0.2, y: h * 0.1))
        path.move(to: CGPoint(x: w * 0.7, y: h * 0.2))
        path.addLine(to: CGPoint(x: w * 0.8, y: h * 0.1))
        
        return path
    }
}

// MARK: - Misc Icons

struct RulerIconShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        
        // Ruler body
        path.addRoundedRect(in: CGRect(x: w * 0.1, y: h * 0.3, width: w * 0.8, height: h * 0.4), cornerSize: CGSize(width: 2, height: 2))
        
        // Measurement marks
        for i in 0..<8 {
            let x = w * 0.15 + CGFloat(i) * w * 0.1
            let markHeight = i % 2 == 0 ? h * 0.15 : h * 0.1
            path.move(to: CGPoint(x: x, y: h * 0.3))
            path.addLine(to: CGPoint(x: x, y: h * 0.3 + markHeight))
        }
        
        return path
    }
}

struct ThermometerIconShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        
        // Bulb at bottom
        path.addEllipse(in: CGRect(x: w * 0.3, y: h * 0.65, width: w * 0.4, height: h * 0.3))
        
        // Tube
        path.addRoundedRect(in: CGRect(x: w * 0.4, y: h * 0.1, width: w * 0.2, height: h * 0.6), cornerSize: CGSize(width: w * 0.1, height: w * 0.1))
        
        // Mercury level
        path.addRect(CGRect(x: w * 0.43, y: h * 0.35, width: w * 0.14, height: h * 0.4))
        
        // Marks
        for i in 0..<4 {
            let y = h * 0.2 + CGFloat(i) * h * 0.12
            path.move(to: CGPoint(x: w * 0.6, y: y))
            path.addLine(to: CGPoint(x: w * 0.7, y: y))
        }
        
        return path
    }
}

struct WarningIconShape: Shape {
    func path(in rect: CGRect) -> Path {
        StatusWarningShape().path(in: rect)
    }
}

struct InfoIconShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        
        // Circle
        path.addEllipse(in: rect.insetBy(dx: w * 0.1, dy: h * 0.1))
        
        // i dot
        path.addEllipse(in: CGRect(x: w * 0.43, y: h * 0.25, width: w * 0.14, height: h * 0.12))
        
        // i body
        path.addRoundedRect(in: CGRect(x: w * 0.43, y: h * 0.42, width: w * 0.14, height: h * 0.33), cornerSize: CGSize(width: 2, height: 2))
        
        return path
    }
}

struct PlusIconShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        
        // Horizontal
        path.move(to: CGPoint(x: w * 0.2, y: h * 0.5))
        path.addLine(to: CGPoint(x: w * 0.8, y: h * 0.5))
        
        // Vertical
        path.move(to: CGPoint(x: w * 0.5, y: h * 0.2))
        path.addLine(to: CGPoint(x: w * 0.5, y: h * 0.8))
        
        return path
    }
}

struct CheckIconShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height
        
        path.move(to: CGPoint(x: w * 0.2, y: h * 0.5))
        path.addLine(to: CGPoint(x: w * 0.4, y: h * 0.75))
        path.addLine(to: CGPoint(x: w * 0.8, y: h * 0.25))
        
        return path
    }
}

#Preview {
    ScrollView {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))], spacing: 20) {
            ForEach([
                AppIcon.calculator, .reference, .safety, .log, .formation,
                .statusSafe, .statusWarning, .statusDanger,
                .iceClear, .iceWhite, .iceGrey,
                .person, .snowmobile, .shelter, .auger, .gear,
                .ruler, .thermometer, .warning, .info, .plus, .check
            ], id: \.rawValue) { icon in
                VStack {
                    IconView(icon: icon, size: 40, colour: AppTheme.primary)
                    Text(icon.rawValue.replacingOccurrences(of: "_", with: "\n"))
                        .font(.caption2)
                        .foregroundColor(AppTheme.textSecondary)
                        .multilineTextAlignment(.center)
                }
            }
        }
        .padding()
    }
    .background(AppTheme.background)
}
