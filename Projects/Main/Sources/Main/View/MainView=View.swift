//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

import SwiftUI
import SwiftData

#Preview {
    MainView()
        .modelContainer(for: NitrateReadingSchemaV0.self, inMemory: true)
}

internal struct MainView {

    // MARK: MainView - Initialization

    internal init() {
        /* This scope is intentionally left blank. */
    }

    // MARK: MainView - Representation
    @Query(sort: \NitrateReadingSchemaV0.date, order: .reverse) var allReadings: [NitrateReadingSchemaV0]
    @Environment(\.modelContext) private var context
}

extension MainView: View {

    // MARK: View - Body

    internal var body: some View {
        VStack {
            Button("Create Reading") {
                let someReading = NitrateReadingSchemaV0(date: Date(), readingValue: .random(in: 0...1))
                context.insert(someReading)
            }
            Button("Delete last reading") {
                let lastRading = allReadings.last
                guard let lastRading else { return }
                context.delete(lastRading)
            }
            ForEach(allReadings.indices, id: \.self) { readingIndex in
                Text("value: \(allReadings[readingIndex].readingValue)")
            }
        }
    }
}
