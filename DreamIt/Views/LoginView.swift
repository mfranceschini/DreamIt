//
//  LoginView.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-10-09.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var movingOffset: CGFloat
    @State private var textTitle = ""
    @Binding var isLoggedIn: Bool
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        let phoneRatio = String(format: "%.3f", Constants.screenSize.width / Constants.screenSize.height)
        let refRatio =   String(format: "%.3f",  9.0 / 16.0)
        let isXorAbove = phoneRatio != refRatio
        
        
        VStack(spacing: 25) {
            CloseModalLip()
            
            VStack {
                Text("Welcome back")
                    .fontWeight(.bold)
                    .modifier(ModalTitleModifier())
                Divider()
                    .background(colorScheme == .dark ? Color.white : Color.gray.opacity(0.5))
                Spacer()
                
                Group {
                    Button("Login with Apple ID") {
                        print("apple")
                    }
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(15.0)
                    .frame(width: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .lineLimit(1)
                    Spacer()
                    
                    Button("Login with Google") {
                        print("google")
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(15.0)
                    .frame(width: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .lineLimit(1)
                    Spacer()
                    
                    Button("Login with Facebook") {
                        print("facebook")
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(15.0)
                    .frame(width: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .lineLimit(1)
                    Spacer()
                }
                
                VStack {
                    Text("- or -")
                        .fontWeight(.bold)
                        .modifier(OrLabelModifier())
                    Button(action: {
                        withAnimation {
                            self.isLoggedIn = true
                        }
                    }) {
                        Text("Login with DreamIt account")
                            .underline()
                            .modifier(LoginDreamItLabelModifier())
                    }
                }
            }
            .frame(height: Constants.screenSize.height * 0.5)
            
        }
        .offset(y: movingOffset )
        .padding(.bottom, isXorAbove ? 60 : 50 )
        .padding(.top, 15)
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(movingOffset: .constant(0.0), isLoggedIn: .constant(false))
    }
}
