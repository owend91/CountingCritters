//
//  CountingCrittersTests.swift
//  CountingCrittersTests
//
//  Created by David Owen on 5/7/24.
//

import XCTest
@testable import CountingCritters

final class CountingViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testStartGame() throws {
        let vm = CountingViewModel()

        vm.startGame()
        XCTAssertEqual(vm.tapCount, 0, "At game start, the tap count should be 0")
        XCTAssertEqual(vm.layout.count, 1, "At game start, there should be one value in the layout")

    }

    func testTapFirstCritter() throws {
        let vm = CountingViewModel()

        vm.startGame()
        XCTAssertEqual(vm.tapCount, 0, "At game start, the tap count should be 0")
        XCTAssertEqual(vm.layout.count, 1, "At game start, there should be one value in the layout")

        let whereToTap = vm.layout[0]
        vm.tapCount += 1
        vm.tapDictionary[whereToTap] = vm.tapCount

        XCTAssertEqual(vm.tapCount, 1, "Tap Count should be 1 after tapping the first page")
        XCTAssertEqual(vm.tapDictionary[vm.layout[0]], vm.tapCount, "The first page should have a '1' on the only tapable location")
        XCTAssertTrue(vm.pageIsDone, "First page should be complete")
    }

    func testNextPage() throws {
        let vm = CountingViewModel()

        vm.startGame()
        XCTAssertEqual(vm.tapCount, 0, "At game start, the tap count should be 0")
        XCTAssertEqual(vm.layout.count, 1, "At game start, there should be one value in the layout")

        let whereToTap = vm.layout[0]
        vm.tapCount += 1
        vm.tapDictionary[whereToTap] = vm.tapCount

        XCTAssertEqual(vm.tapCount, 1, "Tap Count should be 1 after tapping the first page")
        XCTAssertEqual(vm.tapDictionary[vm.layout[0]], vm.tapCount, "The first page should have a '1' on the only tapable location")
        XCTAssertTrue(vm.pageIsDone, "First page should be complete")

        vm.nextPage()
        XCTAssertEqual(vm.tapCount, 0, "Tap Count should be 0 on a new page")
        XCTAssertEqual(vm.layout.count, 2, "On the second page, there should be 2 critters to tap")
        XCTAssertTrue(vm.tapDictionary.isEmpty, "On a new page the tap dictionary should be empty")

    }

    func testRestartGame() throws {
        let vm = CountingViewModel()

        vm.startGame()
        XCTAssertEqual(vm.tapCount, 0, "At game start, the tap count should be 0")
        XCTAssertEqual(vm.layout.count, 1, "At game start, there should be one value in the layout")

        let whereToTap = vm.layout[0]
        vm.tapCount += 1
        vm.tapDictionary[whereToTap] = vm.tapCount

        XCTAssertEqual(vm.tapCount, 1, "Tap Count should be 1 after tapping the first page")
        XCTAssertEqual(vm.tapDictionary[vm.layout[0]], vm.tapCount, "The first page should have a '1' on the only tapable location")
        XCTAssertTrue(vm.pageIsDone, "First page should be complete")

        vm.nextPage()
        XCTAssertEqual(vm.tapCount, 0, "Tap Count should be 0 on a new page")
        XCTAssertEqual(vm.layout.count, 2, "On the second page, there should be 2 critters to tap")

        let critters = vm.critterPages
        vm.restartGame()
        XCTAssertEqual(vm.tapCount, 0, "Tap Count should be 0 on a new page")
        XCTAssertEqual(vm.layout.count, 1, "When the game restarts, there should be one value in the layout")
        XCTAssertEqual(critters, vm.critterPages, "When the game restarts, the critter pages should be the same")
        XCTAssertTrue(vm.tapDictionary.isEmpty, "When the game is restarted, the tap dictionary should be empty")


    }

    func testStartNewGame() throws {
        let vm = CountingViewModel()

        vm.startGame()
        XCTAssertEqual(vm.tapCount, 0, "At game start, the tap count should be 0")
        XCTAssertEqual(vm.layout.count, 1, "At game start, there should be one value in the layout")

        let whereToTap = vm.layout[0]
        vm.tapCount += 1
        vm.tapDictionary[whereToTap] = vm.tapCount

        XCTAssertEqual(vm.tapCount, 1, "Tap Count should be 1 after tapping the first page")
        XCTAssertEqual(vm.tapDictionary[vm.layout[0]], vm.tapCount, "The first page should have a '1' on the only tapable location")
        XCTAssertTrue(vm.pageIsDone, "First page should be complete")

        vm.nextPage()
        XCTAssertEqual(vm.tapCount, 0, "Tap Count should be 0 on a new page")
        XCTAssertEqual(vm.layout.count, 2, "On the second page, there should be 2 critters to tap")

        let critters = vm.critterPages
        vm.startGame()
        XCTAssertEqual(vm.tapCount, 0, "Tap Count should be 0 on a new page")
        XCTAssertEqual(vm.layout.count, 1, "When the game restarts, there should be one value in the layout")
        XCTAssertNotEqual(critters, vm.critterPages, "When the game starts over, the critter pages should be different.  Since it is random, they could technically be the same, but not likely. Try rerunning this case if it fails.")
        XCTAssertTrue(vm.tapDictionary.isEmpty, "When the game restarts, the tap dictionary should be empty")

    }

    func testQuitGame() throws {
        let vm = CountingViewModel()

        vm.startGame()
        XCTAssertEqual(vm.tapCount, 0, "At game start, the tap count should be 0")
        XCTAssertEqual(vm.layout.count, 1, "At game start, there should be one value in the layout")

        let whereToTap = vm.layout[0]
        vm.tapCount += 1
        vm.tapDictionary[whereToTap] = vm.tapCount

        XCTAssertEqual(vm.tapCount, 1, "Tap Count should be 1 after tapping the first page")
        XCTAssertEqual(vm.tapDictionary[vm.layout[0]], vm.tapCount, "The first page should have a '1' on the only tapable location")
        XCTAssertTrue(vm.pageIsDone, "First page should be complete")

        vm.nextPage()
        XCTAssertEqual(vm.tapCount, 0, "Tap Count should be 0 on a new page")
        XCTAssertEqual(vm.layout.count, 2, "On the second page, there should be 2 critters to tap")

        let critters = vm.critterPages
        vm.quitGame()
        XCTAssertEqual(vm.tapCount, 0, "Tap Count should be 0 on a new page")
        XCTAssertEqual(vm.layout.count, 0, "When the game is quit, the layout should be empty")
        XCTAssertEqual(vm.critterPages.count, 0, "When the game is quit, the critters should be empty")
        XCTAssertTrue(vm.tapDictionary.isEmpty, "When the game is quit, the tap dictionary should be empty")

    }

    func testAllPages() throws {
        let vm = CountingViewModel()

        vm.startGame()
        XCTAssertEqual(vm.tapCount, 0, "At game start, the tap count should be 0")
        XCTAssertEqual(vm.layout.count, 1, "At game start, there should be one value in the layout")

        for i in 0..<9 {
            print("page: \(i)")
            var localTapDictionary: [Int: Int] = [:]
            for j in 0..<vm.layout.count {
                let whereToTap = vm.layout[j]
                vm.tapCount += 1
                vm.tapDictionary[whereToTap] = vm.tapCount
                localTapDictionary[whereToTap] = vm.tapCount

                XCTAssertEqual(vm.tapCount, j + 1, "Tap Count should be \(j + 1) for the \(j) layout on page \(i)")
                XCTAssertEqual(vm.tapDictionary[vm.layout[j]], vm.tapCount, "The \(j) layout position should have a tap count of \(vm.tapCount)")
                XCTAssertTrue(vm.hasCritterBeenTapped(whereToTap), "The critter should have been tapped at location \(whereToTap)")
            }
            XCTAssertEqual(localTapDictionary, vm.tapDictionary, "The tap dictionary should be the same as the local tap dictionary")
            XCTAssertTrue(vm.pageIsDone, "\(i + 1) page should be complete")
            if i != 8 {
                vm.nextPage()
                XCTAssertEqual(vm.tapCount, 0, "Tap Count should be 0 on a new page")
                XCTAssertEqual(vm.layout.count, i + 2, "On page \(i + 1), there should be \(i + 2) critters to tap")
                XCTAssertTrue(vm.tapDictionary.isEmpty, "On a new page the tap dictionary should be empty")
            } else {
                XCTAssertTrue(vm.gameIsDone, "On page \(i + 1), the game should be complete")
            }
        }
    }
}
