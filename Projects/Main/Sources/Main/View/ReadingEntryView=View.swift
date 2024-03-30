//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

import SwiftUI
import SwiftData

struct ReadingEntryView: View {
    @State private var nitrateReading: String = ""
    @State private var dateReading: Date = Date()
    var modelContext: ModelContext
    let needsDatePicker: Bool

    func save() {
        guard let nitratePPM = Double(nitrateReading) else { return }
        modelContext.insert(NitrateReadingSchemaV0(nitrateValue: nitratePPM, date: needsDatePicker ? dateReading : Date.now))
    }

    var body: some View {
        VStack {
            TextField("0.0", text: $nitrateReading)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
                .frame(width: 150)
                .padding(.bottom, 24)
            if needsDatePicker {
                DatePicker("Manual Entry Date", selection: $dateReading,
                           displayedComponents: [.date, .hourAndMinute])
            }
            HStack {
                Spacer()
                Button(action: save) { Text("Save") }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}
