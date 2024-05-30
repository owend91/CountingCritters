//
//  CountingCrittersUITests.swift
//  CountingCrittersUITests
//
//  Created by David Owen on 5/29/24.
//

import XCTest

final class CountingCrittersUITests: XCTestCase {
    let pluralAnimalsEndingInE = ["giraffes", "horses", "crocodiles", "snakes", "whales"]

    var app: XCUIApplication!


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app = XCUIApplication()
        app.launch()
    }

    func testStartScreen() {
        XCTAssertTrue(app.buttons["Start"].exists, "There should be a Start button on launch.")
        XCTAssertTrue(app.staticTexts["Critter Counting"].exists, "There should be a 'Critter Counting' title label on launch.")

        var imageNames: [String] = []
        XCTAssertEqual(app.images.count, 3, "There should be 3 images on launch")

        //Get the three images, then make sure the images exist
        for image in app.images.allElementsBoundByIndex {
            imageNames.append(image.label)
        }
        for imageName in imageNames {
            XCTAssertTrue(app.images[imageName].exists, "There should still be a '\(imageName)' image when on launch")
        }

        XCTAssertTrue(app.buttons["Info"].exists, "There should be a 'info' button on launch.")
    }

    func testStartScreenAnimation() {
        XCTAssertTrue(app.buttons["Start"].exists, "There should be a Start button on launch.")
        XCTAssertTrue(app.staticTexts["Critter Counting"].exists, "There should be a 'Critter Counting' title label on launch.")

        var imageNames: [String] = []
        XCTAssertEqual(app.images.count, 3, "There should be 3 images on launch")

        //Get the three images, then make sure the images exist
        for image in app.images.allElementsBoundByIndex {
            imageNames.append(image.label)
        }
        for imageName in imageNames {
            XCTAssertTrue(app.images[imageName].exists, "There should still be a '\(imageName)' image when on launch")
        }

        sleep(1)

        var newImageNames: [String] = []
        XCTAssertEqual(app.images.count, 3, "There should be 3 images on after animation")

        //Check the images after the animation runs
        for image in app.images.allElementsBoundByIndex {
            newImageNames.append(image.label)
        }
        for imageName in newImageNames {
            XCTAssertTrue(app.images[imageName].exists, "There should still be a '\(imageName)' image when on animation")
        }
        XCTAssertFalse(app.images[imageNames.first!].exists, "There should no longer be a \(imageNames.first!) after the animation runs.")
        XCTAssertEqual(imageNames[1], newImageNames[0], "There should still be a '\(imageNames[1])' image after the animation runs.")
        XCTAssertEqual(imageNames[2], newImageNames[1], "There should still be a '\(imageNames[1])' image after the animation runs.")

    }

    func testInfoButton() {
        app.buttons["Info"].tap()

        XCTAssertTrue(app.switches["Allow Animation"].exists, "There should be an Allow Animation toggle.")
        XCTAssertTrue(app.switches["Allow Haptics"].exists, "There should be a Allow Haptics toggle.")

        app.switches["Allow Animation"].swipeDown()

    }

    func testDisableAnimation() {
        app.buttons["Info"].tap()

        app.switches["Allow Animation"].switches.firstMatch.tap()
        app.tap()

        var imageNames: [String] = []
        for image in app.images.allElementsBoundByIndex {
            imageNames.append(image.label)
        }
        //When animation enabled, the image switches every second. Wait 2 seconds to make sure all the images are still the same
        sleep(2)
        for imageName in imageNames {
            XCTAssertTrue(app.images[imageName].exists, "There should still be a '\(imageName)' image when the animation is paused")
        }

        //re enable animations
        app.buttons["Info"].tap()
        app.switches["Allow Animation"].switches.firstMatch.tap()
        app.tap()
    }

    func testStartGame() {
        app.buttons["Start"].tap()
        print(app.staticTexts.firstMatch.label)
        let critter = app.staticTexts.firstMatch.label.split(separator: " ")[2]
        print(critter)
        var imageCount = 0
        for image in app.images.allElementsBoundByIndex {
            imageCount += 1
            XCTAssertEqual(String(critter), image.label, "The images should be of \(critter)")
        }
        XCTAssertEqual(imageCount, app.images.allElementsBoundByIndex.count, "There should be \(imageCount) images")

    }

    func testFullGame() {
        app.buttons["Start"].tap()

        for pageCount in 0..<9 {
            let critter = app.staticTexts.firstMatch.label.split(separator: " ")[2]
            print(app.staticTexts.firstMatch.label)
            print(critter)

            var imageCount = 0
            for image in app.images.allElementsBoundByIndex {
                imageCount += 1
                if pageCount == 0 {
                    XCTAssertEqual(String(critter), image.label, "The images should be of \(critter)")
                } else {
                    var nonPluralCritter = String(critter)
                    if nonPluralCritter.hasSuffix("es") && !pluralAnimalsEndingInE.contains(nonPluralCritter) {
                        nonPluralCritter.removeLast()
                        nonPluralCritter.removeLast()
                    } else if nonPluralCritter.hasSuffix("s"){
                        nonPluralCritter.removeLast()
                    }
                    XCTAssertEqual(nonPluralCritter, image.label, "The images should be of \(critter)")
                }
                image.tap()
                XCTAssertEqual("\(imageCount)", app.staticTexts["tapCounter"].label, "The counter should say \(imageCount)")

            }
            XCTAssertEqual(imageCount, app.images.allElementsBoundByIndex.count, "There should be \(imageCount) images")
            if pageCount != 8 {
                XCTAssertTrue(app.buttons["Next"].exists, "There should still be a Next button when all critters are tapped")
                app.buttons["Next"].tap()
            } else {
                XCTAssertTrue(app.staticTexts["Congratulations! Count again?"].exists, "There should be a congratulations confirmation dialogue when completing the game")
                XCTAssertTrue(app.buttons["Same Critters"].exists, "There should be a same critters button")
                XCTAssertTrue(app.buttons["New Critters"].exists, "There should be a new critters button")
                XCTAssertTrue(app.buttons["Exit Game"].exists, "There should be an exit game button")

                app.buttons["Exit Game"].tap()

                XCTAssertTrue(app.staticTexts["Critter Counting"].waitForExistence(timeout: 1), "There should be a 'Critter Counting' title label when exiting the game.")
            }
        }
    }

    func testFullGameRestartSameCritters() {
        app.buttons["Start"].tap()
        var originalCritters = [String]()

        for pageCount in 0..<9 {
            let critter = app.staticTexts.firstMatch.label.split(separator: " ")[2]
            print(app.staticTexts.firstMatch.label)
            print(critter)
            originalCritters.append(String(critter))

            var imageCount = 0
            for image in app.images.allElementsBoundByIndex {
                imageCount += 1
                if pageCount == 0 {
                    XCTAssertEqual(String(critter), image.label, "The images should be of \(critter)")
                } else {
                    var nonPluralCritter = String(critter)
                    if nonPluralCritter.hasSuffix("es") && !pluralAnimalsEndingInE.contains(nonPluralCritter) {
                        nonPluralCritter.removeLast()
                        nonPluralCritter.removeLast()
                    } else if nonPluralCritter.hasSuffix("s"){
                        nonPluralCritter.removeLast()
                    }
                    XCTAssertEqual(nonPluralCritter, image.label, "The images should be of \(critter)")
                }
                image.tap()
                XCTAssertEqual("\(imageCount)", app.staticTexts["tapCounter"].label, "The counter should say \(imageCount)")

            }
            XCTAssertEqual(imageCount, app.images.allElementsBoundByIndex.count, "There should be \(imageCount) images")
            if pageCount != 8 {
                XCTAssertTrue(app.buttons["Next"].exists, "There should still be a Next button when all critters are tapped")
                app.buttons["Next"].tap()
            } else {
                XCTAssertTrue(app.staticTexts["Congratulations! Count again?"].exists, "There should be a congratulations confirmation dialogue when completing the game")
                XCTAssertTrue(app.buttons["Same Critters"].exists, "There should be a same critters button")
                XCTAssertTrue(app.buttons["New Critters"].exists, "There should be a new critters button")
                XCTAssertTrue(app.buttons["Exit Game"].exists, "There should be an exit game button")

                app.buttons["Same Critters"].tap()
                sleep(1)
                for newPageCount in 0..<9 {
                    let newCritter = app.staticTexts.firstMatch.label.split(separator: " ")[2]
                    XCTAssertEqual(originalCritters[newPageCount], String(newCritter), "The critter on page \(newPageCount) should be \(originalCritters[newPageCount])")

                    for image in app.images.allElementsBoundByIndex {
                        image.tap()
                    }

                    if newPageCount != 8 {
                        XCTAssertTrue(app.buttons["Next"].exists, "There should still be a Next button when all critters are tapped")
                        app.buttons["Next"].tap()
                    } else {
                        XCTAssertTrue(app.staticTexts["Congratulations! Count again?"].exists, "There should be a congratulations confirmation dialogue when completing the game")
                        XCTAssertTrue(app.buttons["Same Critters"].exists, "There should be a same critters button")
                        XCTAssertTrue(app.buttons["New Critters"].exists, "There should be a new critters button")
                        XCTAssertTrue(app.buttons["Exit Game"].exists, "There should be an exit game button")

                        app.buttons["Exit Game"].tap()
                    }
                }
            }
        }
    }

    func testFullGameRestartDifferentCritters() {
        app.buttons["Start"].tap()
        var originalCritters = [String]()

        for pageCount in 0..<9 {
            let critter = app.staticTexts.firstMatch.label.split(separator: " ")[2]
            print(app.staticTexts.firstMatch.label)
            print(critter)
            originalCritters.append(String(critter))

            var imageCount = 0
            for image in app.images.allElementsBoundByIndex {
                imageCount += 1
                if pageCount == 0 {
                    XCTAssertEqual(String(critter), image.label, "The images should be of \(critter)")
                } else {
                    var nonPluralCritter = String(critter)
                    if nonPluralCritter.hasSuffix("es") && !pluralAnimalsEndingInE.contains(nonPluralCritter) {
                        nonPluralCritter.removeLast()
                        nonPluralCritter.removeLast()
                    } else if nonPluralCritter.hasSuffix("s"){
                        nonPluralCritter.removeLast()
                    }
                    XCTAssertEqual(nonPluralCritter, image.label, "The images should be of \(critter)")
                }
                image.tap()
                XCTAssertEqual("\(imageCount)", app.staticTexts["tapCounter"].label, "The counter should say \(imageCount)")

            }
            XCTAssertEqual(imageCount, app.images.allElementsBoundByIndex.count, "There should be \(imageCount) images")
            if pageCount != 8 {
                XCTAssertTrue(app.buttons["Next"].exists, "There should still be a Next button when all critters are tapped")
                app.buttons["Next"].tap()
            } else {
                XCTAssertTrue(app.staticTexts["Congratulations! Count again?"].exists, "There should be a congratulations confirmation dialogue when completing the game")
                XCTAssertTrue(app.buttons["Same Critters"].exists, "There should be a same critters button")
                XCTAssertTrue(app.buttons["New Critters"].exists, "There should be a new critters button")
                XCTAssertTrue(app.buttons["Exit Game"].exists, "There should be an exit game button")

                app.buttons["New Critters"].tap()
                sleep(1)
                var newCritters = [String]()

                for newPageCount in 0..<9 {
                    let newCritter = app.staticTexts.firstMatch.label.split(separator: " ")[2]
                    newCritters.append(String(newCritter))
                    for image in app.images.allElementsBoundByIndex {
                        image.tap()
                    }

                    if newPageCount != 8 {
                        XCTAssertTrue(app.buttons["Next"].exists, "There should still be a Next button when all critters are tapped")
                        app.buttons["Next"].tap()
                    } else {
                        XCTAssertTrue(app.staticTexts["Congratulations! Count again?"].exists, "There should be a congratulations confirmation dialogue when completing the game")
                        XCTAssertTrue(app.buttons["Same Critters"].exists, "There should be a same critters button")
                        XCTAssertTrue(app.buttons["New Critters"].exists, "There should be a new critters button")
                        XCTAssertTrue(app.buttons["Exit Game"].exists, "There should be an exit game button")
                        XCTAssertNotEqual(originalCritters, newCritters, "Original Critters and new critters should not be the same. Although, this is random, so it is possible. If this fails, try running again.")

                        app.buttons["Exit Game"].tap()
                    }
                }
            }
        }
    }
}
