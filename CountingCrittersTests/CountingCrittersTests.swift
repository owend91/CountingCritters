//
//  CountingCrittersTests.swift
//  CountingCrittersTests
//
//  Created by David Owen on 5/7/24.
//

import XCTest
@testable import CountingCritters

final class CountingCrittersTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testStartGame() throws {
        let vm = CountingViewModel()

        vm.startGame()
        XCTAssertEqual(vm.tapCount, 0, "At game start, the tap count should be 0")
        XCTAssertEqual(vm.layout.count, 1, "At game start, there should be one value in the layout")

    }
}
