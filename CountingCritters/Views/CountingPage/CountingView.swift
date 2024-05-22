//
//  CountingView.swift
//  CountingCritters
//
//  Created by David Owen on 4/30/24.
//

import SwiftUI

struct CountingView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var path: NavigationPath
    @State var vm = CountingViewModel()
    var manuallySelectedCritters: [Critter]? = nil
    @State var exitPressed = false

    var body: some View {
        ZStack {
            BackgroundColor(color: gradientMap[vm.currentCritter.background] ?? AnyView(goldenHour))

            // NOTE: The board is displaying before the header and footer so that the
            // Critters at the top of the board will be under the material
            // (only small portions of the critter will be covered, if any)
            // ALSO - something about devices with the home button (ie iPhone SE)
            // caused the board to push the header and footer if all three rows
            // of the grid were being used.  Putting a frame on the board for those
            // devices seems to have fixed the issue
            if hasHomeButton {
                CritterBoard()
                    .environment(vm)
                    .frame(maxHeight: 200)
            } else {
                CritterBoard()
                    .environment(vm)
            }

            CountingHeadView(path: $path)
                .environment(vm)

            CountingFootView(exitPressed: $exitPressed)
                .environment(vm)

        }
        .preferredColorScheme(.dark)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            //Manually selected critters are only used in the preview for testing
            vm.manuallySelectedCritters = manuallySelectedCritters
            vm.startGame()
            print("Has home button: \(hasHomeButton)")
        }
        .confirmationDialog("Complete", isPresented: .constant(vm.gameIsDone)) {
            Button("Same Critters") {
                vm.restartGame()
            }
            Button("New Critters") {
                vm.startGame()
            }
            Button("Exit Game") {
                dismiss()
                vm.quitGame()
                path = NavigationPath()
            }
        } message: {
            Text("Congratulations! Count again?")
        }
        .confirmationDialog("Exit", isPresented: $exitPressed) {
            Group {
                Button("Same Critters") {
                    vm.restartGame()
                }
                Button("New Critters") {
                    vm.startGame()
                }
                Button("Exit Game") {
                    vm.quitGame()
                    dismiss()
                    path = NavigationPath()
                }
            }
        } message: {
            Text("Want to count again?")
        }
    }
}

#Preview {
    let allCritters = Critter.allCritters
    let selectedCritter = allCritters.filter({$0.name == "horse"}).first!
    let selectedCritters = Array(repeating: selectedCritter, count: 9)
    return CountingView(path: .constant(NavigationPath()), manuallySelectedCritters: selectedCritters)
}
