//
//  SetupProfileView.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-12-09.
//

import SwiftUI

struct SetupProfileView: View {
    
    var sortedCountries = CountryUtils.countries.sorted()
    @State var loggedUser: LoggedUserModel
    @State private var selectedCountry = 0
    @State private var selectedProfileType = 0
    @State private var setupProgress = 0.0
    @State private var isCountryPresented: Bool = false
    @Binding var isLoggedIn: Bool
    @Binding var isSetupProfilePresented: Bool
    
    func validateForm() -> Bool {
        if (!self.loggedUser.country.isEmpty &&
                !self.loggedUser.email.isEmpty &&
                !self.loggedUser.firstName.isEmpty &&
                !self.loggedUser.lastName.isEmpty &&
                !self.loggedUser.phoneNumber.isEmpty &&
                !self.loggedUser.portfolioURL.isEmpty) {
            return true
        }
        return false
    }
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    VStack(alignment: .leading) {
                        Text("Profile Type")
                            .foregroundColor(.gray)
                            .frame(alignment: .leading)
                        Picker(selection: self.$selectedProfileType, label: Text("Profile Type")) {
                            Text(ProfileTypes.Creator.rawValue).tag(0)
                            Text(ProfileTypes.Implementer.rawValue).tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.bottom)
                    }
                    TextField("First Name", text: self.$loggedUser.firstName)
                        .disableAutocorrection(true)
                    Divider()
                    TextField("Last Name", text: self.$loggedUser.lastName)
                        .disableAutocorrection(true)
                    Divider()
                    TextField("Email", text: self.$loggedUser.email)
                        .keyboardType(.emailAddress)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    Divider()
                    
                    HStack {
                        Text("Country")
                            .foregroundColor(Color(UIColor.placeholderText))
                        Spacer()
                        Text(sortedCountries[selectedCountry])
                    }
                    .onTapGesture {
                        withAnimation {
                            self.isCountryPresented.toggle()
                        }
                    }
                    if isCountryPresented {
                        Picker(selection: $selectedCountry, label: Text("")) {
                            ForEach(0 ..< sortedCountries.count) {
                                Text(sortedCountries[$0]).tag($0)
                            }
                        }
                        .onTapGesture {
                            withAnimation {
                                self.isCountryPresented.toggle()
                            }
                        }
                    }
                    Divider()
                }
                VStack {
                    TextField("Phone Number", text: self.$loggedUser.phoneNumber)
                        .keyboardType(.phonePad)
                        .disableAutocorrection(true)
                    Divider()
                    TextField("Portfolio URL", text: self.$loggedUser.portfolioURL)
                        .keyboardType(.URL)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                VStack {
                    Spacer()
                    Button("Save", action: {
                        withAnimation {
                            self.isLoggedIn = true
                            self.isSetupProfilePresented = false
                        }
                    })
                    .buttonStyle(SaveButtonStyle())
                    .disabled(self.validateForm())
                }
            }
            .padding()
            .padding(.top)
            .navigationTitle("Profile Setup")
        }
    }
}

struct SetupProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SetupProfileView(loggedUser: LoggedUserModel(firstName: "", lastName: "", profileType: ProfileTypes.Creator, email: "", country: "", phoneNumber: "", portfolioURL: ""), isLoggedIn: .constant(false), isSetupProfilePresented: .constant(false))
    }
}
