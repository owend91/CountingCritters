//
//  TestVuew.swift
//  CountingCritters
//
//  Created by David Owen on 5/6/24.
//

import SwiftUI

struct TestVuew: View {
    @State private var showDetails = false

        var body: some View {
            VStack {
                Button("Press to show details") {
                    withAnimation {
                        showDetails.toggle()
                    }
                }

                if showDetails {
                    // Moves in from the bottom
                    Text("Details go here.")
                        .transition(.move(edge: .bottom))

                    // Moves in from leading out, out to trailing edge.
                    Text("Details go here.")
                        .transition(.slide)

                    // Starts small and grows to full size.
                    Text("Details go here.")
                        .transition(.scale)
                }
            }
        }
}

#Preview {
    TestVuew()
}
