//
//  CreateUserView.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2021-01-08.
//

import SwiftUI
import Firebase
import FirebaseAuth

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
//    @Binding var loggedUser: LoggedUserModel
    
    private var validated: Bool {
        !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty && password == confirmPassword
    }
    
    private func submitForm() {
        
        if !isValidEmail(email) {
            errorMessage = "The email entered is not valid."
            isAlertPresented = true
        }
        else if (!isValidPassword(password) || !isValidPassword(confirmPassword) || (password != confirmPassword)) {
            errorMessage = "The password entered does not meet the requirements."
            isAlertPresented = true
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if authResult != nil {
                if let id = authResult?.user.uid {
//                    loggedUser.uid = id
                    loading.toggle()
                    isSetupProfilePresented = true
                }
                else {
                    errorMessage = "Couldn't create user. Please  try again."
                    isAlertPresented = true
                    loading.toggle()
                }
            }
            else if error != nil {
                errorMessage = "The email entered is already in use."
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
                        SecureField("Confirm Password", text: self.$confirmPassword)
                    }
                }
                .onAppear {
                    UITableView.appearance().backgroundColor = .clear
                    UITableView.appearance().isScrollEnabled = false
                }
                VStack {
                    Text("Password must contain at least one upper cased letter, one digit and 08 characters.")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding([.leading, .trailing, .bottom])
                        .padding([.leading, .trailing, .bottom])
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                    Spacer()
                    Button("Create", action: {
                        withAnimation {
                            loading.toggle()
                            submitForm()
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

