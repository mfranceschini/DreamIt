//
//  IdeaDetailsViewModifier.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-11-12.
//

import SwiftUI

struct TitleModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        content
            .font(.title)
    }
}

struct AuthorModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        content
        .font(.title3)
        .foregroundColor(colorScheme == .dark ? Color.white : Color.gray)
    }
}

struct BodyTitleModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .padding(.leading)
    }
}

struct BodyLabelModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        content
        .lineLimit(nil)
        .font(.body)
        .padding(.leading)
    }
}

struct PostDateLabelModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        content
            .font(.footnote)
            .foregroundColor(colorScheme == .dark ? Color.white : Color.gray)
            .frame(alignment: .leading)
            .padding([.bottom, .top])
    }
}

struct ImpressionsLabelModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        content
            .font(.footnote)
            .foregroundColor(colorScheme == .dark ? Color.white : Color.gray)
            .frame(alignment: .trailing)
            .padding([.bottom, .top])
    }
}

struct LikeButtonStyle: ButtonStyle {
    var isLiked: Bool
    @Environment(\.colorScheme) var colorScheme
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 70, height: 15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .padding()
            .font(.system(size: 19))
            .foregroundColor(isLiked ? .blue : .black)
            .background(isLiked ? Color.clear : Color.white)
            .cornerRadius(15)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .shadow(color: colorScheme == .dark ? Color.white.opacity(0.3) : Color.gray,
                    radius: 1.0)
    }
}

struct InterestedButtonStyle: ButtonStyle {
    @Environment(\.colorScheme) var colorScheme
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: 170, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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
