//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

import SwiftUI
import SwiftData

@main
internal struct MainApp: App {

    // MARK: App

    internal init() {
        /* This routine is intentionally left blank. */
    }

    internal var body: some Scene {
        WindowGroup {
            MainView()
                .modelContainer(for: [
                    NitrateReadingSchemaV0.self
                ])
        }
    }
}
