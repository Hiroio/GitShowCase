//
//  WebScreen.swift
//  GitShowCaseView
//
//  Created by user on 31.12.2025.
//

import Foundation
import SwiftUI


struct WebScreen: View {
    
    @StateObject private var vm = WebViewModel()
    
    let url: URL
    var body: some View {
        NavigationStack{
            ZStack(){
                    WebView(
                        url: url,
                        viewModel: vm
                    ).ignoresSafeArea(edges: .bottom)
                VStack{
                    Spacer()
                    HStack(spacing: 0) {

                        Button {
                            vm.goBack()
                        } label: {
                            Image(systemName: "arrow.backward")
                                .padding()
                        }
                        .disabled(!vm.canGoBack)

                        Button {
                            vm.goForward()
                        } label: {
                            Image(systemName: "arrow.forward")
                                .padding()
                        }
                        .disabled(!vm.canGoForward)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }.padding()
                
                if vm.isLoading {
                    ProgressView()
                }
            }
            

        }
    }
}


#Preview {
    WebScreen(url: URL(string: "google.com")!)
}
