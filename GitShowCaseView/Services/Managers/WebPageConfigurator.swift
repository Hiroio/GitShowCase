//
//  WebView.swift
//  GitShowCaseView
//
//  Created by user on 31.12.2025.
//

import SwiftUI
import WebKit
import Combine


class WebPageConfigurator: NSObject, WKNavigationDelegate, ObservableObject {
    @Published var isLoading = false
    @Published var estimatedProgress: Double = 0
    @Published var title: String?
    @Published var canGoBack = false
    @Published var canGoForward = false
    @Published var url = ""
    var didLoadInitialRequest = false

    

    private var webView: WKWebView!

    override init() {
        super.init()
        webView = WKWebView()
        webView.navigationDelegate = self
        observeWebView()
    }

    deinit {
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.isLoading))
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.title))
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.canGoBack))
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.canGoForward))
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.url))
    }

    
    func load(_ request: URLRequest) {
        webView.load(request)
    }

    func goBack() {
        webView.goBack()
    }

    func goForward() {
        webView.goForward()
    }

    func getWebView() -> WKWebView {
        webView
    }


    private func observeWebView() {
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.title), options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoBack), options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.canGoForward), options: .new, context: nil)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.url), options: .new, context: nil)
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        DispatchQueue.main.async {
            switch keyPath {
            case #keyPath(WKWebView.isLoading):
                self.isLoading = self.webView.isLoading
            case #keyPath(WKWebView.estimatedProgress):
                self.estimatedProgress = self.webView.estimatedProgress
            case #keyPath(WKWebView.title):
                self.title = self.webView.title
            case #keyPath(WKWebView.canGoBack):
                self.canGoBack = self.webView.canGoBack
            case #keyPath(WKWebView.canGoForward):
                self.canGoForward = self.webView.canGoForward
            case #keyPath(WKWebView.url):
                self.url = self.webView.url?.relativeString ?? ""
            default:
                break
            }
        }
    }
}
