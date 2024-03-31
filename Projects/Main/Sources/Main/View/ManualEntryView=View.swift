//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

import SwiftUI
import SwiftData

#Preview {
    MainView()
}

struct ManualEntryView: View {
    var modelContext: ModelContext

    var body: some View {
        ReadingEntryView(modelContext: modelContext, fullInput: true)
    }
}
