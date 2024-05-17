//
//  StartingView.swift
//  CountingCritters
//
//  Created by David Owen on 4/30/24.
//

import SwiftUI

extension Color {
    static let darkNavy = Color(red: 0.05, green: 0.1, blue: 0.25)
}

struct StartingView: View {
    @State var showingSettings = false
    @State var vm = StartingViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundColor(color: AnyView(goldenHour), opacity: 0.5)
                VStack {
                    InfoSettingButton(showingSettings: $showingSettings)
                        .sheet(isPresented: $showingSettings) {
                            SettingsView()
                                .presentationBackground(.ultraThinMaterial)
                                .presentationDetents([.fraction(0.3)])
                                .presentationDragIndicator(.visible)
                        }

                    Spacer()

                    StartingTitleView()

                    Spacer()

                    StartingImageCarouselView()
                        .environment(vm)

                    Spacer()

                    StartButton()
                }
            }
            .preferredColorScheme(.light)
        }
    }
}

struct StartingTitleView: View {
    var body: some View {
        Text("Counting Critters")
            .font(.system(size: 45, weight: .bold, design: .rounded))
            .foregroundStyle(Color.darkNavy)
            .shadow(color: .gray, radius: 2, x: 0, y: 2)
    }
}

struct StartButton: View {
    var body: some View {
        NavigationLink(destination: CountingView()) {
            HStack {
                Spacer()
                Text("Start")
                    .font(.title)
                    .bold()
                Spacer()

            }
            .padding()
            .background(Color.darkNavy)
            .foregroundStyle(.yellow)
        }
    }
}

#Preview {
    StartingView()
}
