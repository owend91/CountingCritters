//
//  InfoSettingButton.swift
//  CountingCritters
//
//  Created by David Owen on 5/15/24.
//

import SwiftUI

struct InfoSettingButton: View {
    @Binding var showingSettings: Bool
    var body: some View {
        HStack {
            Spacer()
            Button {
                showingSettings.toggle()
            } label: {
                Image(systemName: "info.circle")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.regularMaterial)
                    .padding(.trailing)
            }
            .accessibilityIdentifier("Info")
        }
    }
}

#Preview {
    InfoSettingButton(showingSettings: .constant(true))
}
