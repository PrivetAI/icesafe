import SwiftUI

struct MeasurementLogView: View {
    @StateObject private var viewModel = MeasurementLogViewModel()
    @State private var showingAddSheet = false
    @State private var editingRecord: MeasurementRecord?
    
    var body: some View {
        ScrollView {
            VStack(spacing: AppTheme.paddingLarge) {
                // Header
                header
                
                // Add button
                Button(action: { showingAddSheet = true }) {
                    HStack {
                        IconView(icon: .plus, size: 20, colour: .white)
                            .stroke(style: StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                        Text("Add New Measurement")
                            .font(.headline)
                    }
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, AppTheme.paddingMedium)
                    .background(AppTheme.iceGradient)
                    .cornerRadius(AppTheme.cornerRadiusMedium)
                }
                
                // Records list
                if viewModel.records.isEmpty {
                    emptyState
                } else {
                    LazyVStack(spacing: AppTheme.paddingMedium) {
                        ForEach(viewModel.records) { record in
                            recordCard(record)
                        }
                    }
                }
                
                Spacer(minLength: 100)
            }
            .padding(.horizontal, AppTheme.paddingMedium)
        }
        .background(AppTheme.background.ignoresSafeArea())
        .sheet(isPresented: $showingAddSheet) {
            AddMeasurementSheet(viewModel: viewModel)
        }
        .sheet(item: $editingRecord) { record in
            EditMeasurementSheet(viewModel: viewModel, record: record)
        }
    }
    
    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Measurement")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(AppTheme.textPrimary)
                Text("Log")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(AppTheme.primary)
            }
            Spacer()
            IconView(icon: .log, size: 40, colour: AppTheme.primary)
                .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
        }
        .padding(.top, AppTheme.paddingMedium)
    }
    
    private var emptyState: some View {
        CardView {
            VStack(spacing: AppTheme.paddingMedium) {
                IconView(icon: .log, size: 60, colour: AppTheme.textMuted)
                    .stroke(style: StrokeStyle(lineWidth: 1.5, lineCap: .round, lineJoin: .round))
                
                Text("No Measurements Yet")
                    .font(.headline)
                    .foregroundColor(AppTheme.textSecondary)
                
                Text("Start logging your ice thickness measurements to track conditions over time.")
                    .font(.subheadline)
                    .foregroundColor(AppTheme.textMuted)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, AppTheme.paddingLarge)
        }
    }
    
    private func recordCard(_ record: MeasurementRecord) -> some View {
        CardView {
            VStack(alignment: .leading, spacing: AppTheme.paddingSmall) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(record.locationName.isEmpty ? "Unknown Location" : record.locationName)
                            .font(.headline)
                            .foregroundColor(AppTheme.textPrimary)
                        Text(record.formattedDate)
                            .font(.caption)
                            .foregroundColor(AppTheme.textMuted)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 2) {
                        Text(String(format: "%.1f cm", record.thickness))
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(thicknessColor(record.thickness))
                        Text(String(format: "%.1f\"", UnitConverter.cmToInches(record.thickness)))
                            .font(.caption)
                            .foregroundColor(AppTheme.textMuted)
                    }
                }
                
                HStack(spacing: 8) {
                    iceTypeTag(record.iceType)
                    
                    Spacer()
                    
                    Button(action: { editingRecord = record }) {
                        Text("Edit")
                            .font(.caption.weight(.medium))
                            .foregroundColor(AppTheme.primary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(AppTheme.primary.opacity(0.2))
                            .cornerRadius(AppTheme.cornerRadiusSmall)
                    }
                    
                    Button(action: { viewModel.deleteRecord(record) }) {
                        Text("Delete")
                            .font(.caption.weight(.medium))
                            .foregroundColor(AppTheme.danger)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(AppTheme.danger.opacity(0.2))
                            .cornerRadius(AppTheme.cornerRadiusSmall)
                    }
                }
                
                if !record.notes.isEmpty {
                    Text(record.notes)
                        .font(.caption)
                        .foregroundColor(AppTheme.textSecondary)
                        .padding(.top, 4)
                }
            }
        }
    }
    
    private func thicknessColor(_ thickness: Double) -> Color {
        if thickness < 5 {
            return AppTheme.danger
        } else if thickness < 10 {
            return AppTheme.warning
        } else {
            return AppTheme.safe
        }
    }
    
    private func iceTypeTag(_ iceType: String) -> some View {
        let type = IceType(rawValue: iceType) ?? .clear
        return HStack(spacing: 4) {
            Circle()
                .fill(iceTypeColor(type))
                .frame(width: 8, height: 8)
            Text(type.displayName)
                .font(.caption)
                .foregroundColor(AppTheme.textSecondary)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(AppTheme.cardBackgroundLight)
        .cornerRadius(AppTheme.cornerRadiusSmall)
    }
    
    private func iceTypeColor(_ type: IceType) -> Color {
        switch type {
        case .clear: return AppTheme.primary
        case .white: return AppTheme.textSecondary
        case .grey: return AppTheme.danger
        }
    }
}

