//
//  StartingViewModel.swift
//  CountingCritters
//
//  Created by David Owen on 5/15/24.
//

import Foundation

@Observable
class StartingViewModel {
    var leftImageIndex = 0
    var centerImageIndex = 1
    var rightImageIndex = 2

    func updateImages() {
        leftImageIndex = (leftImageIndex + 1) % Critter.allCritters.count
        centerImageIndex = (centerImageIndex + 1) % Critter.allCritters.count
        rightImageIndex = (rightImageIndex + 1) % Critter.allCritters.count
    }
}
