//
//  CritterBoard.swift
//  CountingCritters
//
//  Created by David Owen on 5/17/24.
//

import SwiftUI

struct CritterBoard: View {
    @AppStorage("allowHaptics") var allowHaptics: Bool = true
    @Environment(CountingViewModel.self) var vm
    let columns = [
        GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
    ]

    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(0...8, id: \.self) { count in
                if vm.layout.contains(count) {
                    CritterView(critterLocation: count, imageTranslation: vm.imageTranslations[count])
                        .onTapGesture {
                            if !vm.currentTaps.contains(count) {
                                vm.tapCount += 1
                                withAnimation {
                                    vm.tapDictionary[count] = vm.tapCount
                                }
                            }
                        }
                        .sensoryFeedback(allowHaptics ? .success : .impact(flexibility: .soft, intensity: 0), trigger: vm.tapCount) { _, _ in
                            vm.tapCount != 0
                        }
                }
                else {
                    PlaceholderText()
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    CritterBoard()
}
