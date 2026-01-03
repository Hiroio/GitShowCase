//
//  MainView.swift
//  GitShowCaseView
//
//  Created by user on 30.12.2025.
//

import SwiftUI

struct MainView: View {
    @Environment(MainUserViewModel.self) var userVM
    @Binding var url: URL?
    @Binding var isURL: Bool
    
    var body: some View {
        VStack{
            if let user = userVM.mainUser{
                UserDetail(user: user, repos: userVM.mainRepos, followers: userVM.followers, loadMoreFollowers: userVM.followersPagination, moreUsers: userVM.hasMoreUsers ,isURL: $isURL, url: $url)
            }else{
                Spacer()
                switch userVM.screenState{
                case .error:
                    VStack{
                        Text("Error: User not found")
                        Image(systemName: "smiley")
                            .foregroundStyle(.red)
                        Button{
                            Task{
                                await userVM.loadMainUser()
                            }
                        }label:{
                            Image(systemName: "arrow.2.circlepath")
                                .foregroundStyle(.white)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.yellow)
                                )
                        }
                    }.font(.title.bold())
                case .loading:
                    VStack{
                        Text("Loading...")
                            .font(.title.bold())
                        ProgressView()
                    }
                default:
                    EmptyView()
                }
            }
            Spacer()
        }

    }
}

#Preview {
    MainView(url: .constant(URL(string: "")), isURL: .constant(false))
        .environment(MainUserViewModel())
}
