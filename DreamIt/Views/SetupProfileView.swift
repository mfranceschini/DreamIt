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
    @State var isAlertPresented = false
    @State var errorMessage: String?
    
    private func initialize() {
        // [START setup]
        let settings = FirestoreSettings()
        
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        
        loggedUser.country = sortedCountries[selectedCountry]
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            db.collection("usersProfiles").document("profile2").setData([
                "name": loggedUser.firstName,
                "lastName": loggedUser.lastName,
                "country": loggedUser.country,
                "portfolioUrl": loggedUser.portfolioURL,
                "profileType": loggedUser.profileType.rawValue
            ]) { err in
                loading.toggle()
                if let err = err {
                    print("Error writing document: \(err)")
                    errorMessage = err.localizedDescription
                    isAlertPresented = true
                } else {
                    print("User Profile successfully written!")
                    isLoggedIn = true
                    isSetupProfilePresented = false
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
                                addSetupProfile()
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
        }
        .onAppear(perform: {
            initialize()
        })
    }
}

struct SetupProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SetupProfileView(loggedUser: LoggedUserModel(uid: "", firstName: "", lastName: "", profileType: ProfileTypes.Creator, email: "", country: "", phoneNumber: "", portfolioURL: ""), isLoggedIn: .constant(false), isSetupProfilePresented: .constant(false))
    }
}
