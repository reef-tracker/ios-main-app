//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

import Foundation
import SwiftData

@Model class NitrateReadingSchemaV0 {
    var nitrateValue: Float64
    var date: Date

    init(nitrateValue: Double, date: Date) {
        self.nitrateValue = nitrateValue
        self.date = date
    }
}
