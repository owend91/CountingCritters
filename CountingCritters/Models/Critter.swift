//
//  Critter.swift
//  CountingCritters
//
//  Created by David Owen on 5/2/24.
//

import Foundation

struct Critter: Decodable, Identifiable, Equatable {
    let id: String
    let name: String
    let background: String

//    var backgrounGradient: Any {
//        return allGradients[background]
//    }

    static let allCritters = Bundle.main.decode("Critters.json", as: [Critter].self)
    static let example = allCritters[0]

    static func ==(lhs: Critter, rhs: Critter) -> Bool {
        return lhs.id == rhs.id
    }

}
