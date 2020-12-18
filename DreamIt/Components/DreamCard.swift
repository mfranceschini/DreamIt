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

    
    var body: some View {
        Group {
            VStack {
                HStack {
                    Button(action: {
                        withAnimation {
                            self.isRotated.toggle()
                            self.item.liked.toggle()
                        }
                    }) {
                        Image(systemName: self.item.liked ? "hand.thumbsup.fill" : "hand.thumbsup")
                            .modifier(LikeModifier(liked: self.item.liked))
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
                        Text(self.item.title)
                            .fontWeight(.bold)
                            .frame(alignment: .leading)
                            .modifier(DreamTitleModifier())
                        Text("by \(self.item.author)")
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
    }
    
}
