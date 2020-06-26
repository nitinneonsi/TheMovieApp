//
//  TheMovieAppTests.swift
//  TheMovieAppTests
//
//  Created by Nitz on 24/06/20.
//  Copyright © 2020 TM. All rights reserved.
//

import XCTest
@testable import TheMovieApp

class TheMovieAppTests: XCTestCase {

    var viewControllerUnderTest: ViewController!
    var MoviesUnderTest: Movies!
    
    override func setUp() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        viewControllerUnderTest = storyboard.instantiateViewController(withIdentifier: "viewController") as? ViewController
        _ = viewControllerUnderTest.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testInitTableView(){
        
        XCTAssertNotNil(viewControllerUnderTest.tableViewMovies)
    }
    
    func testTableViewHasDelegate() {
        
        XCTAssertNotNil(viewControllerUnderTest.tableViewMovies.delegate)
    }
    
    func testTableViewHasDatasource() {

        XCTAssertNotNil(viewControllerUnderTest.tableViewMovies.dataSource)
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {

        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView(_:cellForRowAt:))))
    }
    
    func testDataInResult() {
        XCTAssertNotNil(viewControllerUnderTest.results)
    }
    
    func testMovies() {
        XCTAssertNil(MoviesUnderTest)
    }
}
