//
//  MoviesDetailModel.swift
//  MovieApp
//
//  Created by Ali Murad on 17/04/2019.
//  Copyright © 2019 Ali Murad. All rights reserved.
//

import Foundation

struct Genre : Codable {
    var id: Int?
    var name: String?
}

struct MovieDetails: Codable {
    var backdropPath: String?
    var title: String?
    var releaseDate : String?
    var genres: [Genre]?
    var overview: String?
    
    enum CodingKeys: String, CodingKey
    {   case backdropPath = "backdrop_path"
        case title
        case releaseDate = "release_date"
        case genres
        case overview
    }
}

struct TrailersInformation : Codable {
    var id: Int?
    var trailers: [Trailer]?
  
    enum CodingKeys: String, CodingKey
    {   case id
        case trailers = "results"
       
    }
    
}

struct Trailer: Codable {
    var id: String?
    var key: String?
    var name: String?
    var site: String?
    var size: Int?
    var type: String?
}
