//
//  SettingsView.swift
//  CountingCritters
//
//  Created by David Owen on 5/14/24.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("allowAnimation") var allowAnimation: Bool = true
    @AppStorage("manuallySetAnimation") var manuallySetAnimation: Bool =  false
    var body: some View {
        ZStack {
            goldenHour.ignoresSafeArea()

            VStack {
                Form {
                    Toggle("Allow Animation", isOn: $allowAnimation)
                        .onChange(of: allowAnimation) { 
                            manuallySetAnimation = true
                        }
                }
                .scrollContentBackground(.hidden)
            }
        }
    }
}

#Preview {
    SettingsView()
}
