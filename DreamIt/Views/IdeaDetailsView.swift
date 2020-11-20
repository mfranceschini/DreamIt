//
//  IdeaDetailsView.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-11-10.
//

import SwiftUI

struct IdeaDetailsView: View {
    
    @Binding var ideaData: IdeaItemModelView
    
    var body: some View {
        VStack {
            ScrollView {
                CloseModalLip()
                    .padding()
                HStack() {
                    Image(uiImage: ideaData.thumbnail)
                        .resizable()
                        .frame(width: 90, height: 90, alignment: .leading)
                    VStack(alignment: .leading) {
                        Text(ideaData.title)
                            .fontWeight(.bold)
                            .modifier(TitleModifier())
                            .frame(width: Constants.screenSize.width * 0.6, alignment: .leading)
                        Text(ideaData.author)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .modifier(AuthorModifier())
                            .frame(width: Constants.screenSize.width * 0.6, alignment: .leading)
                    }
                }
                .padding(.top)
                
                HStack {
                    Text(ideaData.impressions)
                        .modifier(ImpressionsLabelModifier())
                        .padding(.leading, 30)
                    Image(systemName: "eye.fill")
                        .foregroundColor(Color(UIColor.lightGray))
                    Spacer()
                    Text(ideaData.postDate)
                        .modifier(PostDateLabelModifier())
                        .padding(.trailing, 30)
                    
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Idea Description")
                        .fontWeight(.bold)
                        .frame(width: Constants.screenSize.width * 0.9, alignment: .leading)
                        .modifier(BodyTitleModifier())
                    Text("This is the idea description")
                        .modifier(BodyLabelModifier())
                        .frame(width: Constants.screenSize.width * 0.9, alignment: .leading)
                }
                .padding([.leading, .bottom, .top])
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Platform Availability")
                        .fontWeight(.bold)
                        .modifier(BodyTitleModifier())
                        .frame(width: Constants.screenSize.width * 0.9, alignment: .leading)
                    Text("Mobile App, Website")
                        .modifier(BodyLabelModifier())
                        .frame(width: Constants.screenSize.width * 0.9, alignment: .leading)
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Attached files")
                        .fontWeight(.bold)
                        .modifier(BodyTitleModifier())
                        .frame(width: Constants.screenSize.width * 0.9, alignment: .leading)
                    VStack(alignment: .leading) {
                        HStack {
                            Text("filename.pdf")
                                .font(.callout)
                                .padding(.all, 10)
                                .background(Color.gray)
                                .clipShape(Capsule())
                            Text("filename.pdf")
                                .font(.callout)
                                .padding(.all, 10)
                                .background(Color.gray)
                                .clipShape(Capsule())
                        }
                        .frame(width: Constants.screenSize.width * 0.9, alignment: .leading)
                        
                        Text("filename.pdf")
                            .font(.callout)
                            .padding(.all, 10)
                            .background(Color.gray)
                            .clipShape(Capsule())
                        
                    }
                    .padding(.leading)
                }
                .padding()
                
                Spacer()
                
                VStack {
                    Button(self.ideaData.liked ? "Liked" : "Like", action: {
                        withAnimation {
                            self.ideaData.liked.toggle()
                        }
                    })
                    .buttonStyle(LikeButtonStyle(isLiked: self.ideaData.liked))

                    Button("I'm interested", action: {})
                        .buttonStyle(InterestedButtonStyle())
                }
                .padding(.top, 50)
            }
        }
        
    }
}

//struct IdeaDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        IdeaDetailsView(ideaData: IdeaItemModelView(ideaItem: IdeaItemModel(title: "Mobile game", author: "Johnny Deep", createdAt: Date(), impressions: 1000, liked: false, thumbnail: UIImage(named: "test")!)))
//    }
//}
