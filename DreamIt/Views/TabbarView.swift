//
//  TabbarView.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-11-05.
//

import SwiftUI

struct TabbarView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var newListingPresented: Bool
    
    var body: some View {
        TabView {
            DreamListView(ideaDetailsPresented: false)
                .tabItem {
                    Image(systemName: "house.fill")
                }
            LikedIdeasView()
                .tabItem {
                    Image(systemName: "ellipsis.bubble.fill")
                }
            DreamListView(ideaDetailsPresented: false)
                .tabItem {
                    Image(systemName: "plus.diamond")
                }
            LikedIdeasView()
                .tabItem {
                    Image(systemName: "lightbulb.fill")
                }
            DreamListView(ideaDetailsPresented: false)
                .tabItem {
                    Image(systemName: "person.fill")
                }
        }
        .onAppear() {
            UITabBar.appearance().isTranslucent = true
        }
        .edgesIgnoringSafeArea(.all)
        .accentColor(colorScheme == .dark ?
                        .blue : Color(red: 0.61, green: 0.31, blue: 0.62))
    }
}

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView(newListingPresented: false)
    }
}
