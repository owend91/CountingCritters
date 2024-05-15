//
//  StartingImageCarouselView.swift
//  CountingCritters
//
//  Created by David Owen on 5/15/24.
//

import SwiftUI

struct StartingImageCarouselView: View {
    @State var leftImageIndex = 0
    @State var centerImageIndex = 1
    @State var rightImageIndex = 2

    let imageSwitchTimer = Timer.publish(every: 2, on: .main, in: .common)
                                .autoconnect()

    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @AppStorage("allowAnimation") var allowAnimation: Bool = true
    @AppStorage("manuallySetAnimation") var manuallySetAnimation: Bool = false

    var showAnimation: Bool {
        if manuallySetAnimation {
            return allowAnimation
        } else {
            return !reduceMotion
        }
    }

    var body: some View {
        HStack(spacing: 15) {
            Spacer()
            StartingImageView(imageId: Critter.allCritters[leftImageIndex].id, frame: 75)
            StartingImageView(imageId: Critter.allCritters[centerImageIndex].id, frame: 150)
            StartingImageView(imageId: Critter.allCritters[rightImageIndex].id, frame: 75)
            Spacer()
        }
        .padding(.vertical)
        .background(.ultraThinMaterial.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .onReceive(imageSwitchTimer) { _ in
            if showAnimation {
                withAnimation(.spring()) {
                    leftImageIndex = (self.leftImageIndex + 1) % Critter.allCritters.count
                    centerImageIndex = (self.centerImageIndex + 1) % Critter.allCritters.count
                    rightImageIndex = (self.rightImageIndex + 1) % Critter.allCritters.count
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
