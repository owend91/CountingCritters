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
    @AppStorage("allowHaptics") var allowHaptics: Bool =  false
    @State var restartPressed = false
    @Binding var path: NavigationPath

    var restartGame: (() -> Void)?
    var newGame: (() -> Void)?
    var quitGame: (() -> Void)?

    var body: some View {
        VStack {
            Form {
                Section {
                    VStack {
                        Toggle("Allow Animation", isOn: $allowAnimation)
                            .onChange(of: allowAnimation) {
                                manuallySetAnimation = true
                            }

                        Divider()
                            .padding(0.5)

                        Toggle("Allow Haptics", isOn: $allowHaptics)
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
                            Text("Critter icons used under Creative Commons CC0. Created by [Kenney](https://kenney.nl/assets/animal-pack-redux)")
                                .multilineTextAlignment(.center)
                                .font(.footnote)
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Text("App Icon created using [ChatGPT](https://chatgpt.com)")
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
                if let _ = restartGame {
                    Section {
                        Button(role: .destructive) {
                            restartPressed.toggle()
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
            Spacer()
        }
        .confirmationDialog("Exit", isPresented: $restartPressed) {
            Group {
                Button("Same Critters") {
                    restartGame!()
                    dismiss()
                }
                Button("New Critters") {
                    newGame!()
                    dismiss()
                }
                Button("Exit Game") {
                    quitGame!()
                    dismiss()
                    path = NavigationPath()
                }
            }
        } message: {
            Text("Want to count again?")
        }
        .listSectionSpacing(.leastNonzeroMagnitude)
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    SettingsView(path: .constant(NavigationPath()), newGame:  {})
}
