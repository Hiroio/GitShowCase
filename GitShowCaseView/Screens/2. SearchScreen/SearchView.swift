//
//  SearchView.swift
//  GitShowCaseView
//
//  Created by user on 31.12.2025.
//

import SwiftUI

struct SearchView: View {
    @State private var searchVM: SearchViewModel = .init()
    @State private var searchText: String = ""
    @State private var searchState: Bool = true
    @Binding  var isURL: Bool
    @Binding  var url: URL?
    var body: some View {
        VStack{
            HStack{
                TextField("UserName", text: $searchText)
                    .padding()
                    .background(
                        Color.gray.opacity(0.1)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.black, lineWidth: 2)
                    )
                
                Button{
                    searchVM.search(name: searchText)
                    searchState = false
                }label:{
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.white)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                        )
                }
            }
            
            if let user = searchVM.searchUser{
                UserDetail(user: user, repos: searchVM.searchUserRepos, followers: searchVM.followers, loadMoreFollowers: searchVM.followersPagination, moreUsers: searchVM.hasMoreUsers ,isURL: $isURL, url: $url)
            }else{
                Spacer()
                switch searchVM.screenState{
                case .error, .inCorrectUsername:
                    VStack{
                        Text("Error: User not found")
                        Image(systemName: "smiley")
                            .foregroundStyle(.red)
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
        .padding(5)
    }
}

#Preview {
    SearchView(isURL: .constant(false), url: .constant(URL(string: "github")!))
        .environment(MainUserViewModel())
}
