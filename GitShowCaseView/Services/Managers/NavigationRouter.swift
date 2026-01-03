//
//  NavigationRouter.swift
//  GitShowCaseView
//
//  Created by user on 02.01.2026.
//

import Foundation


@MainActor
@Observable
final class NavigationRouter {

    var path: [Route] = []

    func pushProfile(_ login: String) {
        path.append(.profile(user: login))
    }

    func pop() {
        _ = path.popLast()
    }

    func popToRoot() {
        path.removeAll()
    }
}
