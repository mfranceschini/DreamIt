//
//  LoginView.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-10-09.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct LoginView: View {
    
    @Binding var movingOffset: CGFloat
    @State private var textTitle = ""
    @Binding var isLoggedIn: Bool
    @Environment(\.colorScheme) var colorScheme
    @State var isUserLoginPresented: Bool = false
    @State var isSetupProfilePresented: Bool = false
    
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
                
                if isUserLoginPresented {
                    UserLoginView(isUserLoginPresented: $isUserLoginPresented, isLoggedIn: $isLoggedIn)
                        .transition(.move(edge: isUserLoginPresented ? .trailing : .leading))
                }
                else {
                
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
                                isUserLoginPresented = true
                            }
                        }) {
                            Text("Login with DreamIt account")
                                .underline()
                                .modifier(LoginDreamItLabelModifier())
                        }
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

struct UserLoginView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var email: String = ""
    @State var password: String = ""
    @Binding var isUserLoginPresented: Bool
    @State var loading = false
    @State var isAlertPresented = false
    @State var errorMessage: String?
    @Binding var isLoggedIn: Bool
    
    private var validated: Bool {
        !email.isEmpty && !password.isEmpty && password.count >= 8
    }
    
    private func submitForm() {
        
        if !isValidEmail(email) {
            errorMessage = "The email entered is not valid."
            isAlertPresented = true
        }
        else if (!isValidPassword(password)) {
            errorMessage = "The password entered does not meet the requirements."
            isAlertPresented = true
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [self] authResult, error in
            if authResult != nil {
                loading.toggle()
                isLoggedIn = true
            }
            else if error != nil {
                errorMessage = "The email or password are not valid."
                isAlertPresented = true
                loading.toggle()
            }
        }
    }
    
    var body: some View {
        VStack {
            if loading {
                GeometryReader { gp in
                    ZStack {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .alignmentGuide(VerticalAlignment.center, computeValue: { $0[.bottom] })
                            .position(x: gp.size.width / 2, y: gp.size.height / 2)
                    }
                }
                .transition(.move(edge: .trailing))
                
            }
            else {
                Form {
                    Section {
                        TextField("Email", text: self.$email)
                            .keyboardType(.emailAddress)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        SecureField("Password", text: self.$password)
                    }
                }
                .padding(.top)
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                    UITableView.appearance().isScrollEnabled = false
                }
                VStack {
                    Text("Password contains at least one upper cased letter, one digit and 08 characters.")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding([.leading, .trailing, .bottom])
                        .padding([.leading, .trailing, .bottom])
                        .multilineTextAlignment(.center)
                    Spacer()
                    Button("Login", action: {
                        withAnimation {
                            loading.toggle()
                            submitForm()
                        }
                    })
                    .buttonStyle(SaveButtonStyle(validated: validated))
                    .disabled(!validated)
                    Button("Back", action: {
                        withAnimation {
                            isUserLoginPresented = false
                        }
                    })
                    .padding([.top, .leading, .trailing])
                }
            }
        }
        .alert(isPresented: $isAlertPresented, content: {
            Alert(title: Text("Error"), message: Text(errorMessage ?? ""), dismissButton: .default(Text("Dismiss")))
        })
    }
}
