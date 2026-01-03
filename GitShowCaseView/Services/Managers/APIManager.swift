//
//  API's.swift
//  GitShowCaseView
//
//  Created by user on 30.12.2025.
//

import Foundation

class APIManager {
    
    static func fetchUser(_ name: String) async throws -> UserDecoder{
        let endpoint = "https://api.github.com/users/\(name)"
        
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
    
    static func fetchRepo(_ name: String) async throws -> [Repositories]{
        let endpoint = "https://api.github.com/users/\(name)/repos"
        
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
    
    static func fetchFollowers(name: String, page: Int = 1, perPage: Int = 31) async throws -> [Followers]{
        let endpoint = "https://api.github.com/users/\(name)/followers?page=\(page)&per_page=\(perPage)"
        print(endpoint)
        
        guard let url = URL(string: endpoint) else {
            throw GHError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            throw GHError.invalidResponse
        }
        
        do{
            return try JSONDecoder().decode([Followers].self, from: data)
        } catch{
            throw GHError.invalidData
        }
    }
}
