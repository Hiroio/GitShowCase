//
//  ContentView.swift
//  GitShowCaseView
//
//  Created by user on 30.12.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var navigationState: NavigationTab = .main
    @State private var url: URLSheet?
    @State private var router = NavigationRouter()
    var body: some View {
        NavigationStack(path: $router.path) {
            
            VStack(spacing: 0){
                switch navigationState {
                case .main:
                    MainView(url: $url)
                case .search:
                    SearchView(url: $url)
                }
                
                
                NavigationBar(navigationState: $navigationState)
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .profile(let username):
                    ProfileView(username: username, url: $url)
                }
            }
        }
        .sheet(item: $url){url in
            WebScreen(url: url.url)
        }
        .environment(router)
    }
}

#Preview {
    ContentView()
        .environment(MainUserViewModel())
}
