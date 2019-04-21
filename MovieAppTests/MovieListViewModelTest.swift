//
//  MovieAppTests.swift
//  MovieAppTests
//
//  Created by Ali Murad on 21/04/2019.
//  Copyright © 2019 Ali Murad. All rights reserved.
//

import XCTest
@testable import MovieApp

class MovieListViewModelTest: XCTestCase {

    var movieListViewModel : MovieListViewModel!
    var baseService : BaseService!
    override func setUp() {
       super.setUp()
        baseService = BaseService(networkManager: MockNetworkManagerMovieList())
        movieListViewModel = MovieListViewModel(service: baseService)

    }

    override func tearDown() {
       super.tearDown()
        movieListViewModel = nil
        baseService = nil
        
    }


    // MovieListViewModel Testing
    
    // first we will fetch movie from MockNetworkingManager, then check the movie records
    func testingFlow(){
        movieListViewModel.fetchMovies()
       let promise = self.expectation(description: "Promise to get data from mock data")
        if let movies = movieListViewModel.moviesInformation?.movies {
            XCTAssertEqual(movies.count, 3)
            XCTAssertEqual(movies.first?.title, "Hellboy")
            XCTAssertEqual(movies[2].title, "After")
            
        }else{
            XCTFail()
        }
       promise.fulfill()
        let indexPath = IndexPath(row: 1, section: 0)
        XCTAssertEqual(movieListViewModel.numberOfCells, 3)
        XCTAssertEqual(movieListViewModel.getMovieCellData(at: indexPath)?.title, "Shazam!")
       waitForExpectations(timeout: 2)
    }
}



