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
