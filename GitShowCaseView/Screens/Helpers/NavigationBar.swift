//
//  NavigationBar.swift
//  GitShowCaseView
//
//  Created by user on 31.12.2025.
//

import SwiftUI

struct NavigationBar: View {
    @Binding var navigationState: NavigationTab
    var body: some View {
        HStack(spacing: 1){
            ForEach(NavigationTab.allCases){tab in
                Button{
                    navigationState = tab
                }label:{
                    Image(systemName: tab.icon)
                        .foregroundStyle(navigationState == tab ? .white : .black)
                        .padding()
                        .padding(.horizontal)
                        .contentShape(.rect)
                        .background(navigationState == tab ?
                                    Color.gray.opacity(0.5) : Color.clear
                        )
                        .shadow(radius: navigationState == tab ? 0 : 10)
                }
                
            }
        }
        .animation(.easeInOut, value: navigationState)
        
        .clipShape(.rect(cornerRadius: 20))
        .shadow(radius: 3)
        
    }
}

#Preview {
    @Previewable @State var test = NavigationTab.main
    NavigationBar(navigationState: $test)
}
