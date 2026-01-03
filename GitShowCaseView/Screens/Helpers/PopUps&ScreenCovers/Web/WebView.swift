//
//  WebView.swift
//  GitShowCaseView
//
//  Created by user on 31.12.2025.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

    let url: URL
    @ObservedObject var viewModel: WebViewModel

    func makeCoordinator() -> WebCoordinator {
        WebCoordinator(viewModel: viewModel)
    }

    func makeUIView(context: Context) -> WKWebView {

        let config = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: config)

        webView.navigationDelegate = context.coordinator

        viewModel.goBackAction = {
            if webView.canGoBack {
                webView.goBack()
            }
        }

        viewModel.goForwardAction = {
            if webView.canGoForward {
                webView.goForward()
            }
        }

        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
