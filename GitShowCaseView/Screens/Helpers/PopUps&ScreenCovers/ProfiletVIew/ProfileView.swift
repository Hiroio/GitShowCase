//
//  ProfileView.swift
//  GitShowCaseView
//
//  Created by user on 02.01.2026.
//

import SwiftUI

struct ProfileView: View {
    @State private var profileVM = SearchViewModel()
    let username: String
    @Binding var url: URLSheet?
    var body: some View {
        VStack{
            if let user = profileVM.searchUser{
                VStack(spacing: 0){
                    UserDetail(user: user, repos: profileVM.searchUserRepos, followers: profileVM.followers, loadMoreFollowers: profileVM.followersPagination, moreUsers: profileVM.hasMoreUsers, url: $url)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(lineWidth: 2)
                )
                .padding(5)
            }
            Spacer()
        }
        .task {
            profileVM.search(name: username)
        }
    }
}

#Preview {
    ProfileView(username: "Hiroio", url: .constant(URLSheet(url: URL(string: "")!)))
}
