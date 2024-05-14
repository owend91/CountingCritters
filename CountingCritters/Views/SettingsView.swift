//
//  SettingsView.swift
//  CountingCritters
//
//  Created by David Owen on 5/14/24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("allowAnimation") var allowAnimation: Bool = true
    @AppStorage("manuallySetAnimation") var manuallySetAnimation: Bool =  false
    var restartGame: (() -> Void)?
//    var showRestartButton = false

    var body: some View {
        Form {
            Section {
                VStack {
                    Toggle("Allow Animation", isOn: $allowAnimation)
                        .onChange(of: allowAnimation) {
                            manuallySetAnimation = true
                        }
                }
                .listRowBackground(Color.clear)
                .padding()
                .background(.thinMaterial)
                .mask {
                    RoundedRectangle(cornerRadius: 10)
                }
            }
            Section {
                VStack {
                    HStack {
                        Spacer()
                        Text("Icons used under Creative Commons CC0. Created by [Kenney](https://kenney.nl/assets/animal-pack-redux)")
                            .multilineTextAlignment(.center)
                            .font(.footnote)
                        Spacer()
                    }
                }
                .listRowBackground(Color.clear)
                .padding()
                .background(.thinMaterial)
                .mask {
                    RoundedRectangle(cornerRadius: 10)
                }
            }
            if let restartGame {
                Section {
                    Button(role: .destructive) {
                        restartGame()
                        dismiss()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Restart!")
                            Spacer()
                        }
                    }
                    .buttonStyle(BorderedProminentButtonStyle())
                    .listRowBackground(Color.clear)
                }
            }
        }
        .listSectionSpacing(.leastNonzeroMagnitude)
        .scrollContentBackground(.hidden)
    }

}

#Preview {
    SettingsView() {}
}
