//
//  WebScreen.swift
//  GitShowCaseView
//
//  Created by user on 31.12.2025.
//

import Foundation
import SwiftUI
import WebKit

struct WebScreen: View {
    @StateObject private var page = WebPageConfigurator()
    let url: URL
    var body: some View {
        ZStack(){
            WebView(page: page, url: url)
                .ignoresSafeArea(edges: .bottom)
            VStack{
                Spacer()
                HStack(spacing: 0) {
                    
                    Button {
                        page.goBack()
                    } label: {
                        Image(systemName: "arrow.backward")
                            .padding()
                    }
                    .disabled(!page.canGoBack)
                    
                    Button {
                        page.goForward()
                    } label: {
                        Image(systemName: "arrow.forward")
                            .padding()
                    }
                    .disabled(!page.canGoForward)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }.padding()
            
            if page.isLoading {
                ProgressView()
            }
        }
    }
}

struct WebView: UIViewRepresentable {
    let page: WebPageConfigurator
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = page.getWebView()
        print(url)
        if !page.didLoadInitialRequest {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                page.didLoadInitialRequest = true
                webView.load(URLRequest(url: url))
            }
        }

        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

#Preview {
    WebScreen(url: URL(string: "google.com")!)
}
