//
//  SetupProfileViewModifier.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-12-14.
//

import SwiftUI

struct SaveButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 140, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .padding()
            .font(.system(size: 20))
            .foregroundColor(.white)
            .background(Color.blue)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .shadow(color: Color.gray,
                    radius: 2.0,
                    x: 1,
                    y: 1)
    }
}
