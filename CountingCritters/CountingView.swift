//
//  CountingView.swift
//  CountingCritters
//
//  Created by David Owen on 4/30/24.
//

import SwiftUI

struct CountingView: View {
    @State var vm = CountingViewModel()
    let columns = [
        GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
    ]
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            VStack {
                Text("Tap on ^[\(vm.pageCount) \(vm.currentCritter.name)](inflect: true)")
                    .background(.blue)
                Spacer()
            }

            LazyVGrid(columns: columns) {

                ForEach(1...9, id: \.self) { count in
                    if vm.layout.contains(count) {
                        CritterView(vm: $vm, critterViewCount: count)
                            .onTapGesture {
                                vm.currentTaps.append(count)
                                vm.tapCount += 1
                            }

                    } else {
                        Text("\(count)")
                            .frame(maxWidth: .infinity, minHeight: 230, maxHeight: .infinity)
                    }
                }

            }

            VStack {

                Spacer()

                if vm.tapCount == vm.pageCount {
                    Button("Next") {
                        vm.nextPage()
                    }
                    .buttonStyle(BorderedButtonStyle())
                } else {
                    Text("\(vm.tapCount)")
                        .foregroundStyle(.white)
                }

            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            print("On Appear")
            vm.startGame()
        }
    }
}

struct CritterView: View {
    @Binding var vm: CountingViewModel
    let critterViewCount: Int

    var body: some View {
        Image(vm.currentCritter.id)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity, minHeight: 230, maxHeight: .infinity)
            .opacity(vm.currentTaps.contains(critterViewCount) ? 0.5 : 1.0) // Dim the critter if it's already tapped
    }
}

#Preview {
    CountingView()
}
