import SwiftUI

class MeasurementLogViewModel: ObservableObject {
    @Published var records: [MeasurementRecord] = []
    @Published var showingAddSheet = false
    
    private let storageKey = "measurementRecords"
    
    init() {
        loadRecords()
    }
    
    func loadRecords() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode([MeasurementRecord].self, from: data) {
            records = decoded.sorted { $0.date > $1.date }
        }
    }
    
    func saveRecords() {
        if let encoded = try? JSONEncoder().encode(records) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }
    
    func addRecord(_ record: MeasurementRecord) {
        records.insert(record, at: 0)
        saveRecords()
    }
    
    func deleteRecord(at offsets: IndexSet) {
        records.remove(atOffsets: offsets)
        saveRecords()
    }
    
    func deleteRecord(_ record: MeasurementRecord) {
        records.removeAll { $0.id == record.id }
        saveRecords()
    }
    
    func updateRecord(_ record: MeasurementRecord) {
        if let index = records.firstIndex(where: { $0.id == record.id }) {
            records[index] = record
            saveRecords()
        }
    }
}
