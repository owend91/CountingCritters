//
//  CountingView.swift
//  CountingCritters
//
//  Created by David Owen on 4/30/24.
//

import SwiftUI

struct CountingView: View {
    @State var vm = CountingViewModel()
    @State private var animate = false
    @State private var countYOffset = 355.0
    @State private var countXOffset = 0.0

    @State private var countScaleEffect = 1.0
    let columns = [
        GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
    ]
    var body: some View {
        ZStack {
            gradientMap[vm.currentCritter.background]
                .ignoresSafeArea()


            LazyVGrid(columns: columns) {

                ForEach(0...8, id: \.self) { count in
                    if vm.layout.contains(count) {
                        CritterView(vm: $vm, critterViewCount: count, imageTranslation: vm.imageTranslations[count])
                            .onTapGesture {
                                if !vm.currentTaps.contains(count) {
                                    vm.tapCount += 1
                                    animate.toggle()
                                    withAnimation {
                                        vm.tapDictionary[count] = vm.tapCount
                                    }
                                }
                            }
                            .sensoryFeedback(.success, trigger: vm.tapCount) { _, _ in
                                vm.tapCount != 0
                            }
                    } 
                    else {
                        Text(" ")
                    }
                }

            }
            .padding(.horizontal)

            VStack {
                HStack {
                    Spacer()
                    Text("\(vm.pageIsDone ? "You found" : "Find") ^[\(vm.pageCount) \(vm.currentCritter.name)](inflect: true)\(vm.pageIsDone ? "!" : "")")
                        .font(.title)
                        .scaleEffect(1.2)
                        .bold()
                        .foregroundStyle(.white)
                        .shadow(radius: 5)

                    Spacer()
                }
                .padding(.bottom)
                .background(.ultraThinMaterial.opacity(0.7))
                Spacer()
            }
            .shadow(radius: 10)

            ZStack {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Text(" ")
                            .font(.title)
                            .bold()

                        Spacer()

                    }
                    .padding()
                    .background(.ultraThinMaterial.opacity(0.7))

                }
                .shadow(radius: 10)

                Text("\(vm.tapCount)")
                    .font(.system(size: 70))
                    .scaleEffect(countScaleEffect)
                    .foregroundStyle(.white)
                    .offset(x: countXOffset, y: countYOffset)
                    .shadow(radius: 5)

                if vm.pageIsDone {
                    Button {
                        countXOffset = 0
                        if vm.pageCount == 9 {
                            vm.startGame()
                        } else {
                            vm.nextPage()
                        }

                    } label: {
                        HStack {
                            Spacer()
                            Text(vm.pageCount == 9 ? "Start Over!" : "Next")
                                .font(.system(size: 55))
                                .foregroundStyle(.white)
                                .bold()
                                .shadow(radius: 5)
                                .padding(.trailing, 40)
                        }
                    }
                    .offset(y: 355.0)
                }
            }
            .onChange(of: vm.tapCount) {
                if vm.tapCount != 0 {
                    countYOffset = 0
                    countScaleEffect = 2
                    countXOffset = 0
                    withAnimation {
                        countYOffset = 355
                        countScaleEffect = 1
                        if vm.pageIsDone {
                            countXOffset = -145
                        }
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
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
        ZStack {
            Image(vm.currentCritter.id)
                .resizable()
                .scaledToFit()
                .overlay(vm.currentTaps.contains(critterViewCount) ? Color.black.blendMode(.sourceAtop) : Color.clear.blendMode(.overlay))
                .frame(maxWidth: .infinity, minHeight: 230, maxHeight: .infinity)
                .opacity(vm.currentTaps.contains(critterViewCount) ? 0.5 : 1.0) // Dim the critter if it's already tapped
                .scaleEffect(imageTranslation.scale)
                .rotationEffect(.degrees(imageTranslation.rotation))
                .shadow(radius: imageTranslation.shadow)
                .onAppear {
                    print("Count: \(critterViewCount)")
                    print("Scale: \(imageTranslation.scale)")
                    print("X Offset: \(imageTranslation.x)")
                    print("Y Offset: \(imageTranslation.y)")
                    print("Shadow: \(imageTranslation.shadow)")

                }
            if vm.currentTaps.contains(critterViewCount) {
                Text("\(vm.tapDictionary[critterViewCount] ?? 0)")
                    .font(.title3)
                    .scaleEffect(imageTranslation.scale * 2)
                    .bold()
                    .foregroundStyle(.white.opacity(0.7))
                    .shadow(radius: 10)
                    .frame(width: 20, height: 20)
            } else {
                //This else keeps the spacing when the critter has not been tapped yet
                //Otherwise, after a tap, the critters may shift slightly
                Text("")
                    .frame(width: 20, height: 20)

            }
        }
        .offset(x: imageTranslation.x, y: imageTranslation.y)

    }
}

#Preview {
    CountingView()
}
