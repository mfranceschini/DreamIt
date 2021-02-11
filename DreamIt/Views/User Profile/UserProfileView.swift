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
    @State var isLoading = false
    @State var isAlertPresented = false
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .center) {
                if isLoading {
                    Loading()
                        .frame(width: Constants.screenSize.width * 0.9, height: Constants.screenSize.height * 0.7, alignment: .bottom)
                        .background(Color.clear)
                }
                else {
                    VStack {
                        Image("profile")
                            .resizable()
                            .frame(width: 200, height: 200)
                            .cornerRadius(100)
                        Text("Matheus Franceschini")
                        Spacer()
                        Form {
                            Section {
//                                TextField("", text: <#T##Binding<String>#>)
                            }
                        }
                        .background(Color.clear)
                        Spacer()
                        Button(action: {
                            isAlertPresented = true
                        }) {
                            Text("Sign out")
                        }
                    }
                    .alert(isPresented: $isAlertPresented, content: {
                        Alert(title: Text("Sign out"), message: Text("Do you really want to sign out?"), primaryButton: .default(Text("Confirm"), action: {
                            isAlertPresented = false
                            doLogout { isLogged in
                                withAnimation {
                                    isLoggedIn = isLogged
                                }
                            }
                        }),
                        secondaryButton: .cancel()
                        )
                    })
                }
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: colorScheme == .dark ? Constants.background.reversed() : Constants.background), startPoint: .bottom, endPoint: .top)
        )
        //        .edgesIgnoringSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(isLoggedIn: .constant(true))
    }
}
