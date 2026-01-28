import SwiftUI

struct IceFormationView: View {
    @State private var temperature: Double = -10
    @State private var hasSnowCover = false
    @State private var targetThickness: Double = 10
    @State private var useCelsius = true
    
    var calculatedThickness: Double {
        IceCalculations.calculateIceGrowth(averageTemp: temperature, days: 1, hasSnowCover: hasSnowCover)
    }
    
    var daysToTarget: Int {
        IceCalculations.daysToReachThickness(targetCm: targetThickness, averageTemp: temperature, hasSnowCover: hasSnowCover)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: AppTheme.paddingLarge) {
                // Header
                header
                
                // Temperature input
                CardView {
                    VStack(alignment: .leading, spacing: AppTheme.paddingMedium) {
                        HStack {
                            sectionHeader("Average Temperature", icon: .thermometer)
                            Spacer()
                            unitToggle
                        }
                        
                        CustomSlider(
                            value: $temperature,
                            range: -40...5,
                            step: 1,
                            activeTrackColour: temperatureColor
                        )
                        
                        Text(UnitConverter.formatTemperature(temperature, useFahrenheit: !useCelsius))
                            .font(.system(size: 48, weight: .bold))
                            .foregroundColor(temperatureColor)
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        if temperature >= 0 {
                            HStack {
                                IconView(icon: .warning, size: 16, colour: AppTheme.warning)
                                    .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                                Text("Ice does not form above freezing point")
                                    .font(.caption)
                                    .foregroundColor(AppTheme.warning)
                            }
                        }
                    }
                }
                
                // Snow cover toggle
                CardView {
                    Button(action: { hasSnowCover.toggle() }) {
                        HStack {
                            IconView(icon: .formation, size: 24, colour: hasSnowCover ? AppTheme.primary : AppTheme.textMuted)
                                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Snow Cover")
                                    .font(.headline)
                                    .foregroundColor(AppTheme.textPrimary)
                                Text("Snow slows ice formation by ~35%")
                                    .font(.caption)
                                    .foregroundColor(AppTheme.textMuted)
                            }
                            
                            Spacer()
                            
                            RoundedRectangle(cornerRadius: 16)
                                .fill(hasSnowCover ? AppTheme.primary : AppTheme.cardBackgroundLight)
                                .frame(width: 50, height: 28)
                                .overlay(
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 24, height: 24)
                                        .offset(x: hasSnowCover ? 10 : -10)
                                        .animation(.easeInOut(duration: 0.2), value: hasSnowCover)
                                )
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                // Daily growth
                CardView {
                    VStack(spacing: AppTheme.paddingMedium) {
                        sectionHeader("Daily Ice Growth", icon: .ruler)
                        
                        if temperature < 0 {
                            HStack(alignment: .lastTextBaseline, spacing: 4) {
                                Text(String(format: "%.1f", calculatedThickness))
                                    .font(.system(size: 56, weight: .bold))
                                    .foregroundColor(AppTheme.primary)
                                Text("cm/day")
                                    .font(.headline)
                                    .foregroundColor(AppTheme.textSecondary)
                            }
                            
                            Text("Under ideal conditions")
                                .font(.caption)
                                .foregroundColor(AppTheme.textMuted)
                        } else {
                            Text("No growth")
                                .font(.system(size: 36, weight: .bold))
                                .foregroundColor(AppTheme.danger)
                            Text("Temperature must be below freezing")
                                .font(.caption)
                                .foregroundColor(AppTheme.textMuted)
                        }
                    }
                }
                
                // Target thickness calculator
                CardView {
                    VStack(alignment: .leading, spacing: AppTheme.paddingMedium) {
                        sectionHeader("Days to Safe Ice", icon: .calculator)
                        
                        Text("Target thickness")
                            .font(.subheadline)
                            .foregroundColor(AppTheme.textSecondary)
                        
                        CustomSlider(
                            value: $targetThickness,
                            range: 5...40,
                            step: 1,
                            activeTrackColour: AppTheme.safe
                        )
                        
                        HStack {
                            Text(String(format: "%.0f cm", targetThickness))
                                .font(.headline)
                                .foregroundColor(AppTheme.textPrimary)
                            
                            Spacer()
                            
                            if temperature < 0 {
                                HStack(alignment: .lastTextBaseline, spacing: 4) {
                                    Text("\(daysToTarget)")
                                        .font(.system(size: 32, weight: .bold))
                                        .foregroundColor(AppTheme.safe)
                                    Text("days")
                                        .font(.headline)
                                        .foregroundColor(AppTheme.textSecondary)
                                }
                            } else {
                                Text("N/A")
                                    .font(.headline)
                                    .foregroundColor(AppTheme.danger)
                            }
                        }
                    }
                }
                
                // Formation factors
                CardView {
                    VStack(alignment: .leading, spacing: AppTheme.paddingMedium) {
                        sectionHeader("Factors Affecting Ice Growth", icon: .info)
                        
                        factorRow(title: "Temperature", description: "Colder temperatures accelerate ice formation. Each 5°C below freezing roughly doubles the rate.", positive: true)
                        
                        factorRow(title: "Snow Cover", description: "Acts as insulation, slowing heat transfer and reducing ice growth by about 35%.", positive: false)
                        
                        factorRow(title: "Wind", description: "Increases heat transfer from water, potentially speeding up initial freezing.", positive: true)
                        
                        factorRow(title: "Water Current", description: "Moving water prevents proper ice formation and creates thin spots.", positive: false)
                        
                        factorRow(title: "Water Depth", description: "Shallow water freezes more completely; deep water retains heat longer.", positive: false)
                    }
                }
                
                // Formula explanation
                CardView {
                    VStack(alignment: .leading, spacing: AppTheme.paddingSmall) {
                        sectionHeader("How It Works", icon: .info)
                        
                        Text("This calculator uses Stefan's Law for ice growth:")
                            .font(.subheadline)
                            .foregroundColor(AppTheme.textSecondary)
                        
                        Text("H = α × √(FDD)")
                            .font(.system(.body, design: .monospaced))
                            .foregroundColor(AppTheme.primary)
                            .padding(.vertical, AppTheme.paddingSmall)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("H = ice thickness (cm)")
                                .font(.caption)
                                .foregroundColor(AppTheme.textMuted)
                            Text("α = coefficient (2.7 clear, 1.8 with snow)")
                                .font(.caption)
                                .foregroundColor(AppTheme.textMuted)
                            Text("FDD = freezing degree days")
                                .font(.caption)
                                .foregroundColor(AppTheme.textMuted)
                        }
                        
                        Text("This is an estimate. Always verify actual ice thickness before venturing onto ice.")
                            .font(.caption)
                            .foregroundColor(AppTheme.warning)
                            .padding(.top, AppTheme.paddingSmall)
                    }
                }
                
                Spacer(minLength: 100)
            }
            .padding(.horizontal, AppTheme.paddingMedium)
        }
        .background(AppTheme.background.ignoresSafeArea())
    }
    
    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Ice")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(AppTheme.textPrimary)
                Text("Formation")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(AppTheme.primary)
            }
            Spacer()
            IconView(icon: .formation, size: 40, colour: AppTheme.primary)
                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
        }
        .padding(.top, AppTheme.paddingMedium)
    }
    
    private var unitToggle: some View {
        HStack(spacing: 4) {
            Button(action: { useCelsius = true }) {
                Text("°C")
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(useCelsius ? .white : AppTheme.textSecondary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(useCelsius ? AppTheme.primary : AppTheme.cardBackgroundLight)
                    .cornerRadius(AppTheme.cornerRadiusSmall)
            }
            Button(action: { useCelsius = false }) {
                Text("°F")
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(!useCelsius ? .white : AppTheme.textSecondary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(!useCelsius ? AppTheme.primary : AppTheme.cardBackgroundLight)
                    .cornerRadius(AppTheme.cornerRadiusSmall)
            }
        }
    }
    
    private var temperatureColor: Color {
        if temperature >= 0 {
            return AppTheme.danger
        } else if temperature > -10 {
            return AppTheme.warning
        } else {
            return AppTheme.primary
        }
    }
    
    private func sectionHeader(_ title: String, icon: AppIcon) -> some View {
        HStack(spacing: 10) {
            IconView(icon: icon, size: 20, colour: AppTheme.primary)
                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            Text(title)
                .font(.headline)
                .foregroundColor(AppTheme.textPrimary)
        }
    }
    
    private func factorRow(title: String, description: String, positive: Bool) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Circle()
                .fill(positive ? AppTheme.safe : AppTheme.danger)
                .frame(width: 8, height: 8)
                .offset(y: 6)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(AppTheme.textPrimary)
                Text(description)
                    .font(.caption)
                    .foregroundColor(AppTheme.textSecondary)
            }
        }
    }
}

#Preview {
    IceFormationView()
}
