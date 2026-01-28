import Foundation

struct MeasurementRecord: Identifiable, Codable {
    let id: UUID
    var date: Date
    var locationName: String
    var thickness: Double // in cm
    var iceType: String
    var notes: String
    
    init(id: UUID = UUID(), date: Date = Date(), locationName: String = "", thickness: Double = 0, iceType: String = "clear", notes: String = "") {
        self.id = id
        self.date = date
        self.locationName = locationName
        self.thickness = thickness
        self.iceType = iceType
        self.notes = notes
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "en_GB")
        return formatter.string(from: date)
    }
    
    var shortDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        formatter.locale = Locale(identifier: "en_GB")
        return formatter.string(from: date)
    }
}
