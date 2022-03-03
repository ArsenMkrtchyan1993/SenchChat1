//
//  Bundle - extension.swift
//  SenchChat
//
//  Created by Arsen Mkrtchyan on 02.03.22.
//

import UIKit


extension Bundle {
    
    func decode<T: Decodable>(_ type: T.Type, from file:String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("url error")}
        guard let data = try? Data(contentsOf: url) else {
            fatalError("data error \(file) not found ")
        }
        let decoder = JSONDecoder()
            guard let loaded = try? decoder.decode(T.self, from:data) else {
                fatalError("Filed to decode \(file) not found")
            }
        return loaded
    }
   
}
