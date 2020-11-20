//
//  DreamListViewModifier.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-10-19.
//

import SwiftUI


struct ScrollViewModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        return content
            .frame(width: Constants.screenSize.width, height: Constants.screenSize.height)
            .navigationTitle(Text("Ideas List"))
            .navigationBarTitleDisplayMode(.automatic)
            .padding(.top, 230)
            .background(
                LinearGradient(gradient: Gradient(colors: colorScheme == .dark ? Constants.background.reversed() : Constants.background), startPoint: .bottom, endPoint: .top)
            )
    }
}

struct CategoriesTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
            .multilineTextAlignment(.center)
            .frame(width: Constants.screenSize.width, alignment: .leading)
            .padding(.leading, 50)
    }
}
