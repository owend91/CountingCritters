//
//  CountingView.swift
//  CountingCritters
//
//  Created by David Owen on 4/30/24.
//

import SwiftUI

struct CountingView: View {
    @State var vm = CountingViewModel()
    var manuallySelectedCritters: [Critter]? = nil

    var body: some View {
        ZStack {
            BackgroundColor(color: gradientMap[vm.currentCritter.background] ?? AnyView(goldenHour))

            // NOTE: The board is displaying before the header and footer so that the
            // Critters at the top of the board will be under the material
            // (only small portions of the critter will be covered, if any)
            CritterBoard()
                .environment(vm)

            CountingHeadView()
                .environment(vm)

            CountingFootView()
                .environment(vm)

        }
        .preferredColorScheme(.dark)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            //Manually selected critters are only used in the preview for testing
            vm.manuallySelectedCritters = manuallySelectedCritters
            vm.startGame()
        }
    }
}

#Preview {
    let allCritters = Critter.allCritters
    let selectedCritter = allCritters.filter({$0.name == "horse"}).first!
    let selectedCritters = Array(repeating: selectedCritter, count: 9)
    return CountingView(manuallySelectedCritters: selectedCritters)
}
