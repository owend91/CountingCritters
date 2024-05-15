//
//  StartingImageCarouselView.swift
//  CountingCritters
//
//  Created by David Owen on 5/15/24.
//

import SwiftUI

struct StartingImageCarouselView: View {
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @Environment(StartingViewModel.self) var vm
    @AppStorage("allowAnimation") var allowAnimation: Bool = true
    @AppStorage("manuallySetAnimation") var manuallySetAnimation: Bool = false

    let imageSwitchTimer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()

    var body: some View {
        HStack(spacing: 15) {
            Spacer()
            StartingImageView(imageId: Critter.allCritters[vm.leftImageIndex].id, frame: 75)
            StartingImageView(imageId: Critter.allCritters[vm.centerImageIndex].id, frame: 150)
            StartingImageView(imageId: Critter.allCritters[vm.rightImageIndex].id, frame: 75)
            Spacer()
        }
        .padding(.vertical)
        .background(.ultraThinMaterial.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .onReceive(imageSwitchTimer) { _ in
            if willShowAnimation(manuallySetAnimation: manuallySetAnimation, allowAnimation: allowAnimation, reduceMotion: reduceMotion) {
                withAnimation(.spring()) {
                    vm.updateImages()
                }
            }
        }
        .onDisappear {
            imageSwitchTimer.upstream.connect().cancel()
        }
    }
}

#Preview {
    StartingImageCarouselView()
}
