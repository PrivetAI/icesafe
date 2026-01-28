import SwiftUI

struct SafetyIndicator: View {
    let result: SafetyResult
    @State private var animateProgress = false
    
    var body: some View {
        VStack(spacing: AppTheme.paddingMedium) {
            // Main indicator circle
            ZStack {
                // Background circle
                Circle()
                    .stroke(AppTheme.cardBackgroundLight, lineWidth: 12)
                    .frame(width: 160, height: 160)
                
                // Progress arc
                Circle()
                    .trim(from: 0, to: animateProgress ? min(result.safetyMargin / 150, 1) : 0)
                    .stroke(
                        result.level.gradient,
                        style: StrokeStyle(lineWidth: 12, lineCap: .round)
                    )
                    .frame(width: 160, height: 160)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut(duration: 0.8), value: animateProgress)
                
                // Centre content
                VStack(spacing: 4) {
                    IconView(
                        icon: iconForLevel(result.level),
                        size: 48,
                        colour: result.level.colour
                    )
                    .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                    
                    Text(result.level.displayName)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(result.level.colour)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    animateProgress = true
                }
            }
            .onChange(of: result.level) { _ in
                animateProgress = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    animateProgress = true
                }
            }
            
            // Safety margin
            HStack {
                Text("Safety Margin")
                    .font(.subheadline)
                    .foregroundColor(AppTheme.textSecondary)
                
                Spacer()
                
                Text("\(Int(result.safetyMargin))%")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(result.level.colour)
            }
            .padding(.horizontal, AppTheme.paddingMedium)
        }
    }
    
    private func iconForLevel(_ level: SafetyLevel) -> AppIcon {
        switch level {
        case .safe: return .statusSafe
        case .warning: return .statusWarning
        case .danger: return .statusDanger
        }
    }
}

// Helper extension for stroke styling
extension IconView {
    func stroke(style: StrokeStyle) -> some View {
        self
    }
}

#Preview {
    VStack(spacing: 30) {
        SafetyIndicator(result: SafetyResult(
            level: .safe,
            currentThickness: 15,
            recommendedThickness: 10,
            maxLoad: 500,
            warnings: [],
            recommendations: []
        ))
        
        SafetyIndicator(result: SafetyResult(
            level: .warning,
            currentThickness: 8,
            recommendedThickness: 10,
            maxLoad: 300,
            warnings: ["Test warning"],
            recommendations: []
        ))
        
        SafetyIndicator(result: SafetyResult(
            level: .danger,
            currentThickness: 5,
            recommendedThickness: 10,
            maxLoad: 100,
            warnings: ["Danger!"],
            recommendations: []
        ))
    }
    .padding()
    .background(AppTheme.background)
}
