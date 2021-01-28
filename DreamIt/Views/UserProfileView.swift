//
//  UserProfileView.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2021-01-27.
//

import SwiftUI

struct UserProfileView: View {
    
    @Binding var isLoggedIn: Bool
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            Text("Hello, World!")
        }
        .background(
            LinearGradient(gradient: Gradient(colors: colorScheme == .dark ? Constants.background.reversed() : Constants.background), startPoint: .bottom, endPoint: .top)
        )
        .edgesIgnoringSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(isLoggedIn: .constant(true))
    }
}
