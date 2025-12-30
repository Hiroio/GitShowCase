//
//  MainView.swift
//  GitShowCaseView
//
//  Created by user on 30.12.2025.
//

import SwiftUI

struct MainView: View {
    @State private var manager = APIManager()
    
    var body: some View {
        VStack{
//            MARK: USER HEADER
            if let user = manager.mainUser{
                VStack(spacing: 0){
                    UserInfoHeader(user: user)
                    
                    if let mainRepo = manager.mainRepos{
                        MainUserRepos(repos: mainRepo)
                    }else{
                        Text("No Repository")
                        Image(systemName: "rectangle.fill.on.rectangle.fill.slash.fill")
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(lineWidth: 2)
                )
                .padding(5)
            }
            Spacer()
        }
    }
}

#Preview {
    MainView()
}
