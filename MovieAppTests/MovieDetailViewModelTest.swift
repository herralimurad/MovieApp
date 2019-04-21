//
//  MovieDetailViewModelTest.swift
//  MovieAppTests
//
//  Created by Ali Murad on 21/04/2019.
//  Copyright © 2019 Ali Murad. All rights reserved.
//


import XCTest
@testable import MovieApp

class MovieDetailViewModelTest: XCTestCase {
    
    var viewModel : MovieDetailViewModel!
    var baseService : BaseService!
    override func setUp() {
        super.setUp()
        baseService = BaseService(networkManager: MockNetworkManagerMovieDetails())
        viewModel = MovieDetailViewModel(baseService: baseService)
        
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
        baseService = nil
        
    }
    
    
    // MovieDetailViewModel Testing
    
    // first we will fetch movie from MockNetworkingManager, then check the movie records
    func testingFlow(){
        viewModel.movieId = 299537 // setting id for fetching its detail
        viewModel.fetchMovieDetails()
        let promise = self.expectation(description: "Promise to get data from mock data")
        if let moviesDetail = viewModel.movieDetails {
            XCTAssertEqual(moviesDetail.title, "Captain Marvel")
            XCTAssertEqual(moviesDetail.releaseDate, "2019-03-06")
            
        }else{
            XCTFail()
        }
        promise.fulfill()
        
        waitForExpectations(timeout: 2)
    }
    
    // Given different format, either it return correct data or not
    func testDataFormatConverter()
    {
        let convertedDate = viewModel.convertDate(fromFormat: DateFormate.FormatFromServer, toFormat: DateFormate.FormatToShow, dateString: "2019-03-23")
        
        XCTAssertEqual(convertedDate,"23.03.2019")
    }
    // take list of genres and return comma separated string
    func testFormatGenres() {
        var g1 = Genre()
        g1.id = 1
        g1.name = "horror"
        var g2 = Genre()
        g2.id = 3
        g2.name = "Romantic"
        var g3 = Genre()
        g3.id = 3
        g3.name = "Drama"
      
        let formatedGenres = viewModel.getFormatedGenres(genres: [g1,g2,g3])
        XCTAssertEqual(formatedGenres,"horror, Romantic, Drama")

        
    }
    
}



