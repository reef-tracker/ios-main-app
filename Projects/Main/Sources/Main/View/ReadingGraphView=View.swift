//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

import SwiftUI
import Charts
import SwiftData

struct ReadingGraphView: View {
    @Query(sort: \NitrateReadingSchemaV0.date, order: .reverse) var allReadings: [NitrateReadingSchemaV0]

    var body: some View {
        Chart {
            ForEach(allReadings) { data in
                LineMark(x: .value("Date", data.date),
                         y: .value("Value", data.nitrateValue))
            }
        }
        .chartXAxis {AxisMarks(values: .automatic) {
            AxisValueLabel()
                .foregroundStyle(Color.black) // <= change the style of the label

            AxisGridLine()
                .foregroundStyle(Color.black) // <= change the style of the line
            }
        }
        .chartYAxis {AxisMarks(values: .automatic) {
            AxisValueLabel()
                .foregroundStyle(Color.black) // <= change the style of the label

            AxisGridLine()
                .foregroundStyle(Color.black) // <= change the style of the line
            }
        }
        .background(Color(red: 0.83, green: 0.83, blue: 0.83))
        .foregroundColor(.black)
    }
}
