//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

import SwiftUI

struct LandingView: View {

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Parameters").font(.largeTitle).textCase(.none)) {
                    NavigationLink("Nitrates") {
                        NitratesView()
                    }
                }
            }
            .navigationTitle("Home")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}
