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
    @State var leftImageIndex = 0
    @State var centerImageIndex = 1 // Index of the currently displayed image
    @State var rightImageIndex = 2
    @State var displaySettings = false


    let imageSwitchTimer = Timer.publish(every: 2, on: .main, in: .common)
                                .autoconnect()
    var body: some View {
        NavigationStack {
            ZStack {
                goldenHour.opacity(0.5).ignoresSafeArea()
                VStack {
                    HStack {
                        Spacer()
                        Button {

                        } label: {
                            Image(systemName: "info.circle")
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .foregroundStyle(.regularMaterial)
                                .padding(.trailing)
                        }
                    }
                    Spacer()

                    Text("Counting Critters")
                        .font(.system(size: 45, weight: .bold, design: .rounded))
                        .foregroundStyle(Color.darkNavy)
                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                    Spacer()
                    HStack(spacing: 15) {
                        Spacer()
                        Image(Critter.allCritters[leftImageIndex].id)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 75, height: 75)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            .transition(.slide)

                        Image(Critter.allCritters[centerImageIndex].id)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            .transition(.slide)

                        Image(Critter.allCritters[rightImageIndex].id)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 75, height: 75)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            .transition(.slide)

                        Spacer()
                    }
                    .padding(.vertical)
                    .background(.ultraThinMaterial.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .onReceive(imageSwitchTimer) { _ in
                        withAnimation(.spring()) {
                            leftImageIndex = (self.leftImageIndex + 1) % Critter.allCritters.count
                            centerImageIndex = (self.centerImageIndex + 1) % Critter.allCritters.count
                            rightImageIndex = (self.rightImageIndex + 1) % Critter.allCritters.count
                        }
                    }

                    Spacer()

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
            .preferredColorScheme(.light)
        }
    }
}

#Preview {
    StartingView()
}
