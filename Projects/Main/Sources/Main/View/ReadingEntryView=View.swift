//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

import SwiftUI

struct ReadingEntry: View {
    @State private var stringInput: String = ""
    @Binding var nitrateReadings: [NitrateReading]

    func save() {
        guard let double = Double(stringInput) else { return }
        nitrateReadings.append(NitrateReading(nitrateValue: double, readingDate: Date.now))
    }

    func addCustomInput() {

    }

    var body: some View {
        VStack {
            TextField("0.0", text: $stringInput)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
                .frame(width: 150)
                .padding(.bottom, 24)
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
