//
//  UserDetail.swift
//  GitShowCaseView
//
//  Created by user on 02.01.2026.
//

import SwiftUI

struct UserDetail: View {
    let user: UserDecoder
    let repos: [Repositories]?
    var followers: [Followers]
    let loadMoreFollowers: () async -> Void
    var moreUsers: Bool
    
    @Binding var isURL: Bool
    @Binding var url: URL?
    var body: some View {
        
            VStack{
                UserInfoHeader(user: user, followers: followers, isURL: $isURL, url: $url, loadMoreFollower: loadMoreFollowers, moreUsers: moreUsers)
                
                if let repos = repos{
                    MainUserRepos(repos: repos, total: user.public_repos)
                }else{
                    VStack{
                        Text("No public repos for current user")
                        
                        Image(systemName: "archivebox")
                    }
                    .font(.title2.bold())
                    .multilineTextAlignment(.center)
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 2)
            )
            .padding(5)
    }
}

#Preview {
    UserDetail(user: UserDecoder.shared, repos: nil, followers: [], loadMoreFollowers: {}, moreUsers: false, isURL: .constant(false), url: .constant(URL(string: "")))
}
