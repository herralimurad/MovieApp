//
//  MovieListModel.swift
//  MovieApp
//
//  Created by Ali Murad on 19/04/2019.
//  Copyright © 2019 Ali Murad. All rights reserved.
//

import Foundation

struct MovieInformation: Codable {
    let movies             : [Movie]?
    
    enum CodingKeys: String, CodingKey
    {
        case movies = "results"
    }
}


struct Movie : Codable {
    let id                     : Int?
    let title                  : String?
    let thumbnailImage         : String?
    
    enum CodingKeys: String, CodingKey
    {   case id
        case title
        case thumbnailImage = "poster_path"
    }

}
