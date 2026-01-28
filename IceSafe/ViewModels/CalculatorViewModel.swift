import SwiftUI

class CalculatorViewModel: ObservableObject {
    @Published var iceThickness: Double = 10.0
    @Published var selectedIceType: IceType = .clear
    @Published var peopleCount: Int = 1
    @Published var equipment: [Equipment] = EquipmentPresets.all
    @Published var useMetric: Bool = true
    
    var totalEquipmentWeight: Double {
        equipment.filter { $0.isSelected }.reduce(0) { $0 + $1.weight }
    }
    
    var safetyResult: SafetyResult {
        IceCalculations.calculateSafety(
            thicknessCm: iceThickness,
            iceType: selectedIceType,
            peopleCount: peopleCount,
            equipmentWeight: totalEquipmentWeight
        )
    }
    
    func toggleEquipment(at index: Int) {
        equipment[index].isSelected.toggle()
    }
    
    func updateEquipmentWeight(at index: Int, weight: Double) {
        equipment[index].customWeight = weight
    }
    
    func reset() {
        iceThickness = 10.0
        selectedIceType = .clear
        peopleCount = 1
        equipment = EquipmentPresets.all
    }
}
