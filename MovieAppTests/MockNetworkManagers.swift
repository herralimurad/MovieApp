//
//  MockNetworkManager.swift
//  MovieAppTests
//
//  Created by Ali Murad on 21/04/2019.
//  Copyright © 2019 Ali Murad. All rights reserved.
//
import Foundation

@testable import MovieApp


// MOCK NetworkManageable that will return sample data from file
class MockNetworkManagerMovieList : NetworkManageable {
    
    func performRequest(url: String, params: Dictionary<AnyHashable, Any>, method: RequestMethod, requestPerformed: @escaping RequestPerformed) {
        requestPerformed(RequestResult.success(data: SampleData.movieList()))
        
    }
    
}

class MockNetworkManagerMovieDetails : NetworkManageable {
    
    func performRequest(url: String, params: Dictionary<AnyHashable, Any>, method: RequestMethod, requestPerformed: @escaping RequestPerformed) {
        requestPerformed(RequestResult.success(data: SampleData.movieDetails()))
        
    }
    
}


