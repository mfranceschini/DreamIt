//
//  DreamListViewModifier.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-10-19.
//

import SwiftUI

struct CategoriesTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(/*@START_MENU_TOKEN@*/.title2/*@END_MENU_TOKEN@*/)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .frame(width: Constants.screenSize.width, alignment: .leading)
            .padding(.leading, 50)
    }
}

struct TitleListModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .padding(.top, 50)
            .frame(alignment: .leading)
    }
}

struct ProfileImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .frame(width: /*@START_MENU_TOKEN@*/50.0/*@END_MENU_TOKEN@*/, height: 50.0)
            .clipShape(Circle())
            .shadow(radius: 10)
            .padding()
    }
}

struct NoIdeasLabelModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
            .padding()
            .frame(alignment: .center)
    }
}
