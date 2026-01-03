//
//  EnumsForView.swift
//  GitShowCaseView
//
//  Created by user on 30.12.2025.
//

import Foundation
import SwiftUI



enum EmojiLocation: String{
    case ukraine, america, germany, italy
    
    var id: String{
        self.rawValue.capitalized
    }
    
    var emoji: String{
        switch self {
        case .ukraine:
            return "🇺🇦"
        case .america:
            return "🇺🇸"
        case .germany:
            return "🇩🇪"
        case .italy:
            return "🇮🇹"
        }
    }
}

enum LanguageColor: String{
    case swift, python, html
    
    var color: Color{
        switch self {
        case .swift:
            return Color(.orange)
        case .python:
            return Color(.green)
        case .html:
            return Color(.blue)
        }
    }
}


enum NavigationTab: String, CaseIterable, Identifiable{
    case main, search
    
    var id: String{ self.rawValue}
    
    var icon: String{
        switch self {
        case .main:
            return "person"
        case .search:
            return "magnifyingglass"
        }
    }
}

enum Route: Hashable{
    case profile(user: String)
}


enum ScreenState: String{
    case preload, loading, loaded, error, inCorrectUsername
}
enum GHError: Error {
    case invalidURL, invalidResponse, invalidData
}
