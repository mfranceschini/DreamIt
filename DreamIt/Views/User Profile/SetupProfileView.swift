//
//  SetupProfileView.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-12-09.
//

import SwiftUI

import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

struct SetupProfileView: View {
    
    @State var db: Firestore!
    
    var sortedCountries = Array(CountryUtils.countries.keys).sorted(by: <)
    @State var loggedUser: LoggedUserModel
    @State private var selectedCountry = 0
    @State private var selectedProfileType = 0
    @State private var setupProgress = 0.0
    @State private var isCountryPresented: Bool = false
    @State private var loading = false
    @Binding var isLoggedIn: Bool
    @Binding var isSetupProfilePresented: Bool
    @Binding var isModalPresented: Bool
    @Binding var isEditing: Bool
    @Binding var didUpdateUser: Bool
    @State var isAlertPresented = false
    @State var errorMessage: String?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State var isSignOutAlertPresented = false
    
    private func initialize() {
        // [START setup]
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        print(loggedUser)
        if !isEditing {
            loggedUser.country = sortedCountries[selectedCountry]
        }
        else {
            selectedCountry = sortedCountries.firstIndex(of: loggedUser.country) ?? 0
        }
    }
    
    private var validated: Bool {
        !self.loggedUser.profileType.rawValue.isEmpty &&
            !self.loggedUser.country.isEmpty &&
            !self.loggedUser.firstName.isEmpty &&
            !self.loggedUser.lastName.isEmpty &&
            !self.loggedUser.portfolioURL.isEmpty
    }
    
    private func addSetupProfile() {
        loading.toggle()
        if let userId = getUserID() {
            loggedUser.uid = userId
            let userAPI = UserAPI()
            userAPI.saveUserProfile(loggedUser) { err in
                loading.toggle()
                if let err = err {
                    print("Error writing document: \(err)")
                    errorMessage = err.localizedDescription
                    isAlertPresented = true
                } else {
                    print("User Profile successfully written!")
                    withAnimation {
                        isModalPresented = false
                        isLoggedIn = true
                        isSetupProfilePresented = false
                    }
                }
            }
        }
        else {
            errorMessage = "Could not create user. Please try again."
            isAlertPresented = true
        }
    }
    
    private func updateSetupProfile() {
        loading.toggle()
        if let userId = getUserID() {
            loggedUser.uid = userId
            let userAPI = UserAPI()
            userAPI.updateUserProfile(loggedUser) { err in
                loading.toggle()
                if let err = err {
                    print("Error writing document: \(err)")
                    errorMessage = err.localizedDescription
                    isAlertPresented = true
                } else {
                    print("User Profile successfully written!")
                    withAnimation {
                        didUpdateUser = true
                        isSetupProfilePresented = false
                    }
                }
            }
        }
        else {
            errorMessage = "Could not update user. Please try again."
            isAlertPresented = true
        }
    }
    
    private func loadImage() {
        guard let inputImage = inputImage else { return }
        self.loggedUser.image = Image(uiImage: inputImage)
    }
    
    private func logout() {
        isSetupProfilePresented = false
        doLogout { isLogged in
            if !isLogged {
                withAnimation {
                    isLoggedIn = false
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
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
//                    Button(action: {
//                        showingImagePicker = true
//                    }) {
//                        if self.loggedUser.image == nil {
//                            Image(systemName: "person.crop.circle.badge.plus")
//                                .resizable()
//                                .accentColor(.blue)
//                                .frame(width: 70, height: 70)
//                        }
//                        else {
//                            Image("profile")
//                                .resizable()
//                                .scaledToFill()
//                        }
//                    }
//                    .frame(width: 100, height: 100)
//                    .cornerRadius(50)
//                    .shadow(color: Color.gray,
//                            radius: 2.0,
//                            x: 1,
//                            y: 1)
                    Form {
                        Section {
                            VStack(alignment: .leading) {
                                Text("Profile Type")
                                    .foregroundColor(.gray)
                                Picker(selection: self.$selectedProfileType, label: Text("Profile Type")) {
                                    Text(ProfileTypes.Creator.rawValue).tag(0)
                                    Text(ProfileTypes.Implementer.rawValue).tag(1)
                                }
                                .pickerStyle(SegmentedPickerStyle())
                            }
                        }
                        Section {
                            TextField("Email", text: self.$loggedUser.email)
                                .disabled(true)
                            TextField("First Name", text: self.$loggedUser.firstName)
                                .disableAutocorrection(true)
                                .autocapitalization(.words)
                            TextField("Last Name", text: self.$loggedUser.lastName)
                                .disableAutocorrection(true)
                                .autocapitalization(.words)
                            HStack {
                                Text("Country")
                                    .foregroundColor(Color(UIColor.placeholderText))
                                Spacer()
                                Text(sortedCountries[selectedCountry])
                            }
                            .onTapGesture {
                                withAnimation {
                                    loggedUser.country = sortedCountries[selectedCountry]
                                    self.isCountryPresented.toggle()
                                }
                            }
                            if isCountryPresented {
                                Picker(selection: $selectedCountry, label: Text("")) {
                                    ForEach(0 ..< sortedCountries.count) {
                                        Text(sortedCountries[$0]).tag($0)
                                    }
                                }
                                .pickerStyle(WheelPickerStyle())
                                .onTapGesture {
                                    withAnimation {
                                        loggedUser.country = sortedCountries[selectedCountry]
                                        self.isCountryPresented.toggle()
                                    }
                                }
                            }
                            TextField("Portfolio URL", text: self.$loggedUser.portfolioURL)
                                .keyboardType(.URL)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                        }
                    }
                    .onAppear {
                        UITableView.appearance().backgroundColor = .clear
                        UITableView.appearance().isScrollEnabled = true
                    }
                    VStack {
                        Button("Clear", action: {
                            loggedUser = LoggedUserModel(uid: "", firstName: "", lastName: "", profileType: ProfileTypes.Creator, email: "", country: "", phoneNumber: "", portfolioURL: "")
                        })
                        .padding([.bottom, .leading, .trailing])
                        Button("Save", action: {
                            withAnimation {
                                if isEditing {
                                    updateSetupProfile()
                                }
                                else {
                                    addSetupProfile()
                                }
                            }
                        })
                        .buttonStyle(SaveButtonStyle(validated: validated))
                        .padding([.bottom])
                        .disabled(!validated)
                    }
                }
            }
            .padding(.top)
            .navigationTitle("Profile Setup")
            .alert(isPresented: $isAlertPresented, content: {
                Alert(title: Text("Error"), message: Text(errorMessage ?? ""), dismissButton: .default(Text("Dismiss")))
            })
            .alert(isPresented: $isSignOutAlertPresented, content: {
                Alert(title: Text("Sign Out"), message: Text("Do you really want to sign out?"),
                      primaryButton: .default(Text("Confirm")) {
                        logout()
                      },
                      secondaryButton: .cancel())
            })
            .toolbar {
                if isEditing {
                    Button(action: {
                        isSignOutAlertPresented = true
                    }) {
                        Text("Sign out")
                    }
                }
            }
        }
        .onAppear(perform: {
            initialize()
        })
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: self.$inputImage)
        }
    }
}

struct SetupProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SetupProfileView(loggedUser: LoggedUserModel(uid: "", firstName: "", lastName: "", profileType: ProfileTypes.Creator, email: "", country: "", phoneNumber: "", portfolioURL: ""), isLoggedIn: .constant(false), isSetupProfilePresented: .constant(false), isModalPresented: .constant(false), isEditing: .constant(true), didUpdateUser: .constant(false))
    }
}
