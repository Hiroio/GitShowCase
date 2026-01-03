//
//  SearchViewModel.swift
//  GitShowCaseView
//
//  Created by user on 02.01.2026.
//

import Foundation


@MainActor
@Observable
class SearchViewModel{
    var searchUser: UserDecoder?
    var searchUserRepos: [Repositories]?
    var screenState: ScreenState = .preload
    var followers: [Followers] = []
    var page = 1
    var hasMoreUsers = true
    
    
    private var username: String = ""
    
    private var searchTask: Task<Void, Never>?
    
    func search(name: String){
        screenState = .loading
        searchUser = nil
        searchUserRepos = nil
        followers = []
        username = name
        searchTask?.cancel()
        
        searchTask = Task{
            do{
                async let userData =  APIManager.fetchUser(name)
                async let repos = APIManager.fetchRepo(name)
                async let followers = followersPagination
                
                self.searchUser = try await userData
                self.searchUserRepos = try await repos
                let _ = await followers()
                if let _ = self.searchUser{
                    screenState = .loaded
                }else{
                    screenState = .inCorrectUsername
                }
            }catch is CancellationError{
                self.screenState = .preload
            }catch{
                handle(error)
            }
        }
    }
    
    func followersPagination() async {
        hasMoreUsers = true
        do {
            async let followersfetch = APIManager.fetchFollowers(name: username, page: page)
            
            let followers = try await followersfetch
            print(followers.count)
                if followers.count < 30{
                    hasMoreUsers = false
                }else{
                    hasMoreUsers = true
                }
            self.followers.append(contentsOf: followers)
                page += 1
        }catch is CancellationError{
            self.screenState = .preload
        }catch {
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
