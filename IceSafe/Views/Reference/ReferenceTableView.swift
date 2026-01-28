import SwiftUI

struct ReferenceTableView: View {
    @State private var expandedRiskFactor: String?
    
    private let thicknessData: [(thickness: String, thicknessCm: String, activity: String, icon: AppIcon)] = [
        ("2\"", "5 cm", "One person walking", .person),
        ("3\"", "7.5 cm", "Group walking in single file", .person),
        ("4\"", "10 cm", "Ice fishing with light gear", .auger),
        ("5-6\"", "12-15 cm", "Snowmobile or ATV", .snowmobile),
        ("8-10\"", "20-25 cm", "Small car or light vehicle", .gear),
        ("12-15\"", "30-38 cm", "Medium truck or SUV", .shelter)
    ]
    
    private let riskFactors: [(title: String, description: String)] = [
        ("Moving Water", "Currents beneath the ice weaken its structure. Areas near inlets, outlets, or springs are particularly dangerous."),
        ("Snow Coverage", "Snow insulates ice and slows freezing. It can also hide cracks and thin spots. Ice under snow is typically weaker."),
        ("Air Bubbles", "Trapped air reduces ice density and strength. White or opaque ice contains many bubbles and is roughly 50% weaker than clear ice."),
        ("Cracks & Pressure", "Large cracks indicate stress. Pressure ridges form when ice sheets collide. Both weaken overall structure."),
        ("Temperature Changes", "Rapid warming can cause ice to deteriorate quickly. Even short warm spells significantly weaken ice that took days to form."),
        ("Early & Late Season", "Beginning and end of winter are most dangerous. Ice may look solid but lack consistent thickness or structural integrity."),
        ("Vehicle Traffic", "Repeated travel over the same path weakens ice. Vary routes and avoid parking in one spot for long periods."),
        ("Water Level Changes", "Rising or falling water levels create air gaps under ice, removing support and causing collapse.")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: AppTheme.paddingLarge) {
                // Header
                header
                
                // Thickness Table
                CardView {
                    VStack(alignment: .leading, spacing: AppTheme.paddingMedium) {
                        sectionHeader("Recommended Ice Thickness", icon: .ruler)
                        
                        Text("For clear blue ice (strongest type)")
                            .font(.caption)
                            .foregroundColor(AppTheme.textMuted)
                            .padding(.bottom, AppTheme.paddingSmall)
                        
                        // Table header
                        HStack {
                            Text("Thickness")
                                .font(.caption.weight(.medium))
                                .foregroundColor(AppTheme.textMuted)
                                .frame(width: 80, alignment: .leading)
                            
                            Spacer()
                            
                            Text("Safe Activity")
                                .font(.caption.weight(.medium))
                                .foregroundColor(AppTheme.textMuted)
                        }
                        .padding(.horizontal, AppTheme.paddingSmall)
                        
                        Divider().background(AppTheme.cardBackgroundLight)
                        
                        // Table rows
                        ForEach(Array(thicknessData.enumerated()), id: \.offset) { index, data in
                            thicknessRow(data, isLast: index == thicknessData.count - 1)
                        }
                    }
                }
                
                // Important note
                CardView {
                    HStack(alignment: .top, spacing: 12) {
                        IconView(icon: .warning, size: 24, colour: AppTheme.warning)
                            .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Important")
                                .font(.headline)
                                .foregroundColor(AppTheme.warning)
                            Text("These guidelines are for clear blue ice only. White or grey ice is significantly weaker and requires greater thickness for the same activities.")
                                .font(.subheadline)
                                .foregroundColor(AppTheme.textSecondary)
                        }
                    }
                }
                
                // Risk Factors
                CardView {
                    VStack(alignment: .leading, spacing: AppTheme.paddingMedium) {
                        sectionHeader("Risk Factors", icon: .warning)
                        
                        Text("Conditions that weaken ice")
                            .font(.caption)
                            .foregroundColor(AppTheme.textMuted)
                            .padding(.bottom, AppTheme.paddingSmall)
                        
                        ForEach(riskFactors, id: \.title) { factor in
                            riskFactorRow(factor)
                        }
                    }
                }
                
                // Quick tips
                CardView {
                    VStack(alignment: .leading, spacing: AppTheme.paddingMedium) {
                        sectionHeader("Quick Safety Tips", icon: .statusSafe)
                        
                        ForEach([
                            "Never go on ice alone",
                            "Tell someone your plans and expected return",
                            "Carry ice picks and a throw rope",
                            "Wear a flotation device when possible",
                            "Check ice thickness every 50 metres",
                            "Avoid ice near structures and shorelines"
                        ], id: \.self) { tip in
                            HStack(alignment: .top, spacing: 12) {
                                IconView(icon: .check, size: 16, colour: AppTheme.safe)
                                    .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                                Text(tip)
                                    .font(.subheadline)
                                    .foregroundColor(AppTheme.textSecondary)
                            }
                        }
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
                Text("Reference")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(AppTheme.textPrimary)
                Text("Table")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(AppTheme.primary)
            }
            Spacer()
            IconView(icon: .reference, size: 40, colour: AppTheme.primary)
                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
        }
        .padding(.top, AppTheme.paddingMedium)
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
    
    private func thicknessRow(_ data: (thickness: String, thicknessCm: String, activity: String, icon: AppIcon), isLast: Bool) -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(data.thickness)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(AppTheme.primary)
                    Text(data.thicknessCm)
                        .font(.caption)
                        .foregroundColor(AppTheme.textMuted)
                }
                .frame(width: 70, alignment: .leading)
                
                Spacer()
                
                HStack(spacing: 8) {
                    Text(data.activity)
                        .font(.subheadline)
                        .foregroundColor(AppTheme.textSecondary)
                    
                    IconView(icon: data.icon, size: 20, colour: AppTheme.textMuted)
                        .stroke(style: StrokeStyle(lineWidth: 1.5, lineCap: .round, lineJoin: .round))
                }
            }
            .padding(.vertical, AppTheme.paddingSmall)
            .padding(.horizontal, AppTheme.paddingSmall)
            
            if !isLast {
                Divider().background(AppTheme.cardBackgroundLight)
            }
        }
    }
    
    private func riskFactorRow(_ factor: (title: String, description: String)) -> some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.2)) {
                if expandedRiskFactor == factor.title {
                    expandedRiskFactor = nil
                } else {
                    expandedRiskFactor = factor.title
                }
            }
        }) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Circle()
                        .fill(AppTheme.danger.opacity(0.2))
                        .frame(width: 8, height: 8)
                    
                    Text(factor.title)
                        .font(.subheadline.weight(.medium))
                        .foregroundColor(AppTheme.textPrimary)
                    
                    Spacer()
                    
                    Image(systemName: expandedRiskFactor == factor.title ? "chevron.up" : "chevron.down")
                        .font(.caption)
                        .foregroundColor(AppTheme.textMuted)
                }
                
                if expandedRiskFactor == factor.title {
                    Text(factor.description)
                        .font(.caption)
                        .foregroundColor(AppTheme.textSecondary)
                        .padding(.leading, 16)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
            .padding(AppTheme.paddingSmall)
            .background(AppTheme.cardBackgroundLight.opacity(0.5))
            .cornerRadius(AppTheme.cornerRadiusSmall)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ReferenceTableView()
}
