//
//  HelperMethods.swift
//  CountingCritters
//
//  Created by David Owen on 5/15/24.
//

import Foundation

func willShowAnimation(manuallySetAnimation: Bool, allowAnimation: Bool, reduceMotion: Bool) -> Bool {
    if manuallySetAnimation {
        return allowAnimation
    } else {
        return !reduceMotion
    }
}
