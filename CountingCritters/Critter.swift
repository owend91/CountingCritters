//
//  Critter.swift
//  CountingCritters
//
//  Created by David Owen on 5/2/24.
//

import Foundation

struct Critter: Decodable, Identifiable {
    let id: String
    let name: String
    let background: String

    static let allCritters = Bundle.main.decode("Critters.json", as: [Critter].self)
    static let example = allCritters[0]
}
