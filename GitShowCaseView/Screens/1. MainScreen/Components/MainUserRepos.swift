//
//  MainUserRepos.swift
//  GitShowCaseView
//
//  Created by user on 31.12.2025.
//

import SwiftUI

struct MainUserRepos: View {
    let repos: [Repositories]
    let total: Int
    var body: some View {
        VStack{
            ScrollView(){
                    HStack{
                        Text("Repositories:")
                            .font(.title2.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        Text("Total \(total)")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                    .padding(10)
                    VStack{
                        ForEach(repos.sorted(by: {$0.updatedAt ?? Date() > $1.updatedAt ?? Date()}), id: \.self){ repo in
                            VStack(alignment: .leading){
                                
                                Text(repo.name)
                                    .font(.title2.bold())
                                
                                HStack{
                                    Image(systemName: "circle.fill")
                                    Text(repo.language ?? "language not available")
                                }
                                .foregroundStyle(LanguageColor(rawValue: repo.language?.lowercased() ?? "")?.color ?? .gray)
                                
                                Text("latest upload \(repo.updatedAt?.formatted() ?? "")")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(.gray, lineWidth: 2)
                            )
                        }
                    }
                    .padding(.horizontal)
                
            }
            
        }
    }
}

#Preview {
    MainUserRepos(repos: [], total: 5)
}
