//
//  SettingsView.swift
//  CountingCritters
//
//  Created by David Owen on 5/14/24.
//

import SwiftUI

extension String: Identifiable {
    public var id: String {self}
}

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("allowAnimation") var allowAnimation: Bool = true
    @AppStorage("manuallySetAnimation") var manuallySetAnimation: Bool =  false
    @AppStorage("allowHaptics") var allowHaptics: Bool =  false
    @State var restartPressed = false
    @Binding var path: NavigationPath
    @State var displayParentalGate = false
    @State var urlString: String?

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
                            .accessibilityIdentifier("Allow Animation")

                        Divider()
                            .padding(0.5)

                        Toggle("Allow Haptics", isOn: $allowHaptics)
                            .accessibilityIdentifier("Allow Haptics")

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
                            HStack {
                                Text("Critter icons used under Creative Commons CC0. Created by ") +
                                Text("Kenney")
                                    .foregroundStyle(.link)
                            }
                            .multilineTextAlignment(.center)
                            .font(.footnote)
                            .onTapGesture {
                                urlString = "https://kenney.nl/assets/animal-pack-redux"
                            }
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            HStack {
                                Text("App Icon created using ") +
                                Text("ChatGPT")
                                    .foregroundStyle(.link)
                            }
                            .multilineTextAlignment(.center)
                            .font(.footnote)
                            .onTapGesture {
                                urlString = "https://chatgpt.com"
                            }
                            Spacer()
                        }
                    }
                    .listRowBackground(Color.clear)
                    .padding()
                    .background(.thinMaterial)
                    .mask {
                        RoundedRectangle(cornerRadius: 10)
                    }
                    .sheet(item: $urlString) { url in
                        ParentalGate(urlString: url)
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
