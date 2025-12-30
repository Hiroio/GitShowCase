//
//  UserInfoHeader.swift
//  GitShowCaseView
//
//  Created by user on 30.12.2025.
//

import SwiftUI

struct UserInfoHeader: View {
    let user: UserDecoder
    var body: some View {
        VStack{
        HStack{
            VStack(alignment: .leading){
                HStack{
                    Image(systemName: "person.crop.square.filled.and.at.rectangle.fill")
                    Text(user.login)
                    
                }
                .font(.title.bold())
                Text(user.name)
                    .font(.title3.bold())
                Text(user.bio)
                    .lineLimit(nil)
                    .foregroundStyle(.secondary)
                Divider()
                HStack{
                    Text(user.html_url)
                        .font(.caption)
                        .foregroundStyle(.tint)
                    Text(EmojiLocation(rawValue: user.location.lowercased())?.emoji ?? "🏴‍☠️")
                }
                
                
                
            }
            
            
            Spacer()
            
            AsyncImage(url: user.avatarURL){image in
                image
                    .resizable()
            }placeholder: {
                Circle()
                    .fill(Color.black)
                    .overlay(
                        Image(systemName: "person")
                            .font(.title)
                            .foregroundStyle(.white)
                    )
            }
            .frame(width: 120, height: 120)
            .clipShape(Circle())
            
        }
            Text("⚪️ joined on: \(user.createdAt.formatted(.dateTime.day().month(.wide).year()))")
                .font(.caption)
                .foregroundStyle(.gray)
                .frame(maxWidth: .infinity, alignment: .trailing)
                
    }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(lineWidth: 2)
        )

        
    }
}

#Preview {
    UserInfoHeader(user: UserDecoder.shared)
}
