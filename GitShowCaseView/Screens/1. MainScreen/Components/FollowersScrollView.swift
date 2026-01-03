//
//  FollowersScrollView.swift
//  GitShowCaseView
//
//  Created by user on 01.01.2026.
//

import SwiftUI

struct FollowersScrollView: View {
    @Environment(NavigationRouter.self) var router
    var moreUsers: Bool
    let loadFollowers: () async -> Void
    let followers: [Followers]
    var isExpanded: Bool = false
    var body: some View {
        let size: CGSize = isExpanded ? CGSize(width: 60, height: 60) : CGSize(width: 30, height: 30)
        if !(followers.isEmpty) {
            ScrollView(.horizontal){
                HStack{
                    ForEach(followers, id: \.id) { follower in
                        Button{router.pushProfile(follower.login)}label:{
                            VStack{
                                AsyncImage(url: follower.avatarURL) { image in
                                    image
                                        .resizable()
                                        .clipShape(Circle())
                                } placeholder: {
                                    Circle()
                                        .fill(Color.black)
                                        .overlay(
                                            Image(systemName: "person")
                                                .font(.title)
                                                .foregroundStyle(.white)
                                        )
                                }
                                .frame(width: size.width, height: size.height)
                                
                                if isExpanded{
                                    Text(follower.login)
                                        .font(.caption2)
                                }
                            }
                        }
                        if follower.id == followers.last!.id{
                            Button{
                                if moreUsers{
                                    Task{
                                        await loadFollowers()
                                    }
                                }
                            }label:{
                                Image(systemName: "plus")
                                    .frame(width: size.width, height: size.height)
                            }
                            .disabled(!moreUsers)
                            .opacity(moreUsers ? 1.0 : 0)
                        }
                    }
                }
            }
            .scrollTargetBehavior(.paging)
            .animation(.easeInOut, value: followers)
            .animation(.easeInOut, value: size)
        }else{
            Text("No followers.")
        }
        
    }
}

#Preview {
    FollowersScrollView(moreUsers: false, loadFollowers: {},followers: [], isExpanded: false)
}
