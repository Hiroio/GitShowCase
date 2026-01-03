//
//  WebCoordinator.swift
//  GitShowCaseView
//
//  Created by user on 31.12.2025.
//

import Foundation
import WebKit


final class WebCoordinator: NSObject, WKNavigationDelegate {

    let viewModel: WebViewModel
    weak var webView: WKWebView?

    init(viewModel: WebViewModel) {
        self.viewModel = viewModel
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation: WKNavigation!) {
        self.webView = webView
        viewModel.isLoading = true
        updateNavigationState(webView)
    }

    func webView(_ webView: WKWebView, didFinish: WKNavigation!) {
        viewModel.isLoading = false
        updateNavigationState(webView)
    }

    func webView(_ webView: WKWebView, didFail: WKNavigation!, withError error: Error) {
        viewModel.error = error
        updateNavigationState(webView)
    }

    private func updateNavigationState(_ webView: WKWebView) {
        viewModel.canGoBack = webView.canGoBack
        viewModel.canGoForward = webView.canGoForward
    }
}

