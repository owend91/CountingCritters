//
//  StartingViewModelTest.swift
//  CountingCrittersTests
//
//  Created by David Owen on 5/22/24.
//

import XCTest
@testable import CountingCritters

final class StartingViewModelTest: XCTestCase {
    

    func testStartHomePage() throws {
        let vm = StartingViewModel()

        XCTAssertEqual(vm.leftImageIndex, 0, "When the start page loads, the left image index should be 0")
        XCTAssertEqual(vm.centerImageIndex, 1, "When the start page loads, the center image index should be 1")
        XCTAssertEqual(vm.rightImageIndex, 2, "When the start page loads, the right image index should be 2")

    }

    func testUpdateImageOnce() throws {
        let vm = StartingViewModel()
        vm.updateImages()
        XCTAssertEqual(vm.leftImageIndex, 1, "When the image updates once, the left image index should be 1")
        XCTAssertEqual(vm.centerImageIndex, 2, "When the image updates once, the center image index should be 2")
        XCTAssertEqual(vm.rightImageIndex, 3, "When the image updates once, the right image index should be 3")
    }

    func testUpdateImages() throws {
        let vm = StartingViewModel()
        var leftImageIndex = 0
        var centerImageIndex = 1
        var rightImageIndex = 2

        XCTAssertEqual(Critter.allCritters.count, 30, "This verifies that there are 30 critters. If any are added, this test case needs to be updated")

        for i in 0..<Critter.allCritters.count {
            vm.updateImages()

            leftImageIndex = (leftImageIndex + 1) % Critter.allCritters.count
            centerImageIndex = (centerImageIndex + 1) % Critter.allCritters.count
            rightImageIndex = (rightImageIndex + 1) % Critter.allCritters.count
            XCTAssertEqual(vm.leftImageIndex, leftImageIndex, "When the image count is \(i), the left image index should be \(leftImageIndex)")
            XCTAssertEqual(vm.centerImageIndex, centerImageIndex, "When the image count is \(i), the center image index should be \(centerImageIndex)")
            XCTAssertEqual(vm.rightImageIndex, rightImageIndex, "When the image count is \(i), the right image index should be \(rightImageIndex)")
        }

        //Verify no crash after going the image count (currently 30)
        vm.updateImages()
        XCTAssertEqual(vm.leftImageIndex, 1, "When the image updates 31 times, the left image index should be 1")
        XCTAssertEqual(vm.centerImageIndex, 2, "When the image updates 31 times, the center image index should be 2")
        XCTAssertEqual(vm.rightImageIndex, 3, "When the image updates 31 times, the right image index should be 3")
    }
}
