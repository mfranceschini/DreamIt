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
    @Environment(\.colorScheme) var colorScheme
    var liked: Bool
    func body(content: Content) -> some View {
        content
            .foregroundColor(self.liked ? colorScheme == .dark ? Color.white : Color.blue : Color(UIColor.lightGray))
            .frame(width: 20, height: 20, alignment: .leading)
    }
}

struct DaysAfterPostLabelModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    func body(content: Content) -> some View {
        content
            .font(.footnote)
            .foregroundColor(colorScheme == .dark ? Color.white : Color.gray)
            .frame(alignment: .trailing)
            .padding(.trailing, 10)
    }
}

struct DreamImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 90, height: 90, alignment: .leading)
            .padding(.leading)
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
            .frame(alignment: .bottomTrailing)
            .padding([.bottom, .top])
        
    }
}
