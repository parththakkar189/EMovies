//
//  SearchTests.swift
//  SearchTests
//
//  Created by Parth Thakkar on 2021-06-20.
//

import XCTest

@testable import Search

class SearchTests: XCTestCase, UISearchBarDelegate {
    
    var mockSearchViewController: SearchViewController!
    var mockPresenter: SearchMoviePresenter!
    private var expectation: XCTestExpectation!
    var movie: [MovieModel] = [MovieModel(backdrop: "testBackDrop1", cast: ["Test1Cast","Test1Cast"], classification: .the13, director: .string("TestDirector1"), genres: ["testGen1"], id: "testID1", imdbRating: 9.0, length: "2h", overview: "Nice", poster: "TestPoster1", releasedOn: "22/08/2020", slug: "testSlug1", title: "TestTitle1"),
                               MovieModel(backdrop: "testBackDrop2", cast: ["Test2Cast","Test2Cast"], classification: .the13, director: .string("TestDirector2"), genres: ["testGen2"], id: "testID2", imdbRating: 9.0, length: "2h", overview: "Nice", poster: "TestPoster2", releasedOn: "22/08/2020", slug: "testSlug2", title: "TestTitle1"),
                               MovieModel(backdrop: "testBackDrop3", cast: ["Test3Cast","Test4Cast"], classification: .the13, director: .string("TestDirector3"), genres: ["testGen3"], id: "testID3", imdbRating: 9.0, length: "2h", overview: "Nice", poster: "TestPoster3", releasedOn: "22/08/2020", slug: "testSlug3", title: "TestTitle3")]
    
    override func setUp() {
        mockSearchViewController = Constants.loadStoryboard().instantiateViewController(identifier: Constants.shared.searchViewController) as? SearchViewController
        mockPresenter = SearchMoviePresenter()
        mockPresenter.router = SearchViewRouter()
        mockPresenter.interactor = SearchMovieListInteractor()
        mockPresenter.view = mockSearchViewController
        mockPresenter.interactor?.presenter = mockPresenter
        mockSearchViewController?.loadViewIfNeeded()
        XCTAssertNotNil(mockSearchViewController.searchMovieCollectionView)
        super.setUp()
    }
    
    override func tearDown() {
        mockSearchViewController = nil
        mockPresenter = nil
        super.tearDown()
    }
    
    func testSearchBarOutletisConnected() throws {
        let searchBar = try XCTUnwrap(mockSearchViewController!.searchBar)
        XCTAssert(searchBar.searchTextField.text != nil, "Search Bar only accepts string")
    }
    
    func testSearchBarHasDelegate() {
        XCTAssertNotNil(mockSearchViewController!.searchBar.delegate)
    }
    
    func testSearchBarTextNotNill() {
        let searchtext = "Batman"
        let result = mockSearchViewController?.validateSearchText(string: searchtext)
        mockPresenter.SearchMoviesFetched()
        XCTAssert(result!)
    }
    
    func testSearchBarTextNil() {
        let searchtext = ""
        let result = mockSearchViewController?.validateSearchText(string: searchtext)
        mockPresenter.SearchMoviesFetched()
        XCTAssertNotNil(result!)
    }
    
    func testSearchBarDelegate() {
        mockSearchViewController!.searchBar.text = "BatMan"
        mockPresenter.updateView(searchText: mockSearchViewController.searchBar.text!)
        mockSearchViewController!.searchBarSearchButtonClicked(mockSearchViewController!.searchBar)
        
    }
    
    
    func testBackButtonOutletisConnected() throws {
        let backButton = try XCTUnwrap(mockSearchViewController.btnBack)
        XCTAssertNotNil(backButton)
        mockPresenter.router?.popToViewController(from: mockPresenter.view!)
        mockSearchViewController.actionBtnBackClicked(sender: backButton)
        
    }
    
    func testMovieCollectionView() throws {
        let collectionView = try XCTUnwrap(mockSearchViewController.searchMovieCollectionView)
        XCTAssertNotNil(collectionView)
        collectionView.delegate = mockSearchViewController
        collectionView.dataSource = mockSearchViewController
        mockSearchViewController.loadViewIfNeeded()
        collectionView.reloadData()
        collectionView.dataSource?.collectionView(mockSearchViewController.searchMovieCollectionView, numberOfItemsInSection: self.movie.count)
        collectionView.dataSource?.collectionView(mockSearchViewController.searchMovieCollectionView, cellForItemAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(mockSearchViewController.searchMovieCollectionView.delegate === mockSearchViewController)
        XCTAssertNotNil(mockSearchViewController.searchMovieCollectionView.dataSource === mockSearchViewController)
    }
    /*
     Step 1: validate search text blank and fill both
     Step 2: Validate API Request and Response for success and failure
     Step 3: Validate API SuccessResponse with response count 0 and > 0
     */
    
}
