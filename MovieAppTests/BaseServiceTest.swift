//
//  BaseServiceTest.swift
//  MovieAppTests
//
//  Created by Ali Murad on 21/04/2019.
//  Copyright © 2019 Ali Murad. All rights reserved.
//

import XCTest
@testable import MovieApp


class BaseServiceTest : XCTestCase {
    
    var baseService : BaseService!
    
    
    override func setUp() {
       
        super.setUp()
        // setup base service with mockdata in json and json parser
        baseService = BaseService (networkManager: MockNetworkManagerMovieDetails(), dataParser: JSONParser())
        
        }
    
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        baseService = nil
    }
    
    
  
    // Testing base service, it will take request data and return response model
    func testBaseService() {
        let promise = self.expectation(description: "Will parse correct data from json of movie detail screen")
        let movieDetailsRequestData = RequestData.movieDetail(id: 299537)
        
        baseService.request(requestData: movieDetailsRequestData, responseModel: MovieDetails.self) { (dataObject, error) in
            if let _ = error {
                XCTFail("Error in Response")
                return
            }
            if let movieDetails = dataObject as? MovieDetails {
                XCTAssert(true, "Response")
                XCTAssertEqual(movieDetails.title , "Captain Marvel", "it should be Captain Marvel")
                 XCTAssertEqual(movieDetails.releaseDate , "2019-03-06", "correct release date of captain marvel")
                XCTAssertNotEqual(movieDetails.backdropPath, "myImage.png", "it is false information")
               
            }
            
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
  
    
}

