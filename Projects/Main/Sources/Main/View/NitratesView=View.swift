//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

import SwiftUI
import SwiftData

#Preview {
    MainView()
}

struct NitratesView: View {
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        VStack {
            ReadingGraphView()
            HStack {
                Spacer(minLength: UIScreen.main.bounds.width/4)
                ReadingEntryView(modelContext: modelContext, fullInput: false)
                VStack {
                    Spacer()
                    NavigationLink("Add...") {
                        ManualEntryView(modelContext: modelContext)
                    }
                }
                .frame(maxHeight: 100)
                .padding()
            }
        }
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .background(.gray)
        .navigationTitle("Nitrates")
    }
}
