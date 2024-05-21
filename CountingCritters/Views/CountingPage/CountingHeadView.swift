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
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Spacer()
                    Text("\(vm.pageIsDone ? "You found" : "Find") ^[\(vm.pageCount) \(vm.currentCritter.name)](inflect: true)\(vm.pageIsDone ? "!" : "")")
                        .font(.title)
                        .scaleEffect(1.2)
                        .bold()
                        .foregroundStyle(.white)
                        .shadow(radius: 5)
                        .opacity(0)

                    Spacer()
                }
                .padding(.bottom)
                .background(.ultraThinMaterial.opacity(0.7))
                HStack {
                    Spacer()
                    Text("\(vm.pageIsDone ? "You found" : "Find") ^[\(vm.pageCount) \(vm.currentCritter.name)](inflect: true)\(vm.pageIsDone ? "!" : "")")
                        .font(.title)
                        .scaleEffect(1.2)
                        .bold()
                        .foregroundStyle(.white)
                        .shadow(radius: 5)

                    Spacer()
                }
                .zIndex(1)

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
                        SettingsView() {
                            vm.startGame()
                        }
                        .presentationBackground(.ultraThinMaterial)
                        .presentationDetents([.fraction(0.4)])
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

#Preview {
    CountingHeadView()
}
