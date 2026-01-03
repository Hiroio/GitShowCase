//
//  ContentView.swift
//  GitShowCaseView
//
//  Created by user on 30.12.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var navigationState: NavigationTab = .main
    @State private var url: URL?
    @State private var isURL: Bool = false
    @State private var router = NavigationRouter()
    var body: some View {
        NavigationStack(path: $router.path) {
            
            VStack(spacing: 0){
                switch navigationState {
                case .main:
                    MainView(url: $url, isURL: $isURL)
                case .search:
                    SearchView(isURL: $isURL, url: $url)
                }
                
                
                NavigationBar(navigationState: $navigationState)
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .profile(let username):
                    ProfileView(username: username, isURL: $isURL, url: $url)
                }
            }
        }
        .sheet(isPresented: $isURL){
            WebScreen(url: url ?? URL(string: "git.hub")!)
        }
        .environment(router)
    }
}

#Preview {
    ContentView()
        .environment(MainUserViewModel())
}
