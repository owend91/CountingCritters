//
//  HelperMethods.swift
//  CountingCritters
//
//  Created by David Owen on 5/15/24.
//

import Foundation
import UIKit

func willShowAnimation(manuallySetAnimation: Bool, allowAnimation: Bool, reduceMotion: Bool) -> Bool {
    if manuallySetAnimation {
        return allowAnimation
    } else {
        return !reduceMotion
    }
}

var hasHomeButton: Bool {
    let window = UIApplication
        .shared
        .connectedScenes
        .compactMap { $0 as? UIWindowScene }
        .flatMap { $0.windows }
        .first { $0.isKeyWindow }
    guard let safeAreaBottom =  window?.safeAreaInsets.bottom else {
        return false
    }
    return safeAreaBottom <= 0
}
