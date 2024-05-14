//
//  BackgroundGradients.swift
//  CountingCritters
//
//  Created by David Owen on 5/2/24.
//

import Foundation
import SwiftUI

//dislike starlight

extension Color {
    static let customMagenta = Color(red: 1.0, green: 0.0, blue: 1.0) // RGB for magenta
    static let customDarkGray = Color(red: 0.33, green: 0.33, blue: 0.33) // Custom dark gray color
    static let customLightGray = Color(red: 0.75, green: 0.75, blue: 0.75) // Custom light gray color
    static let customLime = Color(red: 0.75, green: 1.0, blue: 0.0) // Custom lime color
    static let coralBlue = Color(red: 0.0, green: 0.5, blue: 0.8) // Custom coral blue
    static let coralPink = Color(red: 1.0, green: 0.4, blue: 0.6) // Custom coral pink
    static let jungleGreen = Color(red: 0.0, green: 0.5, blue: 0.2) // Custom jungle green
    static let canopyGreen = Color(red: 0.2, green: 0.6, blue: 0.3) // Custom canopy green
    static let mossGreen = Color(red: 0.3, green: 0.7, blue: 0.4) // Custom moss green
}

let sunset = LinearGradient(gradient: Gradient(colors: [.pink, .orange]), startPoint: .top, endPoint: .bottom)
let oceanBlue = LinearGradient(gradient: Gradient(colors: [.blue, .cyan]), startPoint: .leading, endPoint: .trailing)
let dusk = LinearGradient(gradient: Gradient(colors: [.purple, .black]), startPoint: .top, endPoint: .bottom)
let forest = LinearGradient(gradient: Gradient(colors: [.green, .brown]), startPoint: .top, endPoint: .bottom)
let winterFrost = LinearGradient(gradient: Gradient(colors: [.white, .blue]), startPoint: .top, endPoint: .bottom)
let fire = LinearGradient(gradient: Gradient(colors: [.red, .yellow]), startPoint: .top, endPoint: .bottom)
let mysticPurple = LinearGradient(gradient: Gradient(colors: [.purple, .indigo]), startPoint: .leading, endPoint: .trailing)
let sunrise = LinearGradient(gradient: Gradient(colors: [.orange, .red]), startPoint: .bottom, endPoint: .top)
let tropical = LinearGradient(gradient: Gradient(colors: [.purple, .indigo]), startPoint: .leading, endPoint: .trailing)
let sandyBeach = LinearGradient(gradient: Gradient(colors: [.yellow, .brown]), startPoint: .top, endPoint: .bottom)

let deepSea = RadialGradient(gradient: Gradient(colors: [.blue, .black]), center: .center, startRadius: 2, endRadius: 650)
let lavenderField = RadialGradient(gradient: Gradient(colors: [.purple, .white]), center: .center, startRadius: 2, endRadius: 500)
let sunGlow = RadialGradient(gradient: Gradient(colors: [.yellow, .orange]), center: .center, startRadius: 2, endRadius: 500)
let alien = RadialGradient(gradient: Gradient(colors: [.green, .black]), center: .center, startRadius: 2, endRadius: 500)
let berrySmoothie = RadialGradient(gradient: Gradient(colors: [.customMagenta, .pink]), center: .center, startRadius: 2, endRadius: 500)

let rainbow = AngularGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple]), center: .center)
let starlight = AngularGradient(gradient: Gradient(colors: [.black, .gray]), center: .center)
let seaBreeze = AngularGradient(gradient: Gradient(colors: [.cyan, .blue, .purple]), center: .center)
let sunsetGlow = AngularGradient(gradient: Gradient(colors: [.orange, .pink, .purple]), center: .center)
let aurora = AngularGradient(gradient: Gradient(colors: [.green, .blue, .purple]), center: .center)

let cherryBlossoms = LinearGradient(gradient: Gradient(colors: [.pink, .white]), startPoint: .top, endPoint: .bottom)
let nightSky = LinearGradient(gradient: Gradient(colors: [.black, .indigo]), startPoint: .top, endPoint: .bottom)
let winterMorning = LinearGradient(gradient: Gradient(colors: [.gray, .white]), startPoint: .top, endPoint: .bottom)
let sunnyDay = LinearGradient(gradient: Gradient(colors: [.blue, .yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
let moonLight = LinearGradient(gradient: Gradient(colors: [.customDarkGray, .customLightGray]), startPoint: .top, endPoint: .bottom)
let freshLime = LinearGradient(gradient: Gradient(colors: [.green, .customLime]), startPoint: .bottom, endPoint: .top)
let passionFruit = LinearGradient(gradient: Gradient(colors: [.orange, .red, .purple]), startPoint: .top, endPoint: .bottom)
let icyBlue = LinearGradient(gradient: Gradient(colors: [.cyan, .white]), startPoint: .leading, endPoint: .trailing)
let goldenHour = LinearGradient(gradient: Gradient(colors: [.yellow, .orange]), startPoint: .top, endPoint: .bottom)
let autumnLeaves = LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow]), startPoint: .bottom, endPoint: .top)

let coralReef = LinearGradient(gradient: Gradient(colors: [.coralBlue, .coralPink]), startPoint: .top, endPoint: .bottom)
let jungle = LinearGradient(gradient: Gradient(colors: [.jungleGreen, .canopyGreen, .mossGreen]), startPoint: .top, endPoint: .bottom)


let allGradients = [
    sunset,
    oceanBlue,
    dusk,
    forest,
    winterFrost,
    fire,
    mysticPurple,
    sunrise,
    tropical,
    sandyBeach,
    deepSea,
    lavenderField,
    sunGlow,
    alien,
    berrySmoothie,
    rainbow,
    starlight,
    seaBreeze,
    sunsetGlow,
    aurora,
    cherryBlossoms,
    nightSky,
    winterMorning,
    sunnyDay,
    moonLight,
    freshLime,
    passionFruit,
    icyBlue,
    goldenHour,
    autumnLeaves,
    coralReef,
    jungle
] as [Any]

let gradientMap = [
    "sunset" : AnyView(sunset),
    "oceanBlue" : AnyView(oceanBlue),
    "dusk" : AnyView(dusk),
    "forest" : AnyView(forest),
    "winterFrost" : AnyView(winterFrost),
    "fire" : AnyView(fire),
    "mysticPurple" : AnyView(mysticPurple),
    "sunrise" : AnyView(sunrise),
    "tropical" : AnyView(tropical),
    "sandyBeach" : AnyView(sandyBeach),
    "deepSea" : AnyView(deepSea),
    "lavenderField" : AnyView(lavenderField),
    "sunGlow" : AnyView(sunGlow),
    "alien" : AnyView(alien),
    "berrySmoothie" : AnyView(berrySmoothie),
    "rainbow" : AnyView(rainbow),
    "starlight" : AnyView(starlight),
    "seaBreeze" : AnyView(seaBreeze),
    "sunsetGlow" : AnyView(sunsetGlow),
    "aurora" : AnyView(aurora),
    "cherryBlossoms" : AnyView(cherryBlossoms),
    "nightSky" : AnyView(nightSky),
    "winterMorning" : AnyView(winterMorning),
    "sunnyDay" : AnyView(sunnyDay),
    "moonLight" : AnyView(moonLight),
    "freshLime" : AnyView(freshLime),
    "passionFruit" : AnyView(passionFruit),
    "icyBlue" : AnyView(icyBlue),
    "goldenHour" : AnyView(goldenHour),
    "autumnLeaves" : AnyView(autumnLeaves),
    "coralReef" : AnyView(autumnLeaves),
    "jungle" : AnyView(jungle)

] as [String : AnyView]

