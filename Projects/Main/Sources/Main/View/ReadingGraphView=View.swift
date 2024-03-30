//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

import SwiftUI
import Charts

struct ReadingGraph: View {
    @Binding var data: [NitrateReading]

    var body: some View {
        Chart {
            ForEach(data) { data in
                LineMark(x: .value("Date", data.readingDate),
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
        .background(Color(red: 0.83, green: 0.83, blue: 0.83))
        .foregroundColor(.black)
    }
}
