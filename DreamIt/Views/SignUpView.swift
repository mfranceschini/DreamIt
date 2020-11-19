//
//  SignUpView.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-10-09.
//

import SwiftUI

struct SignUpView: View {
    
    @Binding var movingOffset: CGFloat
    @State private var textTitle = ""
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        let phoneRatio = String(format: "%.3f", Constants.screenSize.width / Constants.screenSize.height)
        let refRatio =   String(format: "%.3f",  9.0 / 16.0)
        let isXorAbove = phoneRatio != refRatio
        
        VStack(spacing: 25) {
            CloseModalLip()
            
            VStack {
                Text("New Account")
                    .modifier(ModalTitleModifier())
                Divider()
                    .background(colorScheme == .dark ? Color.white : Color.gray.opacity(0.5))
                Spacer()
                
                Group {
                    Button("Sign up with Apple ID") {
                        print("apple")
                    }
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(15.0)
                    .frame(width: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .lineLimit(1)
                    Spacer()
                    
                    Button("Sign up with Google") {
                        print("google")
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(15.0)
                    .frame(width: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .lineLimit(1)
                    Spacer()
                    
                    Button("Sign up with Facebook") {
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
                    Button(action: { }) {
                        Text("Create DreamIt account")
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(movingOffset: .constant(0.0))
    }
}
