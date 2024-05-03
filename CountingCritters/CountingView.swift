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
            gradientMap[vm.currentCritter.background]
                .ignoresSafeArea()
            VStack {
                Text("Tap on ^[\(vm.pageCount) \(vm.currentCritter.name)](inflect: true)")
                    .background(.blue)
                Spacer()
            }

            LazyVGrid(columns: columns) {
            
                ForEach(0...8, id: \.self) { count in
                    if vm.layout.contains(count) {
                        CritterView(vm: $vm, critterViewCount: count, imageTranslation: vm.imageTranslations[count])
                            .onTapGesture {
                                vm.currentTaps.append(count)
                                vm.tapCount += 1
                            }

                    }
                }

            }
            .padding(.horizontal)

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
    let imageTranslation: ImageTranslation

    var body: some View {
        Image(vm.currentCritter.id)
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity, minHeight: 230, maxHeight: .infinity)
            .opacity(vm.currentTaps.contains(critterViewCount) ? 0.5 : 1.0) // Dim the critter if it's already tapped
            .scaleEffect(imageTranslation.scale)
            .offset(x: imageTranslation.x, y: imageTranslation.y)
            .rotationEffect(.degrees(imageTranslation.rotation))
            .shadow(radius: imageTranslation.shadow)
            .onAppear {
                print("Count: \(critterViewCount)")
                print("Scale: \(imageTranslation.scale)")
                print("X Offset: \(imageTranslation.x)")
                print("Y Offset: \(imageTranslation.y)")
                print("Shadow: \(imageTranslation.shadow)")

            }
    }
}

#Preview {
    CountingView()
}
