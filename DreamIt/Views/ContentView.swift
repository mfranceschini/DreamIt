//
//  ContentView.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-10-09.
//

import SwiftUI

enum TargetView {
    case SignUp
    case Login
    case None
}

struct ContentView: View {
    
    @State var isModalPresented = false
    @State var targetView: TargetView = TargetView.None
    @State private var currentHeight: CGFloat = 0.0
    @State private var movingOffset: CGFloat = 0.0
    @State var isLoggedIn = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        if isLoggedIn {
            TabbarView(newListingPresented: false)
                .transition(.move(edge: .trailing))
        }
        else {
            ZStack {
                VStack {
                    ZStack(alignment: .top) {
                        Color.clear
                        VStack(alignment: .center) {
                            Image("test")
                                .resizable()
                                .modifier(AppLogoStyle())
                            Text("DreamIt")
                                .fontWeight(.bold)
                                .kerning(2.0)
                                .modifier(LandingViewTitleStyle())
                        }
                    }
                    .padding(.top, 20)
                    
                    VStack(alignment: .center) {
                        Button("Sign Up") {
                            withAnimation(.spring(dampingFraction: 0.7)) {
                                self.isModalPresented = true
                                self.targetView = TargetView.SignUp;
                                self.currentHeight = 0.0
                                self.movingOffset = 0.0
                            }
                        }
                        .buttonStyle(SignUpButtonStyle())
                        
                        Button("Login") {
                            withAnimation(.spring(dampingFraction: 0.7)) {
                                self.isModalPresented = true
                                self.targetView = TargetView.Login;
                                self.currentHeight = 0.0
                                self.movingOffset = 0.0
                            }
                        }
                        .buttonStyle(LoginButtonStyle())
                    }
                    .padding(.bottom, 70)
                }
                .blur(radius: self.isModalPresented ? 3.0 : 0.0)
                .padding()
                
                CustomSheetView(currentHeight: self.$currentHeight, movingOffset: self.$movingOffset, isShowing: self.$isModalPresented, targetView: self.$targetView, isLoggedIn: self.$isLoggedIn)
                    .transition(.move(edge: .bottom))
            }
            .background(
                LinearGradient(gradient: Gradient(colors: colorScheme == .dark ? Constants.background.reversed() : Constants.background), startPoint: .bottom, endPoint: .top)
            )
            .edgesIgnoringSafeArea(.all)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
