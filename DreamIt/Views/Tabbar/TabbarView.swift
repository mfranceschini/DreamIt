//
//  TabbarView.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-11-05.
//

import SwiftUI

struct TabbarView: View {
    let userAPI = UserAPI()
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedTab = "home"
    @Binding var isLoggedIn: Bool
    @State var userData: LoggedUserModel?
    
    private func loadUserData() {
        userAPI.getUserProfile { user in
            userData = user
        }
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            
            // MARK: Idea List
            IdeaListView(ideaDetailsPresented: false, selectedTab: $selectedTab, isLoggedIn: $isLoggedIn, userData: $userData)
                .tabItem {
                    Image(systemName: "house.fill")
                        .onTapGesture {
                            self.selectedTab = "home"
                        }
                }
                .tag("home")
            
            // MARK: Create New Idea
            CreateIdeaView(userData: $userData, selectedTab: $selectedTab, isLoggedIn: $isLoggedIn)
                .tabItem {
                    Image(systemName: "plus.diamond")
                        .onTapGesture {
                            self.selectedTab = "new"
                        }
                }
                .tag("new")
            
            
            // MARK: Liked Ideas
            LikedIdeasView()
                .tabItem {
                    Image(systemName: "lightbulb.fill")
                        .onTapGesture {
                            self.selectedTab = "liked"
                        }
                }
                .tag("liked")
            
            // MARK: Chats
            LikedIdeasView()
                .tabItem {
                    Image(systemName: "ellipsis.bubble.fill")
                        .onTapGesture {
                            self.selectedTab = "chats"
                        }
                }
                .tag("chats")
        }
        .onAppear() {
            UITabBar.appearance().isTranslucent = true
            loadUserData()
        }
        .edgesIgnoringSafeArea(.all)
        .accentColor(colorScheme == .dark ?
                        .blue : Color(red: 0.61, green: 0.31, blue: 0.62))
    }
}

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView(isLoggedIn: .constant(true))
    }
}
