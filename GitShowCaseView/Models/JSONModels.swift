//
//  JSONModels.swift
//  GitShowCaseView
//
//  Created by user on 30.12.2025.
//

import Foundation



struct UserDecoder: Decodable {
    let login: String
    let avatar_url: String
    let html_url: String
    let repos_url: String
    let type: String
    let name: String
    let location: String?   
    let bio: String?
    let followers: Int
    let public_repos: Int
    let created_at: String
    
    var avatarURL: URL {
        URL(string: avatar_url)!
    }
    var createdAt: Date {
        ISO8601DateFormatter().date(from: created_at) ?? Date()
    }
    
    static let shared = UserDecoder(login: "Hiroio", avatar_url: "https://avatars.githubusercontent.com/u/76852167?v=4", html_url: "https://github.com/users/Hiroio", repos_url: "https://api.github.com/users/Hiroio/repos", type: "User", name: "Vlad", location: "Ukraine", bio: "Hi! I`m Vlad, I'm from Ukraine", followers: 10, public_repos: 9, created_at: "2021-01-01T21:15:55Z")
    
    
    init(login: String, avatar_url: String, html_url: String, repos_url: String, type: String, name: String, location: String, bio: String, followers: Int, public_repos: Int, created_at: String) {
        self.login = login
        self.avatar_url = avatar_url
        self.html_url = html_url
        self.repos_url = repos_url
        self.type = type
        self.name = name
        self.location = location
        self.bio = bio
        self.followers = followers
        self.public_repos = public_repos
        self.created_at = created_at
    }
}


    struct Repositories: Decodable, Hashable, Identifiable {
        let id: Int
        let name: String
        let html_url: String
        let description: String?
        let updated_at: String
        let language: String?
        
        var url: URL{
            URL(string: html_url)!
        }
        
        var updatedAt: Date? {
            ISO8601DateFormatter().date(from: updated_at)
        }
    }


struct Followers: Decodable, Hashable, Identifiable{
    var id: Int
    var login: String
    var avatar_url: String
    var url: String
    var html_url: String
    
    var avatarURL: URL {
        URL(string: avatar_url)!
    }
    
}
