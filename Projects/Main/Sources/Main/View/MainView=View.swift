//
// Introductory information is in the `README.md` file at the repository root containing this file.
// Copyright information is in the `LICENSE.txt` file at the repository root containing this file.
//

import SwiftUI
import Combine
import Charts

#Preview {
    MainView()
}

internal struct MainView {

    // MARK: MainView - Initialization

    internal init() {
        /* This scope is intentionally left blank. */
    }

    // MARK: MainView - Representation

    /* <#...#> */
}

extension MainView: View {

    // MARK: View - Body

    internal var body: some View {
        LandingView()
            .preferredColorScheme(.dark)

    }
}

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
            .navigationTitle("Welcome to the rodeo")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}


struct NitrateReading: Identifiable {
    var id = UUID().uuidString
    var nitrateValue: Double
    var readingDate: Date
}

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




struct ManualEntryView: View {
    @Binding var nitrateReadings: [NitrateReading]

    var body: some View {
        Text("ManualEnteryView")
    }
}







struct ReadingEntry: View {
    @State private var stringInput: String = ""
    @Binding var nitrateReadings: [NitrateReading]

    func save() {
        guard let double = Double(stringInput) else { return }
        nitrateReadings.append(NitrateReading(nitrateValue: double, readingDate: Date.now))
    }

    func addCustomInput() {

    }

    var body: some View {
        VStack {
            TextField("0.0", text: $stringInput)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
                .frame(width: 150)
                .padding(.bottom, 24)
            HStack {
                Spacer()
                Button(action: save) { Text("Save") }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}







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
                .foregroundStyle(Color.black)// <= change the style of the label

            AxisGridLine()
                .foregroundStyle(Color.black)// <= change the style of the line
            }
        }
        .background(Color(red: 0.83, green: 0.83, blue: 0.83))
        .foregroundColor(.black)
    }
}



// This is really what I have to do to store an array in userdefaults?
extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}
