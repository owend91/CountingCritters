//
//  CountingViewModel.swift
//  CountingCritters
//
//  Created by David Owen on 4/30/24.
//

import Foundation

@Observable
class CountingViewModel {
    var pageCount = 1
    var tapCount = 0

    var layout: [Int] = []
    var currentTaps: [Int] = []

    var critterPages: [Critter] = []
    var currentCritter: Critter {
        if critterPages.isEmpty {
            Critter.example
        } else {
            critterPages[pageCount - 1]
        }
    }

    func startGame() {
        currentTaps.removeAll()
        pageCount = 1
        tapCount = 0
        determineLayout()

        let allCritters = Critter.allCritters.shuffled()
        critterPages = Array(allCritters[0...8])
    }

    func nextPage() {
        currentTaps.removeAll()
        pageCount += 1
        tapCount = 0
        determineLayout()
        print("page count: \(pageCount)")
        print("layout: \(layout)")
    }

    func determineLayout() {
        layout.removeAll()
        var alreadyUsed: [Int] = []

        for _ in 0..<pageCount {
            var gridLocation = Int.random(in: 1...9)

            while alreadyUsed.contains(gridLocation) {
                gridLocation = Int.random(in: 1...9)
            }
            alreadyUsed.append(gridLocation)
            layout.append(gridLocation)
        }
    }
}
