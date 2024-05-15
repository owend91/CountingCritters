//
//  StartingImageView.swift
//  CountingCritters
//
//  Created by David Owen on 5/15/24.
//

import SwiftUI

struct StartingImageView: View {
    let imageId: String
    let frame: CGFloat

    var body: some View {
        Image(imageId)
            .resizable()
            .scaledToFit()
            .frame(width: frame, height: frame)
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            .transition(.slide)
    }
}

#Preview {
    StartingImageView(imageId: "penguin", frame: 75)
}
