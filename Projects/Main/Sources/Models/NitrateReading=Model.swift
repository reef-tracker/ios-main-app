//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

import Foundation

struct NitrateReading: Identifiable {
    var id = UUID().uuidString
    var nitrateValue: Double
    var readingDate: Date
}
