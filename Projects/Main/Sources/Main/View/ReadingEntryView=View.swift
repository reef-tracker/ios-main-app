//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

import SwiftUI
import SwiftData

#Preview {
    MainView()
}


struct ReadingEntryView: View {
    enum FocusableField {
        case textField, calendar
    }
    @Environment(\.dismiss) private var dismiss
    @State private var nitrateReading: String = ""
    @State private var dateReading: Date = Date()
    @FocusState private var focusedField: FocusableField?
    var modelContext: ModelContext
    let fullInput: Bool

    func save() {
        guard let nitratePPM = Double(nitrateReading) else { return }
        modelContext.insert(NitrateReadingSchemaV0(nitrateValue: nitratePPM, date: fullInput ? dateReading : Date.now))
        if fullInput {
            dismiss()
        }
        focusedField = nil
    }

    var body: some View {
        VStack {
            TextField("0.0", text: $nitrateReading)
                .focused($focusedField, equals: .textField)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
                .frame(width: 150)
                .padding(.bottom, 24)
                .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        HStack {
                            Spacer()
                            Button("Done") {
                                focusedField = nil
                            }
                        }
                    }
                }

            if fullInput {
                DatePicker("Enter reading:",
                           selection: $dateReading,
                           displayedComponents: [.date])
                .focused($focusedField, equals: .calendar)
                .datePickerStyle(.graphical)
                .padding(.horizontal)
                .padding(.bottom, 36)
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
