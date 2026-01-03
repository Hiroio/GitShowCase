//
//  WebViewModel.swift
//  GitShowCaseView
//
//  Created by user on 31.12.2025.
//

import Foundation
import Combine



final class WebViewModel: ObservableObject {

    @Published var isLoading = false
    @Published var error: Error?

    @Published var canGoBack = false
    @Published var canGoForward = false

    var goBackAction: (() -> Void)?
    var goForwardAction: (() -> Void)?

    func goBack() {
        goBackAction?()
    }

    func goForward() {
        goForwardAction?()
    }
}
