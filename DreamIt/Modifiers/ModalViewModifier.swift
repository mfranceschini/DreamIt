//
//  ModalVIewStyles.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-10-14.
//

import SwiftUI

struct ModalTitleModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .foregroundColor(colorScheme == .dark ? .white : .black)
            .frame(alignment: .center)
            .multilineTextAlignment(.center)
    }
}

struct OrLabelModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        content
            .font(.footnote)
            .foregroundColor(colorScheme == .dark ? .white : .gray)
            .padding()
    }
}

struct LoginDreamItLabelModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        content
            .font(.callout)
            .foregroundColor(colorScheme == .dark ? .white : .gray)
    }
}
