//
//  CritterView.swift
//  CountingCritters
//
//  Created by David Owen on 5/7/24.
//

import SwiftUI

struct CritterView: View {
    @Environment(CountingViewModel.self) var vm
//    @Binding var vm: CountingViewModel
    let critterLocation: Int
    let imageTranslation: ImageTranslation

    var body: some View {
        ZStack {
            Image(vm.currentCritter.id)
                .resizable()
                .scaledToFit()
                .overlay(vm.hasCritterBeenTapped(critterLocation) ? Color.black.blendMode(.sourceAtop) : Color.clear.blendMode(.overlay))
                .frame(maxWidth: .infinity, minHeight: 230, maxHeight: .infinity)
                .opacity(vm.hasCritterBeenTapped(critterLocation) ? 0.5 : 1.0) // Dim the critter if it's already tapped
                .scaleEffect(imageTranslation.scale)
                .rotationEffect(.degrees(imageTranslation.rotation))
                .shadow(radius: imageTranslation.shadow)

            if vm.hasCritterBeenTapped(critterLocation) {
                Text("\(vm.tapDictionary[critterLocation] ?? 0)")
                    .font(.title3)
                    .scaleEffect(imageTranslation.scale * 2)
                    .bold()
                    .foregroundStyle(.white.opacity(0.7))
                    .shadow(radius: 10)
                    .frame(width: 20, height: 20)
                    .accessibilityIdentifier("Tapped\(vm.tapDictionary[critterLocation] ?? 0)")

            } else {
                //This else keeps the spacing when the critter has not been tapped yet
                //Otherwise, after a tap, the critters may shift slightly
                PlaceholderText()
                    .frame(width: 20, height: 20)

            }
        }
        .offset(x: imageTranslation.x, y: imageTranslation.y)

    }
}

#Preview {
    var translation = ImageTranslation()
    translation.scale = 0.65
    translation.rotation = 40.0

    return CritterView(critterLocation: 0, imageTranslation: translation).environment(CountingViewModel())
}
