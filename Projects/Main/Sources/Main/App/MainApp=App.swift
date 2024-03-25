//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

import SwiftUI

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
                    NitrateReading.self
                ])
        }
    }
}

import SwiftData

@Model class NitrateReading {
    var date: Date
    var readingValue: Float64

    init(date: Date, readingValue: Float64) {
        self.date = date
        self.readingValue = readingValue
    }
}
