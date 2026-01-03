//
//  GitShowCaseViewApp.swift
//  GitShowCaseView
//
//  Created by user on 30.12.2025.
//

import SwiftUI

@main
struct GitShowCaseViewApp: App {
    @State private var userVM = MainUserViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(userVM)
        }
    }
}
