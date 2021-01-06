//
//  SignUpView.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-10-09.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct SignUpView: View {
    
    @Binding var movingOffset: CGFloat
    @State private var textTitle = ""
    @Binding var isLoggedIn: Bool
    @Environment(\.colorScheme) var colorScheme
    @State var isSetupProfilePresented: Bool = false
    @State var isCreateUserPresented: Bool = false
    
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
                
                if isCreateUserPresented {
                    CreateUserView(isCreateUserPresented: $isCreateUserPresented, isSetupProfilePresented: $isSetupProfilePresented)
                        .transition(.move(edge: isCreateUserPresented ? .trailing : .leading))
                }
                else {
                    Group {
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
                            Button(action: {
                                withAnimation {
                                    self.isCreateUserPresented = true
                                }
                            }) {
                                Text("Create DreamIt account")
                                    .underline()
                                    .modifier(LoginDreamItLabelModifier())
                            }
                        }
                    }
                }
            }
            .frame(height: Constants.screenSize.height * 0.5)
            
        }
        .offset(y: movingOffset )
        .padding(.bottom, isXorAbove ? 60 : 50 )
        .padding(.top, 15)
        .sheet(isPresented: $isSetupProfilePresented, content: {
            SetupProfileView(loggedUser: LoggedUserModel(firstName: "", lastName: "", profileType: ProfileTypes.Creator, email: "", country: "", phoneNumber: "", portfolioURL: ""), isLoggedIn: self.$isLoggedIn, isSetupProfilePresented: self.$isSetupProfilePresented)
        })
    }
    
}

struct CreateUserView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @Binding var isCreateUserPresented: Bool
    @Binding var isSetupProfilePresented: Bool
    @State var loading = false
    @State var isAlertPresented = false
    @State var errorMessage: String?
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z]).{8,}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@ ", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
    
    private var validated: Bool {
        !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty
    }
    
    private func submitForm() -> (hasSucceeded: Bool, message: String?) {
        var hasSucceeded = true
        var message: String?
        
        if !isValidEmail(email) {
            hasSucceeded = false
            message = "The email entered is not valid."
            return (hasSucceeded, message)
        }
        if !isValidPassword(password) || !isValidPassword(confirmPassword) || password != confirmPassword {
            hasSucceeded = false
            message = "The password entered does not meet the requirements."
            return (hasSucceeded, message)
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                hasSucceeded = false
                print(error!)
            }
        }
        return (hasSucceeded, message)
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
                        TextField("E-mail", text: self.$email)
                            .keyboardType(.emailAddress)
                            .disableAutocorrection(true)
                            .autocapitalization(UITextAutocapitalizationType.none)
                        SecureField("Password", text: self.$password)
                        SecureField("Confirm Password", text: self.$confirmPassword)
                    }
                }
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                    UITableView.appearance().isScrollEnabled = false
                }
                VStack {
                    Text("Password must contain at least one capital letter, one digit and 08 characters.")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding([.leading, .trailing, .bottom])
                        .padding([.leading, .trailing, .bottom])
                        .multilineTextAlignment(.center)
                        .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    Spacer()
                    Button("Create", action: {
                        withAnimation {
                            loading.toggle()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                let result = submitForm()
                                loading.toggle()
                                if result.hasSucceeded {
                                    isSetupProfilePresented = true
                                    isCreateUserPresented = false
                                }
                                else {
                                    errorMessage = result.message!
                                    isAlertPresented = true
                                }
                            }
                        }
                    })
                    .buttonStyle(SaveButtonStyle(validated: validated))
                    .disabled(!validated)
                    Button("Back", action: {
                        withAnimation {
                            isCreateUserPresented = false
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

struct CreateUserView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUserView(isCreateUserPresented: .constant(false), isSetupProfilePresented: .constant(false) )
    }
}
