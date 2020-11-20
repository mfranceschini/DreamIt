//
//  DreamCard.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-10-15.
//

import SwiftUI

struct DreamCard: View {
    
    @Binding var item: IdeaItemModelView
    
    var body: some View {
        Group {
            VStack {
                HStack {
                    Button(action: {
                        withAnimation {
                            self.item.liked.toggle()
                        }
                    }) {
                    Image(systemName: self.item.liked ? "hand.thumbsup.fill" : "hand.thumbsup")
                        .modifier(LikeModifier(liked: self.item.liked))
                    }
                    Spacer()
                    Text(self.item.postDate)
                        .fontWeight(.bold)
                        .modifier(DaysAfterPostLabelModifier())
                }
                .opacity(0.6)
                .padding()
                
                HStack {
                    Image(uiImage: self.item.thumbnail)
                        .resizable()
                        .modifier(DreamImageModifier())
                    VStack(alignment: .leading) {
                        Text(self.item.title)
                            .fontWeight(.bold)
                            .frame(alignment: .leading)
                            .modifier(DreamTitleModifier())
                        Text("by \(self.item.author)")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .frame(alignment: .leading)
                            .modifier(DreamAuthorModifier())
                    }
                    .padding(.leading, 10)
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text(self.item.impressions.description)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .modifier(DreamImpressionsModifier())
                    Image(systemName: "eye.fill")
                        .foregroundColor(Color(UIColor.lightGray))
                        .padding(.trailing)
                }
                .opacity(0.6)
            }
            .modifier(ContainerModifier())
        }
    }
    
}

//struct DreamCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        DreamCard(item: IdeaItemModelView(ideaItem: IdeaItemModel(title: "Mobile game", author: "Johnny Deep", createdAt: Date(), impressions: 1000, liked: false, thumbnail: UIImage(named: "test")!)))
//    }
//}
