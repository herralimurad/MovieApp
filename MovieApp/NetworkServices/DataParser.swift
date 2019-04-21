//
//  DataParser.swift
//  MovieApp
//
//  Created by Ali Murad on 20/04/2019.
//  Copyright © 2019 Ali Murad. All rights reserved.
//

import Foundation


// protocol for dependency injection for DataParser

protocol DataParser {
    func parse<T>(type: T.Type, from data: Any) throws -> T where T: Decodable
}

// i have use json parser as i am getting response in json,
// but any type of parser (e.g xml parser) can be inject here based on your requirement
struct JSONParser: DataParser {
    func parse<T>(type: T.Type, from data: Any) throws -> T where T: Decodable {
        do {
            let data = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            let response = try JSONDecoder().decode(type, from: data)
            return response
        } catch let error {
            throw error as NSError
        }
    }
}

