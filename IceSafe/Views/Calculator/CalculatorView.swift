import SwiftUI

struct CalculatorView: View {
    @StateObject private var viewModel = CalculatorViewModel()
    @State private var thicknessText = "10"
    
    var body: some View {
        ScrollView {
            VStack(spacing: AppTheme.paddingLarge) {
                // Header
                header
                
                // Safety Result
                CardView {
                    SafetyIndicator(result: viewModel.safetyResult)
                }
                
                // Ice Thickness Input
                CardView {
                    VStack(alignment: .leading, spacing: AppTheme.paddingMedium) {
                        sectionHeader("Ice Thickness", icon: .ruler)
                        
                        // Unit toggle
                        HStack {
                            unitButton("cm", isSelected: viewModel.useMetric) {
                                viewModel.useMetric = true
                            }
                            unitButton("inches", isSelected: !viewModel.useMetric) {
                                viewModel.useMetric = false
                            }
                        }
                        .onChange(of: viewModel.useMetric) { _ in
                            // Update text field when unit changes
                            let displayValue = viewModel.useMetric ? viewModel.iceThickness : UnitConverter.cmToInches(viewModel.iceThickness)
                            thicknessText = String(format: "%.1f", displayValue)
                        }
                        
                        // Slider
                        CustomSlider(
                            value: $viewModel.iceThickness,
                            range: 0...50,
                            step: 0.5,
                            activeTrackColour: viewModel.safetyResult.level.colour
                        )
                        
                        // Manual input
                        HStack {
                            TextField("", text: $thicknessText)
                                .keyboardType(.decimalPad)
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(AppTheme.textPrimary)
                                .multilineTextAlignment(.center)
                                .frame(width: 100)
                                .onChange(of: thicknessText) { newValue in
                                    if let value = Double(newValue.replacingOccurrences(of: ",", with: ".")) {
                                        let cmValue = viewModel.useMetric ? value : UnitConverter.inchesToCm(value)
                                        viewModel.iceThickness = min(max(cmValue, 0), 50)
                                    }
                                }
                                .onChange(of: viewModel.iceThickness) { newValue in
                                    let displayValue = viewModel.useMetric ? newValue : UnitConverter.cmToInches(newValue)
                                    thicknessText = String(format: "%.1f", displayValue)
                                }
                            
                            Text(viewModel.useMetric ? "cm" : "in")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(AppTheme.textSecondary)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                
                // Ice Type Selection
                CardView {
                    VStack(alignment: .leading, spacing: AppTheme.paddingMedium) {
                        sectionHeader("Ice Type", icon: .iceClear)
                        
                        ForEach(IceType.allCases) { iceType in
                            iceTypeRow(iceType)
                        }
                    }
                }
                
                // People Count
                CardView {
                    VStack(alignment: .leading, spacing: AppTheme.paddingMedium) {
                        sectionHeader("Number of People", icon: .person)
                        
                        HStack {
                            Button(action: {
                                if viewModel.peopleCount > 1 {
                                    viewModel.peopleCount -= 1
                                }
                            }) {
                                Circle()
                                    .fill(AppTheme.cardBackgroundLight)
                                    .frame(width: 44, height: 44)
                                    .overlay(
                                        Text("-")
                                            .font(.system(size: 24, weight: .bold))
                                            .foregroundColor(AppTheme.textPrimary)
                                    )
                            }
                            
                            Spacer()
                            
                            Text("\(viewModel.peopleCount)")
                                .font(.system(size: 48, weight: .bold))
                                .foregroundColor(AppTheme.primary)
                            
                            Spacer()
                            
                            Button(action: {
                                if viewModel.peopleCount < 20 {
                                    viewModel.peopleCount += 1
                                }
                            }) {
                                Circle()
                                    .fill(AppTheme.primary)
                                    .frame(width: 44, height: 44)
                                    .overlay(
                                        Text("+")
                                            .font(.system(size: 24, weight: .bold))
                                            .foregroundColor(.white)
                                    )
                            }
                        }
                        .padding(.horizontal, AppTheme.paddingLarge)
                    }
                }
                
                // Equipment
                CardView {
                    VStack(alignment: .leading, spacing: AppTheme.paddingMedium) {
                        sectionHeader("Additional Equipment", icon: .gear)
                        
                        ForEach(Array(viewModel.equipment.enumerated()), id: \.element.id) { index, equipment in
                            equipmentRow(equipment, index: index)
                        }
                        
                        if viewModel.totalEquipmentWeight > 0 {
                            HStack {
                                Text("Total Equipment Weight:")
                                    .font(.subheadline)
                                    .foregroundColor(AppTheme.textSecondary)
                                Spacer()
                                Text(UnitConverter.formatWeight(viewModel.totalEquipmentWeight, useLbs: !viewModel.useMetric))
                                    .font(.headline)
                                    .foregroundColor(AppTheme.primary)
                            }
                            .padding(.top, AppTheme.paddingSmall)
                        }
                    }
                }
                
                // Recommendations
                if !viewModel.safetyResult.warnings.isEmpty || !viewModel.safetyResult.recommendations.isEmpty {
                    CardView {
                        VStack(alignment: .leading, spacing: AppTheme.paddingMedium) {
                            if !viewModel.safetyResult.warnings.isEmpty {
                                sectionHeader("Warnings", icon: .warning)
                                ForEach(viewModel.safetyResult.warnings, id: \.self) { warning in
                                    HStack(alignment: .top, spacing: 12) {
                                        Circle()
                                            .fill(AppTheme.danger)
                                            .frame(width: 8, height: 8)
                                            .offset(y: 6)
                                        Text(warning)
                                            .font(.subheadline)
                                            .foregroundColor(AppTheme.danger)
                                    }
                                }
                            }
                            
                            if !viewModel.safetyResult.recommendations.isEmpty {
                                sectionHeader("Recommendations", icon: .info)
                                ForEach(viewModel.safetyResult.recommendations, id: \.self) { rec in
                                    HStack(alignment: .top, spacing: 12) {
                                        Circle()
                                            .fill(AppTheme.textMuted)
                                            .frame(width: 8, height: 8)
                                            .offset(y: 6)
                                        Text(rec)
                                            .font(.subheadline)
                                            .foregroundColor(AppTheme.textSecondary)
                                    }
                                }
                            }
                        }
                    }
                }
                
                // Load info
                CardView {
                    VStack(spacing: AppTheme.paddingSmall) {
                        HStack {
                            Text("Recommended minimum thickness:")
                                .font(.subheadline)
                                .foregroundColor(AppTheme.textSecondary)
                            Spacer()
                            Text(UnitConverter.formatThickness(viewModel.safetyResult.recommendedThickness, useInches: !viewModel.useMetric))
                                .font(.headline)
                                .foregroundColor(AppTheme.textPrimary)
                        }
                        Divider().background(AppTheme.cardBackgroundLight)
                        HStack {
                            Text("Maximum safe load at current thickness:")
                                .font(.subheadline)
                                .foregroundColor(AppTheme.textSecondary)
                            Spacer()
                            Text(UnitConverter.formatWeight(viewModel.safetyResult.maxLoad, useLbs: !viewModel.useMetric))
                                .font(.headline)
                                .foregroundColor(AppTheme.textPrimary)
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
                Text("Ice Safety")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(AppTheme.textPrimary)
                Text("Calculator")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(AppTheme.primary)
            }
            Spacer()
            IconView(icon: .formation, size: 40, colour: AppTheme.primary)
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
    
    private func unitButton(_ label: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(label)
                .font(.subheadline.weight(.medium))
                .foregroundColor(isSelected ? .white : AppTheme.textSecondary)
                .padding(.horizontal, AppTheme.paddingMedium)
                .padding(.vertical, AppTheme.paddingSmall)
                .background(isSelected ? AppTheme.primary : AppTheme.cardBackgroundLight)
                .cornerRadius(AppTheme.cornerRadiusSmall)
        }
    }
    
    private func iceTypeRow(_ iceType: IceType) -> some View {
        Button(action: {
            viewModel.selectedIceType = iceType
        }) {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: AppTheme.cornerRadiusSmall)
                        .fill(viewModel.selectedIceType == iceType ? AppTheme.primary.opacity(0.2) : AppTheme.cardBackgroundLight)
                        .frame(width: 44, height: 44)
                    
                    IconView(
                        icon: iconForIceType(iceType),
                        size: 24,
                        colour: viewModel.selectedIceType == iceType ? AppTheme.primary : AppTheme.textSecondary
                    )
                    .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(iceType.displayName)
                        .font(.subheadline.weight(.medium))
                        .foregroundColor(viewModel.selectedIceType == iceType ? AppTheme.textPrimary : AppTheme.textSecondary)
                    Text(iceType.description)
                        .font(.caption)
                        .foregroundColor(AppTheme.textMuted)
                        .lineLimit(2)
                }
                
                Spacer()
                
                if viewModel.selectedIceType == iceType {
                    Circle()
                        .fill(AppTheme.primary)
                        .frame(width: 20, height: 20)
                        .overlay(
                            IconView(icon: .check, size: 12, colour: .white)
                                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                        )
                } else {
                    Circle()
                        .stroke(AppTheme.textMuted, lineWidth: 2)
                        .frame(width: 20, height: 20)
                }
            }
            .padding(AppTheme.paddingSmall)
            .background(
                RoundedRectangle(cornerRadius: AppTheme.cornerRadiusSmall)
                    .stroke(viewModel.selectedIceType == iceType ? AppTheme.primary : Color.clear, lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func iconForIceType(_ type: IceType) -> AppIcon {
        switch type {
        case .clear: return .iceClear
        case .white: return .iceWhite
        case .grey: return .iceGrey
        }
    }
    
    private func equipmentRow(_ equipment: Equipment, index: Int) -> some View {
        Button(action: {
            viewModel.toggleEquipment(at: index)
        }) {
            HStack(spacing: 12) {
                ZStack {
                    RoundedRectangle(cornerRadius: AppTheme.cornerRadiusSmall)
                        .fill(equipment.isSelected ? AppTheme.primary.opacity(0.2) : AppTheme.cardBackgroundLight)
                        .frame(width: 44, height: 44)
                    
                    IconView(
                        icon: iconForEquipment(equipment.iconName),
                        size: 24,
                        colour: equipment.isSelected ? AppTheme.primary : AppTheme.textSecondary
                    )
                    .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(equipment.name)
                        .font(.subheadline.weight(.medium))
                        .foregroundColor(equipment.isSelected ? AppTheme.textPrimary : AppTheme.textSecondary)
                    Text(UnitConverter.formatWeight(equipment.weight, useLbs: !viewModel.useMetric))
                        .font(.caption)
                        .foregroundColor(AppTheme.textMuted)
                }
                
                Spacer()
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(equipment.isSelected ? AppTheme.primary : AppTheme.cardBackgroundLight)
                    .frame(width: 24, height: 24)
                    .overlay(
                        equipment.isSelected ?
                        IconView(icon: .check, size: 14, colour: .white)
                            .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                        : nil
                    )
            }
            .padding(AppTheme.paddingSmall)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func iconForEquipment(_ iconName: String) -> AppIcon {
        switch iconName {
        case "equipment_snowmobile": return .snowmobile
        case "equipment_shelter": return .shelter
        case "equipment_auger": return .auger
        case "equipment_gear": return .gear
        default: return .gear
        }
    }
}

#Preview {
    CalculatorView()
}
