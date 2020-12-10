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
    
    @State var categories: [CategoryModel] = [
        CategoryModel(id: 1,name: "Mobile Apps", selected: true),
        CategoryModel(id: 2,name: "Websites", selected: false),
        CategoryModel(id: 3,name: "UX Design", selected: false),
        CategoryModel(id: 4,name: "Drawing", selected: false),
        CategoryModel(id: 5,name: "Websites", selected: false),
        CategoryModel(id: 6,name: "Mobile Apps", selected: false)
    ]
    
    @State var ideasList: [IdeaItemModelView] = [
        IdeaItemModelView(ideaItem: IdeaItemModel(category: 1, title: "App for finance", author: "Joe Doe", createdAt: Date(timeIntervalSinceNow: -86400 * 366), impressions: 23, liked: true, thumbnail: UIImage(named: "test")!)),
        IdeaItemModelView(ideaItem: IdeaItemModel(category: 2,title: "Website for portfolio", author: "Camila Avelar", createdAt: Date(), impressions: 4200, liked: false, thumbnail: UIImage(named: "test")!)),
        IdeaItemModelView(ideaItem: IdeaItemModel(category: 1,title: "Design for iOS app", author: "Gareth Bale", createdAt: Date(), impressions: 44, liked: true, thumbnail: UIImage(named: "test")!)),
        IdeaItemModelView(ideaItem: IdeaItemModel(category: 3,title: "Mobile game", author: "Johnny Deep", createdAt: Date(), impressions: 1000, liked: false, thumbnail: UIImage(named: "test")!)),
        IdeaItemModelView(ideaItem: IdeaItemModel(category: 1,title: "App for finance", author: "Joe Doe", createdAt: Date(), impressions: 23, liked: false, thumbnail: UIImage(named: "test")!)),
        IdeaItemModelView(ideaItem: IdeaItemModel(category: 2,title: "Website for portfolio", author: "Camila Avelar", createdAt: Date(), impressions: 4200, liked: false, thumbnail: UIImage(named: "test")!)),
        IdeaItemModelView(ideaItem: IdeaItemModel(category: 3,title: "Design for iOS app", author: "Gareth Bale", createdAt: Date(), impressions: 44, liked: false, thumbnail: UIImage(named: "test")!)),
        IdeaItemModelView(ideaItem: IdeaItemModel(category: 1,title: "Mobile game", author: "Johnny Deep", createdAt: Date(), impressions: 1000, liked: false, thumbnail: UIImage(named: "test")!)),
        IdeaItemModelView(ideaItem: IdeaItemModel(category: 1,title: "App for finance", author: "Joe Doe", createdAt: Date(), impressions: 23, liked: false, thumbnail: UIImage(named: "test")!)),
        IdeaItemModelView(ideaItem: IdeaItemModel(category: 2,title: "Website for portfolio", author: "Camila Avelar", createdAt: Date(), impressions: 4200, liked: false, thumbnail: UIImage(named: "test")!)),
        IdeaItemModelView(ideaItem: IdeaItemModel(category: 1,title: "Design for iOS app", author: "Gareth Bale", createdAt: Date(), impressions: 44, liked: false, thumbnail: UIImage(named: "test")!)),
        IdeaItemModelView(ideaItem: IdeaItemModel(category: 1,title: "Mobile game", author: "Johnny Deep", createdAt: Date(), impressions: 1000, liked: false, thumbnail: UIImage(named: "test")!)),
    ]
    
    @State var ideaDetailsPresented: Bool = false
    @State private var loading: Bool = true
    @State private var scale: CGFloat = 1
    @State private var searchText : String = ""
    @Environment(\.colorScheme) var colorScheme
    @Binding var selectedTab: String
    
    var body: some View {
        VStack {
            HStack {
                Text("Ideas List")
                    .fontWeight(.bold)
                    .modifier(TitleListModifier())
                Spacer()
                Button(action: {
                    selectedTab = "profile"
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
                                CategoryBubble(categories: $categories, ideaList: $ideasList)
                            }
                            .frame(height: 50)
                            .padding(.horizontal, 50)
                        }
                    }
                    
                    if self.ideasList.count > 0 {
                        ForEach(self.ideasList.indices.filter { index in
                            (self.searchText.isEmpty ? true :
                                self.ideasList[index].title.lowercased().contains(self.searchText.lowercased()) ||
                                self.ideasList[index].author.lowercased().contains(self.searchText.lowercased()))
                        }, id: \.self) { ideaIndex in
                            DreamCard(item: $ideasList[ideaIndex])
                                .onTapGesture { self.ideaDetailsPresented = true }
                                .scaleEffect(scale)
                                .sheet(
                                    isPresented: $ideaDetailsPresented,
                                    content: { IdeaDetailsView(ideaData: $ideasList[ideaIndex]) }
                                )
                        }
                    }
                    else {
                        Text("There are no ideas available at the moment.")
                            .modifier(NoIdeasLabelModifier())
                    }
                }
                
            }
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    self.loading = false
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
    }
    
}

//struct DreamListView_Previews: PreviewProvider {
//    static var previews: some View {
//        IdeaListView()
//    }
//}
