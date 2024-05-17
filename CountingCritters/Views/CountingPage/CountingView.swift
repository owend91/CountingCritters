//
//  CountingView.swift
//  CountingCritters
//
//  Created by David Owen on 4/30/24.
//

import SwiftUI

struct CountingView: View {
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @AppStorage("allowAnimation") var allowAnimation: Bool = true
    @AppStorage("manuallySetAnimation") var manuallySetAnimation: Bool = false
    @AppStorage("allowHaptics") var allowHaptics: Bool = true

    @State var vm = CountingViewModel()
    @State private var countYOffset = 355.0
    @State private var countXOffset = 0.0
    @State private var countScaleEffect = 1.0

    @State var showingSettings = false
    var manuallySelectedCritters: [Critter]? = nil

    let columns = [
        GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
    ]
    var body: some View {
        ZStack {
            BackgroundColor(color: gradientMap[vm.currentCritter.background] ?? AnyView(goldenHour))

            CritterBoard()
                .environment(vm)

            VStack {
                ZStack {
                    HStack {
                        Spacer()
                        Text("\(vm.pageIsDone ? "You found" : "Find") ^[\(vm.pageCount) \(vm.currentCritter.name)](inflect: true)\(vm.pageIsDone ? "!" : "")")
                            .font(.title)
                            .scaleEffect(1.2)
                            .bold()
                            .foregroundStyle(.white)
                            .shadow(radius: 5)
                            .opacity(0)

                        Spacer()
                    }
                    .padding(.bottom)
                    .background(.ultraThinMaterial.opacity(0.7))
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
                    .zIndex(1)

                    HStack {
                        Spacer()
                        Button {
                            showingSettings.toggle()
                        } label: {
                            Image(systemName: "info.circle")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.regularMaterial)
                                .padding(.trailing)
                                .shadow(radius: 10)
                                .opacity(0.5)
                        }
                        .offset(y: -30)
                        .sheet(isPresented: $showingSettings) {
                            SettingsView() {
                                vm.startGame()
                            }
                            .presentationBackground(.ultraThinMaterial)
                            .presentationDetents([.fraction(0.4)])
                            .presentationDragIndicator(.visible)
                        }
                    }
                    .zIndex(vm.pageIsDone ? 0 : 2)
                }
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
                    if willShowAnimation(manuallySetAnimation: manuallySetAnimation, allowAnimation: allowAnimation, reduceMotion: reduceMotion) {
                        withAnimation {
                            countYOffset = 355
                            countScaleEffect = 1
                            if vm.pageIsDone {
                                countXOffset = -145
                            }
                        }
                    } else {
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
            vm.manuallySelectedCritters = manuallySelectedCritters
            vm.startGame()
        }
    }
}

#Preview {
    let allCritters = Critter.allCritters
    var selectedCritter = allCritters.filter({$0.name == "horse"}).first!
    var selectedCritters = Array(repeating: selectedCritter, count: 9)
    return CountingView(manuallySelectedCritters: selectedCritters)
}
