//
//  DreamCard.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-10-15.
//

import SwiftUI

struct DreamCard: View {
    
    var item: IdeaItemModelView
    
    var body: some View {
        Group {
            VStack {
                HStack {
                    Image(systemName: item.liked ? "hand.thumbsup.fill" : "hand.thumbsup")
                        .foregroundColor(item.liked ? Color.blue : Color(UIColor.lightGray))
                        .modifier(LikeModifier())
                    Text(item.postDate)
                        .fontWeight(.bold)
                        .modifier(DaysAfterPostLabelModifier())
                }
                .opacity(0.6)
                .padding()
                HStack {
                    Image(uiImage: item.thumbnail)
                        .resizable()
                        .modifier(DreamImageModifier())
                    VStack {
                        Text(item.title)
                            .fontWeight(.bold)
                            .frame(width: Constants.screenSize.width * 0.7, alignment: .leading)
                            .modifier(DreamTitleModifier())
                        Text("by \(item.author)")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .frame(width: Constants.screenSize.width * 0.7, alignment: .leading)
                            .modifier(DreamAuthorModifier())
                    }
                    .padding(.leading, 10)
                }
                HStack {
                    Text(item.impressions.description)
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

struct DreamCardView_Previews: PreviewProvider {
    static var previews: some View {
        DreamCard(item: IdeaItemModelView(ideaItem: IdeaItemModel(title: "Mobile game", author: "Johnny Deep", createdAt: Date(), impressions: 1000, liked: false, thumbnail: UIImage(named: "test")!)))
    }
}
