//
//  MovieAppUITests.swift
//  MovieAppUITests
//
//  Created by Ali Murad on 21/04/2019.
//  Copyright © 2019 Ali Murad. All rights reserved.
//

import XCTest

class MovieAppUITests: XCTestCase {

    let app =  XCUIApplication()
    override func setUp() {
       
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {
        app.terminate()
    }

    func testingIsDetailScreenLoad() {
        sleep(1)
        let firstCell = app.cells.element(boundBy: 0)
        firstCell.tap()
        sleep(5)
        
        XCTAssert(app.staticTexts["Genres"].exists)
        XCTAssert(app.staticTexts["Date"].exists)
        XCTAssert(app.staticTexts["Overview"].exists)

        
        
        
    }

}
