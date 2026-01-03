//
//  MainUserViewModel.swift
//  GitShowCaseView
//
//  Created by user on 31.12.2025.
//

import Foundation


@MainActor
@Observable
class MainUserViewModel{
    var mainUser: UserDecoder?
    var mainRepos: [Repositories]?
    var screenState : ScreenState = .preload
    var followers: [Followers] = []
    var hasMoreUsers: Bool = true
    var page = 1
    
    init() {
        Task{
            await loadMainUser()
        }
    }
    
    
    func loadMainUser() async {
        followers = []
        do {
            screenState = .loading
            async let user = APIManager.fetchUser("Hiroio")
            async let repos = APIManager.fetchRepo("Hiroio")
            async let followers = followersPagination
            
            (mainUser, mainRepos) = try await (user, repos)
            let _ =  await followers()
            screenState = .loaded
        } catch {
            handle(error)
        }
    }
    
    
    func followersPagination() async {
        do {
            async let followersfetch = APIManager.fetchFollowers(name: "Hiroio", page: page)
            
            let followers = try await followersfetch
                if followers.count < 30{
                    hasMoreUsers = false
                }else{
                    hasMoreUsers = true
                }
            self.followers.append(contentsOf: followers)
                page += 1

        } catch {
            handle(error)
        }
    }
    
    private func handle(_ error: Error) {
        switch error {
        case GHError.invalidData:
            screenState = .error
            print("ErrorData decode")
        case GHError.invalidResponse:
            screenState = .error
            print("response error")
        case GHError.invalidURL:
            screenState = .error
            print("invalid URL")
        default:
            screenState = .error
            print("unexpected Error")
        }
    }
}
