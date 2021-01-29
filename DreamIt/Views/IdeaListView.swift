//
//  DreamListView.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-10-15.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct IdeaListView: View {
    
    let api = API()
    
    @State var categories: [CategoryModel] = []
    @State var ideasList: [IdeaItemModelView] = []
    @State var ideaDetailsPresented: Bool = false
    @State private var loading: Bool = false
    @State private var filterLoading: Bool = false
    @State private var scale: CGFloat = 1
    @State private var searchText : String = ""
    @State private var selectedIdea: IdeaItemModelView?
    @Environment(\.colorScheme) var colorScheme
    @Binding var selectedTab: String
    @Binding var isLoggedIn: Bool
    @State var appliedFilters: [CategoryModel] = []
    @State private var isRotated = false
    @State var didChangeData = false
    
    private func loadData() {
        self.loading = true
        api.getIdeas { ideaData in
            withAnimation {
                ideasList = ideaData
            }
            api.getCategories { categoryData in
                withAnimation {
                    categories = categoryData
                    self.loading = false
                    self.isRotated = false
                }
            }
        }
    }
    
    private func applyFilter(_ filters: [CategoryModel]) {
        self.filterLoading = true
        let currentFilters = filters.filter { $0.selected }
        if currentFilters.count > 0 {
            api.getIdeasByCategories(selectedCategories: currentFilters) { ideaData in
                withAnimation {
                    ideasList = ideaData
                    self.filterLoading = false
                }
            }
        }
        else {
            withAnimation {
                ideasList = []
                self.filterLoading = false
            }
        }
    }
    
    private func createIdeaBinding(_ idea: IdeaItemModelView) -> Binding<IdeaItemModelView> {
        Binding<IdeaItemModelView>.constant(idea)
    }
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Text("Ideas List")
                        .fontWeight(.bold)
                        .modifier(TitleListModifier())
                    Button(action: {
                        self.isRotated.toggle()
                        loadData()
                    }) {
                        Image(systemName: "arrow.counterclockwise")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .rotationEffect(Angle.degrees(isRotated ? 0 : 360))
                            .animation(.easeInOut)
                    }
                    .frame(width: 15, height: 15, alignment: .center)
                    .padding(.top, 50)
                }
                Spacer()
                Button(action: {
                    //temporary solution
                    doLogout { isLogged in
                        if !isLogged {
                            withAnimation {
                                isLoggedIn = false
                            }
                        }
                    }
                }) {
                    Image("profile")
                        .resizable()
                        .modifier(ProfileImageModifier())
                }
            }
            .frame(width: Constants.screenSize.width)
            .padding([.top, .leading, .trailing])
            
            ScrollView {
                if loading {
                    Loading()
                        .frame(width: Constants.screenSize.width * 0.9, height: Constants.screenSize.height * 0.7, alignment: .bottom)
                        .background(Color.clear)
                }
                else {
                    SearchBar(text: $searchText)
                        .frame(width: Constants.screenSize.width * 0.95, alignment: .center)
                    Group {
                        Text("Categories")
                            .modifier(CategoriesTitleModifier())
                        
                        ScrollView([.horizontal], showsIndicators: false) {
                            HStack(spacing: 15) {
                                CategoryBubble(categories: $categories)
                                    .onChange(of: categories, perform: applyFilter)
                            }
                            .frame(height: 50)
                            .padding(.horizontal, 50)
                        }
                    }
                    
                    if filterLoading {
                        Loading()
                            .frame(width: Constants.screenSize.width * 0.9, height: Constants.screenSize.height * 0.7, alignment: .bottom)
                            .background(Color.clear)
                    }
                    else if ideasList.count > 0 {
                        ForEach(ideasList.filter { filterIdea in
                            (self.searchText.isEmpty ? true :
                                filterIdea.title.lowercased().contains(self.searchText.lowercased()) ||
                                filterIdea.author.lowercased().contains(self.searchText.lowercased()))
                        }) { idea in
                            DreamCard(item: createIdeaBinding(idea))
                                .onTapGesture {
                                    self.selectedIdea = idea
                                    ideaDetailsPresented = true
                                }
                                .scaleEffect(scale)
                                .sheet(
                                    isPresented: $ideaDetailsPresented,
                                    onDismiss: {
                                        if didChangeData {
                                            loadData()
                                        }
                                    },
                                    content: {
                                        IdeaDetailsView(ideaId: self.selectedIdea!.id, didChangeData: $didChangeData)
                                    }
                                )
                        }
                        .transition(.move(edge: .trailing))
                    }
                    else {
                        VStack(alignment: .center) {
                            Image(systemName: "eyes.inverse")
                                .resizable()
                                .frame(width: 35, height: 35, alignment: .center)
                                .foregroundColor(.white)
                            Text("There are no ideas available at the moment")
                                .modifier(NoIdeasLabelModifier())
                        }
                        .padding(.top, 100)
                        .padding(.horizontal, 50)
                        .transition(.move(edge: .bottom))
                        
                    }
                    
                    
                }
                
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: colorScheme == .dark ? Constants.background.reversed() : Constants.background), startPoint: .bottom, endPoint: .top)
        )
        .edgesIgnoringSafeArea(.top)
        .blur(radius: self.ideaDetailsPresented ? 3.0 : 0.0)
        .onAppear() {
            loadData()
            appliedFilters = categories.filter { $0.selected }
        }
    }
    
}
