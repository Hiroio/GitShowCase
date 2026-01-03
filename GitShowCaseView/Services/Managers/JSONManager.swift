//
//  JSONManager.swift
//  GitShowCaseView
//
//  Created by user on 31.12.2025.
//

import Foundation



class JSONManager {
    static func getJSONData<T: Decodable>(_ data: Data) -> T {
        let decoder = JSONDecoder()
        
        return try! decoder.decode(T.self, from: data)
    }
    
    
    static func setJSONData<T: Encodable>(_ data: T) -> Data {
        let encoder = JSONEncoder()
        
        return try! encoder.encode(data)
    }
}
