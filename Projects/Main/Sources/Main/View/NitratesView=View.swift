//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

import SwiftUI

struct NitratesView: View {
    @State private var nitrateReadings = [NitrateReading]()
    // TODO: effective way to save the readings on deinit


    var body: some View {
        VStack {
            ReadingGraph(data: $nitrateReadings)
            HStack {
                Spacer(minLength: UIScreen.main.bounds.width/4)
                ReadingEntry(nitrateReadings: $nitrateReadings)
                VStack {
                    Spacer()
                    NavigationLink("Add...") {
                        ManualEntryView(nitrateReadings: $nitrateReadings)
                    }
                }
                .frame(maxHeight: 100)
                .padding()
            }
        }
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .background(.gray)
    }
}
