//
//  ParentalGate.swift
//  CountingCritters
//
//  Created by David Owen on 6/6/24.
//

import SwiftUI

struct ParentalGate: View {
    @Environment(\.dismiss) private var dismiss
    @State var number1: Int = 0
    @State var number2: Int = 0
    @State var sum: Int = 0
    @State var enteredSum = ""

    var body: some View {
        ZStack {
            BackgroundColor(color: AnyView(goldenHour), opacity: 0.2)
            VStack {
                Text("Ask your parents")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.red)
                    .padding(.bottom)

                Group {
                    Text("Your child is trying to leave the app to visit an external website from Critter Counting's attributions.")
                    Text("To continue, please solve this math problem:")
                }
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .foregroundStyle(.red)
                .padding(.horizontal, 15)
                .padding(.bottom)

                Text("\(number1) + \(number2) = \(enteredSum)")
                    .font(.title)

                NumberPad(enteredSum: $enteredSum)

                ButtonRow(displayProceedButton: sum == Int(enteredSum))
            }

        }
        .onAppear {
            number1 = Int.random(in: 0...20)
            number2 = Int.random(in: 0...20)

            sum = number1 + number2
        }
        .onChange(of: enteredSum) {
            if enteredSum.count > 3 {
                enteredSum = String(enteredSum.dropLast())
            }

        }
    }
}

struct ButtonRow: View {
    @Environment(\.dismiss) private var dismiss
    let displayProceedButton: Bool

    var body: some View {
        HStack {
            if displayProceedButton {
                Spacer()
            }
            Button {
                dismiss()
            } label: {
                Text("Dismiss")
                    .padding()
                    .background(.red)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(.white)
            }

            if displayProceedButton {
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Text("Proceed")
                        .padding()
                        .background(.green)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundStyle(.white)
                }
                Spacer()

            }
        }
    }
}

struct NumberPad: View {
    @Binding var enteredSum: String
    var body: some View {
        HStack(spacing: 30) {
            NumberButton(num: "1", answer: $enteredSum)

            NumberButton(num: "2", answer: $enteredSum)

            NumberButton(num: "3", answer: $enteredSum)

        }
        HStack(spacing: 30) {
            NumberButton(num: "4", answer: $enteredSum)

            NumberButton(num: "5", answer: $enteredSum)

            NumberButton(num: "6", answer: $enteredSum)

        }
        HStack(spacing: 30) {
            NumberButton(num: "7", answer: $enteredSum)

            NumberButton(num: "8", answer: $enteredSum)

            NumberButton(num: "9", answer: $enteredSum)

        }
        HStack(spacing: 30) {
            NumberButton(num: "0", answer: $enteredSum)

            NumberButton(num: "DEL", answer: $enteredSum)
        }
    }
}

struct NumberButton: View {
    let num: String
    @Binding var answer: String
    var body: some View {
        Button {
            if num == "DEL" {
                answer = String(answer.dropLast())
            } else {
                answer.append(num)
            }
        } label: {
            ZStack {
                Circle()
                    .frame(width: 60, height: 60)
                    .foregroundStyle(.black.opacity(0.1))
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                Circle()
                    .stroke(lineWidth: 2)
                    .frame(width: 60, height: 60)
                    .foregroundStyle(.black)

                Text(num)
                    .font(.title)
            }
        }
        .foregroundStyle(.black)
    }
}

#Preview {
    ParentalGate()
}
