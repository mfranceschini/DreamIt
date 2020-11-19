//
//  DreamListView.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-10-15.
//

import SwiftUI

struct DreamListView: View {
    
    let categories: [CategoryModel] = [
        CategoryModel(name: "Mobile Apps", selected: true),
        CategoryModel(name: "Websites", selected: false),
        CategoryModel(name: "UX Design", selected: false),
        CategoryModel(name: "Drawing", selected: false),
        CategoryModel(name: "Websites", selected: false),
        CategoryModel(name: "Mobile Apps", selected: false)
    ]
    
    let ideasList: [IdeaItemModelView] = [
        IdeaItemModelView(ideaItem: IdeaItemModel(title: "App for finance", author: "Joe Doe", createdAt: Date(timeIntervalSinceNow: -86400 * 366), impressions: 23, liked: true, thumbnail: UIImage(named: "test")!)),
        IdeaItemModelView(ideaItem: IdeaItemModel(title: "Website for portfolio", author: "Camila Avelar", createdAt: Date(), impressions: 4200, liked: false, thumbnail: UIImage(named: "test")!)),
        IdeaItemModelView(ideaItem: IdeaItemModel(title: "Design for iOS app", author: "Gareth Bale", createdAt: Date(), impressions: 44, liked: true, thumbnail: UIImage(named: "test")!)),
        IdeaItemModelView(ideaItem: IdeaItemModel(title: "Mobile game", author: "Johnny Deep", createdAt: Date(), impressions: 1000, liked: false, thumbnail: UIImage(named: "test")!)),
        IdeaItemModelView(ideaItem: IdeaItemModel(title: "App for finance", author: "Joe Doe", createdAt: Date(), impressions: 23, liked: false, thumbnail: UIImage(named: "test")!)),
        IdeaItemModelView(ideaItem: IdeaItemModel(title: "Website for portfolio", author: "Camila Avelar", createdAt: Date(), impressions: 4200, liked: false, thumbnail: UIImage(named: "test")!)),
        IdeaItemModelView(ideaItem: IdeaItemModel(title: "Design for iOS app", author: "Gareth Bale", createdAt: Date(), impressions: 44, liked: false, thumbnail: UIImage(named: "test")!)),
        IdeaItemModelView(ideaItem: IdeaItemModel(title: "Mobile game", author: "Johnny Deep", createdAt: Date(), impressions: 1000, liked: false, thumbnail: UIImage(named: "test")!)),
        IdeaItemModelView(ideaItem: IdeaItemModel(title: "App for finance", author: "Joe Doe", createdAt: Date(), impressions: 23, liked: false, thumbnail: UIImage(named: "test")!)),
        IdeaItemModelView(ideaItem: IdeaItemModel(title: "Website for portfolio", author: "Camila Avelar", createdAt: Date(), impressions: 4200, liked: false, thumbnail: UIImage(named: "test")!)),
        IdeaItemModelView(ideaItem: IdeaItemModel(title: "Design for iOS app", author: "Gareth Bale", createdAt: Date(), impressions: 44, liked: false, thumbnail: UIImage(named: "test")!)),
        IdeaItemModelView(ideaItem: IdeaItemModel(title: "Mobile game", author: "Johnny Deep", createdAt: Date(), impressions: 1000, liked: false, thumbnail: UIImage(named: "test")!)),
    ]
    
    @State var ideaDetailsPresented: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                Group {
                    Text("Categories")
                        .modifier(CategoriesTitleModifier())
                    
                    ScrollView([.horizontal], showsIndicators: false) {
                        HStack(spacing: 20) {
                            CategoryBubble(categories: categories)
                        }
                        .frame(height: 50)
                        .padding(.horizontal, 50)
                    }
                }
                
                ForEach(0 ..< ideasList.count) { index in
                    Button(action: { ideaDetailsPresented = true }) {
                        DreamCard(item: ideasList[index])
                    }
                    .sheet(isPresented: $ideaDetailsPresented, content: { IdeaDetailsView(ideaData: ideasList[index]) })
                }
                
            }
            .padding(.bottom, Constants.screenSize.height * 0.27)
            .modifier(ScrollViewModifier())
            .navigationBarItems(trailing:
                Button(action: {
                    print("Navigation bar item action")
                }) {
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .font(Font.system(.title))
                        .padding(.all, 7)
                        .background(Color.blue)
                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                }
            )
        }
        .blur(radius: self.ideaDetailsPresented ? 3.0 : 0.0)
    }
    
}

struct DreamListView_Previews: PreviewProvider {
    static var previews: some View {
        DreamListView(ideaDetailsPresented: false)
    }
}
