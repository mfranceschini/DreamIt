//
//  CreateIdeaView.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2021-02-16.
//

import SwiftUI

struct CreateIdeaView: View {
    
    let api = API()
    let userAPI = UserAPI()
    @State var loading = false
    @State var idea = IdeaItemModel(id: "", category: 0, title: "", author: "", createdAt: "", impressions: 0, liked: false, description: "")
    @State var isCategoryPresented = false
    @State var selectedCategory = 0
    @State var categoriesList: [CategoryModel] = []
    @State var isProfilePresented = false
    @State var isAlertPresented = false
    @State var errorMessage: String?
    @Binding var userData: LoggedUserModel?
    @Binding var selectedTab: String
    @Environment(\.colorScheme) var colorScheme
    
    private var validated: Bool {
        !self.idea.title.isEmpty &&
            !self.idea.description.isEmpty
    }
    
    private func loadCategories() {
        loading = true
        api.getCategories { categories in
            categories.forEach { categoriesList.append($0) }
            withAnimation {
                categoriesList.sort{ $0.name < $1.name }
                loading = false
            }
        }
    }
    
    private func resetForm() {
        idea = IdeaItemModel(id: "", category: 0, title: "", author: "", createdAt: "", impressions: 0, liked: false, description: "")
    }
    
    private func submitForm() {
        loading = true
        
        if let userData = userData {
            
            idea.author = userData.firstName + " " + userData.lastName
            idea.impressions = 0
            idea.liked = false
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
            idea.createdAt = dateFormatter.string(from: Date())
            
            idea.category = categoriesList[selectedCategory].id
            
            api.createNewIdea(idea: idea) { result in
                if result {
                    withAnimation {
                        resetForm()
                        loading = false
                        selectedTab = "home"
                    }
                }
                else {
                    errorMessage = "Could not create idea. Please try again."
                    isAlertPresented = true
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("New Idea")
                    .fontWeight(.bold)
                    .modifier(TitleListModifier())
                Spacer()
                Button(action: {
                    isProfilePresented = true
                }) {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .accentColor(.white)
                        .modifier(ProfileImageModifier())
                }
                .disabled(userData == nil)
            }
            .frame(width: Constants.screenSize.width)
            .padding([.top, .leading, .trailing])
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
            else if categoriesList.count > 0 {
                Form {
                    Section {
                        HStack {
                            Text("Category")
                                .foregroundColor(Color(UIColor.placeholderText))
                            Spacer()
                            Text(categoriesList[selectedCategory].name)
                        }
                        .onTapGesture {
                            withAnimation {
                                self.isCategoryPresented.toggle()
                            }
                        }
                        if isCategoryPresented {
                            Picker(selection: $selectedCategory, label: Text("")) {
                                ForEach(0 ..< categoriesList.count) {
                                    Text(categoriesList[$0].name).tag($0)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .onTapGesture {
                                withAnimation {
                                    self.isCategoryPresented.toggle()
                                }
                            }
                        }
                    }
                    
                    Section {
                        TextField("Title", text: self.$idea.title)
                            .disableAutocorrection(true)
                            .autocapitalization(.words)
                        TextField("Description", text: self.$idea.description)
                        VStack {
                            Image(systemName: "exclamationmark.circle")
                                .resizable()
                                .foregroundColor(.gray)
                                .frame(width: 20, height: 20)
                            Text("Please add a short description about your idea. Make sure you share all the details after finding your teammate.")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                        }
                        .padding([.vertical])
                    }
                }
                .padding()
                
                VStack {
                    Button("Clear", action: { resetForm() })
                    .foregroundColor(.white)
                    .padding([.horizontal])
                    Button("Save", action: { submitForm() })
                        .buttonStyle(SaveButtonStyle(validated: validated))
                        .disabled(!validated)
                }
                .padding([.bottom], 40)
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: colorScheme == .dark ? Constants.background.reversed() : Constants.background), startPoint: .bottom, endPoint: .top)
        )
        .edgesIgnoringSafeArea(.top)
        .onAppear() {
            UITableView.appearance().backgroundColor = .clear
            loadCategories()
        }
        .onDisappear() {
            resetForm()
            categoriesList = []
        }
        .alert(isPresented: $isAlertPresented, content: {
            Alert(title: Text("Error"), message: Text(errorMessage ?? ""), dismissButton: .default(Text("Dismiss")))
        })
    }
}
