//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

import SwiftUI
import Charts
import SwiftData

#Preview {
    MainView()
}

struct ChartPosition {
    let x: Date
    let y: Double
}

struct ToolTip: View {
    let chartPosition: ChartPosition

    var body: some View {
        VStack {
            Text("Date: \(formattedDate(date: chartPosition.x))")
            Text("PPM: \(String(format: "%.1f", chartPosition.y))")
        }
        .background(.gray)
    }

    func formattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: date)
    }
}

struct ReadingGraphView: View {
    @Query(sort: \NitrateReadingSchemaV0.date, order: .reverse) var allReadings: [NitrateReadingSchemaV0]
    @State var position: ChartPosition?
    @State var fingerPosition: ChartPosition?

    var body: some View {
        Chart {
            ForEach(allReadings) { data in
                LineMark(x: .value("Date", data.date),
                         y: .value("Value", data.nitrateValue))
            }

            if let position = position {
                PointMark(x: .value("Date", position.x),
                          y: .value("Nitrate (ppm)", position.y - 1))
                    .symbol(symbol: { ToolTip(chartPosition: position) })
                PointMark(x: .value("Date", position.x),
                          y: .value("Nitrate (ppm)", position.y))
                .symbol(BasicChartSymbolShape.circle.strokeBorder(lineWidth: 3.0))
                .symbolSize(250)
                .foregroundStyle(.black)
            }
        }
        .chartOverlay { proxy in
            GeometryReader { geometry in
                Rectangle().fill(.clear).contentShape(Rectangle())
                    .gesture(DragGesture()
                        .onChanged { value in
                            updateCursorPosition(at: value.location, geometry: geometry, proxy: proxy)
                        }
                        .onEnded { _ in
                            position = nil
                        }
                    )
            }
        }
        .chartXAxis { AxisMarks(values: .automatic) {
            AxisValueLabel()
                .foregroundStyle(Color.black) // <= change the style of the label

            AxisGridLine()
                .foregroundStyle(Color.black) // <= change the style of the line
            }
        }
        .chartYAxis { AxisMarks(values: .automatic) {
            AxisValueLabel()
                .foregroundStyle(Color.black) // <= change the style of the label

            AxisGridLine()
                .foregroundStyle(Color.black) // <= change the style of the line
            }
        }
        .padding()
        .background(Color(red: 0.83, green: 0.83, blue: 0.83))
        .foregroundColor(.black)

    }

    func updateCursorPosition(at: CGPoint, geometry: GeometryProxy, proxy: ChartProxy) {
        let data = allReadings
        let origin = geometry[proxy.plotFrame!].origin
        let datePos = proxy.value(atX: at.x - origin.x, as: Date.self)
        let firstGreater = data.firstIndex(where: { $0.date < datePos! })
        if let index = firstGreater {
            let time = data[index].date
            let height = data[index].nitrateValue
            position = ChartPosition(x: time, y: height)
        }
    }
}
