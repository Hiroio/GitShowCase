//
//  API's.swift
//  GitShowCaseView
//
//  Created by user on 30.12.2025.
//

import Foundation

@Observable
class APIManager {
    
    var mainUser: UserDecoder?
    var mainRepos: [Repositories]?
    
    init() {
        Task{
            do{
                let userData = try await fetchUser()
                self.mainUser = userData
                
                let repos = try await fetchRepo()
                self.mainRepos = repos
                
            }catch GHError.invalidData{
                print("ErrorData decode")
            }catch GHError.invalidResponse{
                print("response error")
            }catch GHError.invalidURL{
                print("invalid URL")
            }catch{
                print("unexpected Error")
            }
        }
    }
    
    func fetchUser() async throws -> UserDecoder{
        let endpoint = "https://api.github.com/users/Hiroio"
        
        guard let url = URL(string: endpoint) else {
            throw GHError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            throw GHError.invalidResponse
        }
        
        do{
            return try JSONDecoder().decode(UserDecoder.self, from: data)
        } catch{
            throw GHError.invalidData
        }
    }
    func fetchRepo() async throws -> [Repositories]{
        let endpoint = "https://api.github.com/users/Hiroio/repos"
        
        guard let url = URL(string: endpoint) else {
            throw GHError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            throw GHError.invalidResponse
        }
        
        do{
            let list = try JSONDecoder().decode([Repositories].self, from: data)
            return list
        } catch{
            throw GHError.invalidData
        }
        
    }
}
