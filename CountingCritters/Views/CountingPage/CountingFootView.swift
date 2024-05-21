//
//  CountingFootView.swift
//  CountingCritters
//
//  Created by David Owen on 5/20/24.
//

import SwiftUI

struct CountingFootView: View {
    @Environment(CountingViewModel.self) var vm
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @AppStorage("allowAnimation") var allowAnimation: Bool = true
    @AppStorage("manuallySetAnimation") var manuallySetAnimation: Bool = false

    @State private var countYOffset = 355.0
    @State private var countXOffset = 0.0
    @State private var countScaleEffect = 1.0
    var body: some View {
        ZStack {
            FooterBackground()

            CountTextView(countScaleEffect: countScaleEffect,
                          countXOffset: countXOffset,
                          countYOffset: countYOffset)

            if vm.pageIsDone {
                NextPageButton(countXOffset: $countXOffset)
            }
        }
        .onChange(of: vm.tapCount) {
            if vm.tapCount != 0 {
                resetAnimationOffsets()

                if willShowAnimation(manuallySetAnimation: manuallySetAnimation, allowAnimation: allowAnimation, reduceMotion: reduceMotion) {
                    withAnimation {
                        setAnimationOffsets()
                    }
                } else {
                    setAnimationOffsets()
                }
            }
        }
    }

    private func resetAnimationOffsets() {
        countYOffset = 0
        countScaleEffect = 2
        countXOffset = 0
    }

    private func setAnimationOffsets() {
        countYOffset = 355
        countScaleEffect = 1
        if vm.pageIsDone {
            countXOffset = -145
        }
    }
}

struct FooterBackground: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                PlaceholderText()
                    .font(.title)
                    .bold()
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial.opacity(0.7))
        }
        .shadow(radius: 10)
    }
}

struct CountTextView: View {
    @Environment(CountingViewModel.self) var vm
    let countScaleEffect: Double
    let countXOffset: Double
    let countYOffset: Double

    var body: some View {
        Text("\(vm.tapCount)")
            .font(.system(size: 70))
            .scaleEffect(countScaleEffect)
            .foregroundStyle(.white)
            .offset(x: countXOffset, y: countYOffset)
            .shadow(radius: 5)
    }
}

struct NextPageButton: View {
    @Environment(CountingViewModel.self) var vm
    @Binding var countXOffset: Double

    var body: some View {
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

#Preview {
    CountingFootView()
        .environment(CountingViewModel())
}
