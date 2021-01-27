//
//  IdeaDetailsView.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-11-10.
//

import SwiftUI

struct IdeaDetailsView: View {
    
    @Binding var ideaData: IdeaItemModelView
    @State var isLiked: Bool = false
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                ScrollView {
                    CloseModalLip()
                        .padding()
                    HStack() {
                        Image(uiImage: self.ideaData.thumbnail)
                            .resizable()
                            .frame(width: 90, height: 90, alignment: .leading)
                        VStack(alignment: .leading) {
                            Text(self.ideaData.title)
                                .fontWeight(.bold)
                                .modifier(TitleModifier())
                                .frame(width: Constants.screenSize.width * 0.6, alignment: .leading)
                            Text(self.ideaData.author)
                                .fontWeight(.bold)
                                .modifier(AuthorModifier())
                                .frame(width: Constants.screenSize.width * 0.6, alignment: .leading)
                        }
                    }
                    .padding(.top)
                    
                    HStack {
                        Text(self.ideaData.impressions)
                            .modifier(ImpressionsLabelModifier())
                            .padding(.leading, 30)
                        Image(systemName: "eye.fill")
                            .foregroundColor(Color(UIColor.lightGray))
                        Spacer()
                        Text(self.ideaData.postDate)
                            .modifier(PostDateLabelModifier())
                            .padding(.trailing, 30)
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Idea Description")
                            .fontWeight(.bold)
                            .frame(width: Constants.screenSize.width * 0.9, alignment: .leading)
                            .modifier(BodyTitleModifier())
                        Text(self.ideaData.description)
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
                                    .foregroundColor(.white)
                                    .background(Color.gray)
                                    .clipShape(Capsule())
                                Text("filename.pdf")
                                    .font(.callout)
                                    .padding(.all, 10)
                                    .foregroundColor(.white)
                                    .background(Color.gray)
                                    .clipShape(Capsule())
                            }
                            .frame(width: Constants.screenSize.width * 0.9, alignment: .leading)
                            
                            Text("filename.pdf")
                                .font(.callout)
                                .padding(.all, 10)
                                .foregroundColor(.white)
                                .background(Color.gray)
                                .clipShape(Capsule())
                            Text("filename.pdf")
                                .font(.callout)
                                .padding(.all, 10)
                                .foregroundColor(.white)
                                .background(Color.gray)
                                .clipShape(Capsule())
                            Text("filename.pdf")
                                .font(.callout)
                                .padding(.all, 10)
                                .foregroundColor(.white)
                                .background(Color.gray)
                                .clipShape(Capsule())
                            Text("filename.pdf")
                                    .font(.callout)
                                    .padding(.all, 10)
                                    .foregroundColor(.white)
                                    .background(Color.gray)
                                    .clipShape(Capsule())
                            Text("filename.pdf")
                                .font(.callout)
                                .padding(.all, 10)
                                .foregroundColor(.white)
                                .background(Color.gray)
                                .clipShape(Capsule())
                            
                        }
                        .padding(.leading)
                    }
                    .padding()
                    .padding(.bottom, Constants.screenSize.height * 0.2)
                }

                VStack {
                    Button(action: {
                        withAnimation {
                            self.ideaData.liked.toggle()
                            self.isLiked = self.ideaData.liked
                        }
                    }) {
                        Text(isLiked ? "Liked" : "Like")
                    }
                    .buttonStyle(LikeButtonStyle(isLiked: isLiked))

                    
                    Button("I'm interested", action: {})
                        .buttonStyle(InterestedButtonStyle())
                }
                .padding(.bottom)
            }
        }
        .onAppear {
            self.isLiked = self.ideaData.liked
        }
    }
}
