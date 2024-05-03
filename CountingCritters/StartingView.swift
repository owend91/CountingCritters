//
//  StartingView.swift
//  CountingCritters
//
//  Created by David Owen on 4/30/24.
//

import SwiftUI

struct StartingView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                icyBlue.opacity(0.5).ignoresSafeArea()
                VStack {
                    Text("Counting Critters")
                        .font(.title)
                    NavigationLink(destination: CountingView()) {
                        Text("Start")
                    }
                }
            }
        }
    }
}

#Preview {
    StartingView()
}
