//
//  LandingStyles.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-10-09.
//

import SwiftUI

struct SignUpButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .font(.system(size: 20))
            .foregroundColor(.black)
            .background(Color.white)
            .cornerRadius(40)
            .padding(.horizontal, 40)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct LoginButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .font(.system(size: 20))
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(40)
            .padding(.horizontal, 40)
            .padding(.top, 20)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct LandingViewTitleStyle: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .lineLimit(nil)
            .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
    }
}

struct AppLogoStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 150.0, height: 150.0)
            .padding()
            .padding(.top, 30)
    }
}
