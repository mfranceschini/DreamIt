//
//  SetupProfileView.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-12-09.
//

import SwiftUI

struct SetupProfileView: View {
    
    @State var loggedUser: LoggedUserModel
    @State private var selectedCountry = 0
    @State private var selectedProfileType = 0
    @State private var setupProgress = 0.0
    @Binding var isLoggedIn: Bool
    @Binding var isSetupProfilePresented: Bool
    @State private var isCountryPresented: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    VStack(alignment: .leading) {
                        Text("Profile Type")
                            .foregroundColor(Color(UIColor.placeholderText))
                            .frame(alignment: .leading)
                        Picker(selection: $selectedProfileType, label: Text("Profile Type")) {
                            Text(ProfileTypes.Creator.rawValue).tag(0)
                            Text(ProfileTypes.Implementer.rawValue).tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.bottom)
                    }
                    TextField("First Name", text: $loggedUser.firstName)
                    Divider()
                    TextField("Last Name", text: $loggedUser.lastName)
                    Divider()
                    TextField("Email", text: $loggedUser.email)
                        .keyboardType(.emailAddress)
                    Divider()
                    
                    HStack {
                        Text("Country")
                            .foregroundColor(Color(UIColor.placeholderText))
                        Spacer()
                        Text(CountryUtils.countries[selectedCountry])
                    }
                    .onTapGesture {
                        withAnimation {
                            self.isCountryPresented.toggle()
                        }
                    }
                    if isCountryPresented {
                        Picker(selection: $selectedCountry, label: Text("")) {
                            ForEach(0 ..< CountryUtils.countries.count) {
                                Text(CountryUtils.countries[$0]).tag($0)
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
                    TextField("Phone Number", text: $loggedUser.phoneNumber)
                        .keyboardType(.phonePad)
                    Divider()
                    TextField("Portfolio URL", text: $loggedUser.portfolioURL)
                        .keyboardType(.URL)
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
                }
            }
            .padding()
            .padding(.top)
            .navigationTitle("Profile Setup")
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
        }
    }
}

struct SetupProfileView_Previews: PreviewProvider {
    static var previews: some View {
        SetupProfileView(loggedUser: LoggedUserModel(firstName: "", lastName: "", profileType: ProfileTypes.Creator, email: "", country: "", phoneNumber: "", portfolioURL: ""), isLoggedIn: .constant(false), isSetupProfilePresented: .constant(false))
    }
}
