//
//  BackgroundColor.swift
//  CountingCritters
//
//  Created by David Owen on 5/17/24.
//

import SwiftUI

struct BackgroundColor: View {
    let color: AnyView
    var opacity = 1.0
    var body: some View {
        color.opacity(opacity).ignoresSafeArea()
    }
}

#Preview {
    BackgroundColor(color: AnyView(goldenHour))
}
