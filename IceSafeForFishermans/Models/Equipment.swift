import Foundation

struct Equipment: Identifiable {
    let id = UUID()
    let name: String
    let iconName: String
    let defaultWeight: Double // in kg
    var isSelected: Bool = false
    var customWeight: Double? = nil
    
    var weight: Double {
        customWeight ?? defaultWeight
    }
}

struct EquipmentPresets {
    static let snowmobile = Equipment(
        name: "Snowmobile",
        iconName: "equipment_snowmobile",
        defaultWeight: 250
    )
    
    static let iceHouse = Equipment(
        name: "Ice House/Shelter",
        iconName: "equipment_shelter",
        defaultWeight: 150
    )
    
    static let auger = Equipment(
        name: "Ice Auger",
        iconName: "equipment_auger",
        defaultWeight: 15
    )
    
    static let gear = Equipment(
        name: "Fishing Gear",
        iconName: "equipment_gear",
        defaultWeight: 30
    )
    
    static let all: [Equipment] = [snowmobile, iceHouse, auger, gear]
}
