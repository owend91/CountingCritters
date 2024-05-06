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
    @State private var countOffset = 300.0
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
            VStack {
                HStack {
                    Spacer()
                    Text("\(vm.pageIsDone ? "You found" : "Find") ^[\(vm.pageCount) \(vm.currentCritter.name)](inflect: true)\(vm.pageIsDone ? "!" : "")")
                        .font(.title)
                        .bold()
                        .blendMode(.luminosity)
                    Spacer()
                }
                .padding(.bottom)
                .background(.thinMaterial)
                Spacer()
            }

            LazyVGrid(columns: columns) {

                ForEach(0...8, id: \.self) { count in
                    if vm.layout.contains(count) {
                        CritterView(vm: $vm, critterViewCount: count, imageTranslation: vm.imageTranslations[count])
                            .onTapGesture {
                                if !vm.currentTaps.contains(count) {
                                    vm.tapCount += 1
                                    animate.toggle()
                                    vm.tapDictionary[count] = vm.tapCount
                                }
                            }

                    }
                }

            }
            .padding(.horizontal)

            VStack {

                Text("\(vm.tapCount)")
                    .font(.system(size: 70))
                    .scaleEffect(countScaleEffect)
                    .foregroundStyle(.white)
                    .offset(y: countOffset)
                    .shadow(radius: 5)



//                } else {
//                    Text("\(vm.tapCount)")
//                        .font(.system(size: 70))
//                        .scaleEffect(animate ? 4 : 1)
//                        .animation(.spring(), value: animate)
//                        .foregroundStyle(.white)
//                }

            }
            .onChange(of: vm.tapCount) {
                if vm.tapCount != 0 {
                    countOffset = 0
                    countScaleEffect = 2
                    withAnimation {
                        countOffset = 300
                        countScaleEffect = 1
                    }
                }
            }

            if vm.tapCount == vm.pageCount {
                Color.black
                    .opacity(0.1)
                    .ignoresSafeArea()
                VStack {
                    Text("You found ^[\(vm.pageCount) \(vm.currentCritter.name)](inflect: true)!")
                        .multilineTextAlignment(.center)
                    Button {
                        vm.nextPage()
                    } label: {
                        Text("Next")
                            .padding()
                            .background(.ultraThinMaterial)
                            .foregroundStyle(.white)
                    }

                }
                .padding(.vertical)
                .frame(width: 300, height: 200)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 5.0))
                .shadow(radius: 5)

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
                    .foregroundStyle(.thinMaterial)
                    .shadow(radius: 10)
                    .frame(width: 20, height: 20)
            } else {
                Text("")
                    .font(.title3)
                    .scaleEffect(imageTranslation.scale * 2)
                    .bold()
                    .foregroundStyle(.white)
                    .shadow(radius: 10)
                    .frame(width: 20, height: 20)

            }
        }
        .offset(x: imageTranslation.x, y: imageTranslation.y)

    }
}

#Preview {
    CountingView()
}
