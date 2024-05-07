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
    var imageTranslations: [ImageTranslation] = []

    var tapDictionary: [Int: Int] = [:]
    var currentTaps: [Int] {
        Array(tapDictionary.keys)
    }

    var pageIsDone: Bool {
        tapCount == pageCount
    }

    var critterPages: [Critter] = []
    var currentCritter: Critter {
        if critterPages.isEmpty {
            Critter.example
        } else {
            critterPages[pageCount - 1]
        }
    }

    func startGame() {
        tapDictionary.removeAll()
        pageCount = 1
        tapCount = 0
        determineLayout()

        let allCritters = Critter.allCritters.shuffled()
        critterPages = Array(allCritters[0...8])
    }

    func nextPage() {
        tapDictionary.removeAll()
        pageCount += 1
        tapCount = 0
        determineLayout()
    }

    private func determineLayout() {
        layout.removeAll()
        imageTranslations.removeAll()

        var alreadyUsed: [Int] = []
        imageTranslations = Array(repeating: ImageTranslation(), count: 9)
        for _ in 0..<pageCount {
            var gridLocation = Int.random(in: 0...8)
            var translation = ImageTranslation()
            translation.scale = Double.random(in: 0.4...1)
            translation.y = Double.random(in: -25...25)
            translation.x = Double.random(in: -25...25)
            translation.rotation = Double.random(in: 0...360)
            translation.shadow = Double.random(in: 0...10)


            while alreadyUsed.contains(gridLocation) {
                gridLocation = Int.random(in: 0...8)
            }
            alreadyUsed.append(gridLocation)
            layout.append(gridLocation)
            imageTranslations[gridLocation] = translation
        }
        print("📈 layout: \(layout)")
    }
}
