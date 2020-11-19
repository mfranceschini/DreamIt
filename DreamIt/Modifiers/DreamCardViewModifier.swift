//
//  DreamCardViewModifier.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-10-21.
//

import SwiftUI

struct ContainerModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .frame(width: Constants.screenSize.width * 0.93)
            .background(colorScheme == .dark ? Color.black : Color.white)
            .cornerRadius(20.0)
            .padding(.top, 15)
            .padding([.trailing, .leading], 10)
            .shadow(color: colorScheme == .dark ? Color.white.opacity(0.3) : Color.gray,
                    radius: 4.0,
                    x: 2,
                    y: 2)
    }
}

struct LikeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: Constants.screenSize.width * 0.42, alignment: .leading)
            .padding(.leading)
    }
}

struct DaysAfterPostLabelModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        content
            .font(.footnote)
            .foregroundColor(colorScheme == .dark ? Color.white : Color.gray)
            .frame(width: Constants.screenSize.width * 0.42, alignment: .trailing)
            .padding(.trailing, 10)
    }
}

struct DreamImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 80, height: 80, alignment: .leading)
            .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 0))
    }
}

struct DreamTitleModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
    }
}

struct DreamAuthorModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .foregroundColor(colorScheme == .dark ? Color.white : Color.gray)
        
    }
}

struct DreamImpressionsModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        content
            .font(.footnote)
            .foregroundColor(colorScheme == .dark ? Color.white : Color.gray)
            .frame(width: Constants.screenSize.width * 0.83, alignment: .bottomTrailing)
            .padding([.bottom, .top])
        
    }
}
