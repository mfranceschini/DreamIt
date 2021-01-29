//
//  DreamCard.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-10-15.
//

import SwiftUI

struct DreamCard: View {
    
    @Binding var item: IdeaItemModelView
    @State private var isRotated = false
    @State private var isLiked = false

    private func likeIdea() {
        let api = API()
        
        self.isLiked.toggle()
        self.isRotated.toggle()
        api.setLikedIdea(likedIdeaId: item.id) {_ in
            item.setIdeaLike()
        }
    }
    
    var body: some View {
        Group {
            VStack {
                HStack {
                    Button(action: {
                        withAnimation {
                            likeIdea()
                        }
                    }) {
                        Image(systemName: self.isLiked ? "hand.thumbsup.fill" : "hand.thumbsup")
                            .modifier(LikeModifier(liked: self.isLiked))
                        .rotation3DEffect(Angle.degrees(isRotated ? 0 : 360), axis: (x: 0, y: 1, z: 0))
                        .animation(.easeInOut)
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
                        Text(self.item.title.localizedCapitalized)
                            .fontWeight(.bold)
                            .frame(alignment: .leading)
                            .modifier(DreamTitleModifier())
                        Text("by \(self.item.author.localizedCapitalized)")
                            .fontWeight(.bold)
                            .frame(alignment: .leading)
                            .modifier(DreamAuthorModifier())
                    }
                    .padding(.leading, 10)
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text(self.item.impressions.description)
                        .fontWeight(.bold)
                        .modifier(DreamImpressionsModifier())
                    Image(systemName: "eye.fill")
                        .foregroundColor(Color(UIColor.lightGray))
                        .padding(.trailing)
                }
                .opacity(0.6)
            }
            .modifier(ContainerModifier())
        }
        .onAppear() {
            self.isLiked = item.liked
        }
    }
    
}
