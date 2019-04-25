//
//  RequestData.swift
//  MovieApp
//
//  Created by Ali Murad on 20/04/2019.
//  Copyright © 2019 Ali Murad. All rights reserved.
//

import Foundation

// RequestData will provide requestMethod, URL and params for all different requests

enum RequestData {
   
    case movieList
    case movieDetail(id: Int)
    case movieTrailer(id: Int)
    
    var requestMethod: RequestMethod {
        switch self {
        case .movieList:
            return .GET
        case .movieDetail:
            return .GET
        case .movieTrailer:
             return .GET
       }
    }
    var requestURL   : String {
        switch self {
        case .movieList:
            return URLs.PopularMoviesURL
        case .movieDetail(let id):
            return URLs.MovieDetailsURL+"\(id)"
        case .movieTrailer(let id):
            return URLs.MovieTrailerURL.replacingOccurrences(of: PlaceHolders.MovieId, with: "\(id)")
        }
    }
    var requestParams   : Dictionary<AnyHashable, Any> {
        switch self {
        case .movieList:
            return [ParameterNames.APIKey: Constants.APIKey]
        case .movieDetail:
            return [ParameterNames.APIKey: Constants.APIKey]
        case .movieTrailer:
            return [ParameterNames.APIKey: Constants.APIKey]
        }
    }
   
  
}
