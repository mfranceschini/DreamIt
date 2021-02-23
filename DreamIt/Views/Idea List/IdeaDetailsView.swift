//
//  IdeaDetailsView.swift
//  DreamIt
//
//  Created by Matheus Franceschini on 2020-11-10.
//

import SwiftUI

struct IdeaDetailsView: View {
    
    @State var ideaId: String
    @State var ideaImpressions: String
    @State var ideaData: IdeaItemModelView?
    @State var isLiked: Bool = false
    @State var loading: Bool = false
    @Binding var didChangeData: Bool
    @Environment(\.colorScheme) var colorScheme
    let api = API()
    
    private func loadData() {
        self.loading = true
        api.increaseImpressionsCounter(ideaId: ideaId, currentImpressions: ideaImpressions) {
            api.getIdeasById(ideaId: ideaId) { idea in
                self.isLiked = idea.liked
                ideaData = idea
                self.loading = false
                didChangeData = true
            }
        }
    }
    
    private func likeIdea() {
        let api = API()
        
        self.isLiked.toggle()
        api.setLikedIdea(likedIdeaId: ideaId) {_ in
            loadData()
            didChangeData = true
        }
    }
    
    var body: some View {
        VStack {
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
            else if let ideaData = ideaData {
                ZStack(alignment: .bottom) {
                    ScrollView {
                        CloseModalLip()
                            .padding()
                        HStack() {
                            Image(uiImage: ideaData.thumbnail)
                                .resizable()
                                .renderingMode(.template)
                                .accentColor(colorScheme == .dark ? .white : .black)
                                .frame(width: 80, height: 80, alignment: .leading)
                            VStack(alignment: .leading) {
                                Text(ideaData.title.localizedCapitalized)
                                    .fontWeight(.bold)
                                    .modifier(TitleModifier())
                                    .frame(width: Constants.screenSize.width * 0.6, alignment: .leading)
                                Text("by \(ideaData.author.localizedCapitalized)")
                                    .fontWeight(.semibold)
                                    .modifier(AuthorModifier())
                                    .frame(width: Constants.screenSize.width * 0.6, alignment: .leading)
                            }
                        }
                        .padding(.top)
                        
                        HStack {
                            Text(ideaData.impressions)
                                .fontWeight(.bold)
                                .modifier(ImpressionsLabelModifier())
                                .padding(.leading, 30)
                            Image(systemName: "eye.fill")
                                .foregroundColor(Color(UIColor.lightGray))
                            Spacer()
                            Text(ideaData.postDate)
                                .fontWeight(.bold)
                                .modifier(PostDateLabelModifier())
                                .padding(.trailing, 30)
                            
                        }
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Idea Description")
                                .fontWeight(.bold)
                                .frame(width: Constants.screenSize.width * 0.9, alignment: .leading)
                                .modifier(BodyTitleModifier())
                            Text(ideaData.description)
                                .modifier(BodyLabelModifier())
                                .frame(width: Constants.screenSize.width * 0.9, alignment: .leading)
                                .fixedSize(horizontal: false, vertical: true)
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
                                likeIdea()
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
            
        }
        .onAppear {
            loadData()
        }
    }
}