struct AddMeasurementSheet: View {
    @ObservedObject var viewModel: MeasurementLogViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var locationName = ""
    @State private var thickness: Double = 10
    @State private var iceType: IceType = .clear
    @State private var notes = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.background.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: AppTheme.paddingLarge) {
                        CardView {
                            VStack(alignment: .leading, spacing: AppTheme.paddingMedium) {
                                Text("Location")
                                    .font(.headline)
                                    .foregroundColor(AppTheme.textPrimary)
                                
                                TextField("Enter location name", text: $locationName)
                                    .font(.body)
                                    .foregroundColor(AppTheme.textPrimary)
                                    .padding()
                                    .background(AppTheme.cardBackgroundLight)
                                    .cornerRadius(AppTheme.cornerRadiusSmall)
                            }
                        }
                        
                        CardView {
                            VStack(alignment: .leading, spacing: AppTheme.paddingMedium) {
                                Text("Ice Thickness (cm)")
                                    .font(.headline)
                                    .foregroundColor(AppTheme.textPrimary)
                                
                                CustomSlider(value: $thickness, range: 0...50, step: 0.5)
                                
                                Text(String(format: "%.1f cm (%.1f\")", thickness, UnitConverter.cmToInches(thickness)))
                                    .font(.title2.weight(.bold))
                                    .foregroundColor(AppTheme.primary)
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                        }
                        
                        CardView {
                            VStack(alignment: .leading, spacing: AppTheme.paddingMedium) {
                                Text("Ice Type")
                                    .font(.headline)
                                    .foregroundColor(AppTheme.textPrimary)
                                
                                ForEach(IceType.allCases) { type in
                                    Button(action: { iceType = type }) {
                                        HStack {
                                            Text(type.displayName)
                                                .foregroundColor(AppTheme.textPrimary)
                                            Spacer()
                                            if iceType == type {
                                                IconView(icon: .check, size: 16, colour: AppTheme.primary)
                                                    .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                                            }
                                        }
                                        .padding()
                                        .background(iceType == type ? AppTheme.primary.opacity(0.2) : AppTheme.cardBackgroundLight)
                                        .cornerRadius(AppTheme.cornerRadiusSmall)
                                    }
                                }
                            }
                        }
                        
                        CardView {
                            VStack(alignment: .leading, spacing: AppTheme.paddingMedium) {
                                Text("Notes (Optional)")
                                    .font(.headline)
                                    .foregroundColor(AppTheme.textPrimary)
                                
                                TextField("Add notes about conditions...", text: $notes, axis: .vertical)
                                    .lineLimit(3...6)
                                    .font(.body)
                                    .foregroundColor(AppTheme.textPrimary)
                                    .padding()
                                    .background(AppTheme.cardBackgroundLight)
                                    .cornerRadius(AppTheme.cornerRadiusSmall)
                            }
                        }
                        
                        Button(action: saveMeasurement) {
                            Text("Save Measurement")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, AppTheme.paddingMedium)
                                .background(AppTheme.iceGradient)
                                .cornerRadius(AppTheme.cornerRadiusMedium)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("New Measurement")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                        .foregroundColor(AppTheme.primary)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
    
    private func saveMeasurement() {
        let record = MeasurementRecord(
            locationName: locationName,
            thickness: thickness,
            iceType: iceType.rawValue,
            notes: notes
        )
        viewModel.addRecord(record)
        dismiss()
    }
}

struct EditMeasurementSheet: View {
    @ObservedObject var viewModel: MeasurementLogViewModel
    let record: MeasurementRecord
    @Environment(\.dismiss) var dismiss
    
    @State private var locationName: String
    @State private var thickness: Double
    @State private var iceType: IceType
    @State private var notes: String
    
    init(viewModel: MeasurementLogViewModel, record: MeasurementRecord) {
        self.viewModel = viewModel
        self.record = record
        _locationName = State(initialValue: record.locationName)
        _thickness = State(initialValue: record.thickness)
        _iceType = State(initialValue: IceType(rawValue: record.iceType) ?? .clear)
        _notes = State(initialValue: record.notes)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                AppTheme.background.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: AppTheme.paddingLarge) {
                        CardView {
                            VStack(alignment: .leading, spacing: AppTheme.paddingMedium) {
                                Text("Location")
                                    .font(.headline)
                                    .foregroundColor(AppTheme.textPrimary)
                                
                                TextField("Enter location name", text: $locationName)
                                    .font(.body)
                                    .foregroundColor(AppTheme.textPrimary)
                                    .padding()
                                    .background(AppTheme.cardBackgroundLight)
                                    .cornerRadius(AppTheme.cornerRadiusSmall)
                            }
                        }
                        
                        CardView {
                            VStack(alignment: .leading, spacing: AppTheme.paddingMedium) {
                                Text("Ice Thickness (cm)")
                                    .font(.headline)
                                    .foregroundColor(AppTheme.textPrimary)
                                
                                CustomSlider(value: $thickness, range: 0...50, step: 0.5)
                                
                                Text(String(format: "%.1f cm (%.1f\")", thickness, UnitConverter.cmToInches(thickness)))
                                    .font(.title2.weight(.bold))
                                    .foregroundColor(AppTheme.primary)
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                        }
                        
                        CardView {
                            VStack(alignment: .leading, spacing: AppTheme.paddingMedium) {
                                Text("Ice Type")
                                    .font(.headline)
                                    .foregroundColor(AppTheme.textPrimary)
                                
                                ForEach(IceType.allCases) { type in
                                    Button(action: { iceType = type }) {
                                        HStack {
                                            Text(type.displayName)
                                                .foregroundColor(AppTheme.textPrimary)
                                            Spacer()
                                            if iceType == type {
                                                IconView(icon: .check, size: 16, colour: AppTheme.primary)
                                                    .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                                            }
                                        }
                                        .padding()
                                        .background(iceType == type ? AppTheme.primary.opacity(0.2) : AppTheme.cardBackgroundLight)
                                        .cornerRadius(AppTheme.cornerRadiusSmall)
                                    }
                                }
                            }
                        }
                        
                        CardView {
                            VStack(alignment: .leading, spacing: AppTheme.paddingMedium) {
                                Text("Notes (Optional)")
                                    .font(.headline)
                                    .foregroundColor(AppTheme.textPrimary)
                                
                                TextField("Add notes about conditions...", text: $notes, axis: .vertical)
                                    .lineLimit(3...6)
                                    .font(.body)
                                    .foregroundColor(AppTheme.textPrimary)
                                    .padding()
                                    .background(AppTheme.cardBackgroundLight)
                                    .cornerRadius(AppTheme.cornerRadiusSmall)
                            }
                        }
                        
                        Button(action: updateMeasurement) {
                            Text("Update Measurement")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, AppTheme.paddingMedium)
                                .background(AppTheme.iceGradient)
                                .cornerRadius(AppTheme.cornerRadiusMedium)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Edit Measurement")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                        .foregroundColor(AppTheme.primary)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
    
    private func updateMeasurement() {
        var updated = record
        updated.locationName = locationName
        updated.thickness = thickness
        updated.iceType = iceType.rawValue
        updated.notes = notes
        viewModel.updateRecord(updated)
        dismiss()
    }
}

#Preview {
    MeasurementLogView()
}
