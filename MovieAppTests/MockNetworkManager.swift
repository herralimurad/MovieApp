//
//  MockNetworkManager.swift
//  MovieAppTests
//
//  Created by Ali Murad on 21/04/2019.
//  Copyright © 2019 Ali Murad. All rights reserved.
//
import Foundation

@testable import MovieApp

class MockNetworkManager : NetworkManageable {
    
    func performRequest(url: String, params: Dictionary<AnyHashable, Any>, method: RequestMethod, requestPerformed: @escaping RequestPerformed) {
        requestPerformed(RequestResult.success(data: getSampleData()))
        
    }
    
}


