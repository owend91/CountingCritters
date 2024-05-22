//
//  CountingHeaderView.swift
//  CountingCritters
//
//  Created by David Owen on 5/20/24.
//

import SwiftUI

struct CountingHeadView: View {
    @Environment(CountingViewModel.self) var vm
    @State var showingSettings = false
    @Binding var path: NavigationPath

    var body: some View {
        VStack {
            ZStack {
                Group {
                    // This first title text view is just to get the padding correct for the header
                    // The text will be invisible
                    TitleTextView(isVisible: false)
                        .padding(.bottom)
                        .background(.ultraThinMaterial.opacity(0.7))
                    TitleTextView()
                        .zIndex(1)
                }

                HStack {
                    Spacer()
                    Button {
                        showingSettings.toggle()
                    } label: {
                        Image(systemName: "info.circle")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(.regularMaterial)
                            .padding(.trailing)
                            .shadow(radius: 10)
                            .opacity(0.5)
                    }
                    .offset(y: -30)
                    .sheet(isPresented: $showingSettings) {
                        SettingsView(path: $path) {
                            vm.restartGame()
                        } newGame: {
                            vm.startGame()
                        } quitGame: {
                            vm.quitGame()
                        }
                        .presentationBackground(.ultraThinMaterial)
                        .presentationDetents([.fraction(0.5)])
                        .presentationDragIndicator(.visible)
                    }
                }
                .zIndex(vm.pageIsDone ? 0 : 2)
            }
            Spacer()
        }
        .shadow(radius: 10)
    }
}

struct TitleTextView: View {
    @Environment(CountingViewModel.self) var vm
    @State var isVisible = true
    var titleText: String {
        String(AttributedString(localized: "\(vm.pageIsDone ? "You found" : "Find") ^[\(vm.pageCount) \(vm.currentCritter.name)](inflect: true)\(vm.pageIsDone ? "!" : "")").characters)
    }
    var body: some View {
        HStack {
            Spacer()
            Text(titleText)
                .font(.title)
                .scaleEffect(1.2)
                .bold()
                .foregroundStyle(.white)
                .opacity(isVisible ? 1: 0)
            Spacer()
        }
    }
}

#Preview {
    CountingHeadView(path: .constant(NavigationPath()))
        .environment(CountingViewModel())
}
