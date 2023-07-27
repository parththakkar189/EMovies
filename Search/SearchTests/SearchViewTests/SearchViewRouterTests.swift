//
//  SearchViewRouterTests.swift
//  SearchTests
//
//  Created by Parth Thakkar on 2021-06-29.
//

import XCTest
@testable import Search
class SearchViewRouterTests: XCTestCase {

    var mockRouter: SearchViewRouter!
    
    override func setUp() {
        super.setUp()
        mockRouter = SearchViewRouter()
    }
    
    override func tearDown() {
        mockRouter = nil
        super.tearDown()
    }
    
    func testCreateModule()    {
        XCTAssertTrue(SearchViewRouter.createModule() is SearchViewController)
    }
    

}
