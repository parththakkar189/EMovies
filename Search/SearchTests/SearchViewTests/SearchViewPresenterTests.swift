//
//  SearchViewPresenterTests.swift
//  SearchTests
//
//  Created by Parth Thakkar on 2021-06-29.
//

import XCTest
@testable import Search

class SearchViewPresenterTests: XCTestCase {
    
    class MockInteractor : SearchMovieListInteractor {
        var movie: [MovieModel] = [MovieModel(backdrop: "testBackDrop1", cast: ["Test1Cast","Test1Cast"], classification: .the13, director: .string("TestDirector1"), genres: ["testGen1"], id: "testID1", imdbRating: 9.0, length: "2h", overview: "Nice", poster: "TestPoster1", releasedOn: "22/08/2020", slug: "testSlug1", title: "TestTitle1"),
                                   MovieModel(backdrop: "testBackDrop2", cast: ["Test2Cast","Test2Cast"], classification: .the13, director: .string("TestDirector2"), genres: ["testGen2"], id: "testID2", imdbRating: 9.0, length: "2h", overview: "Nice", poster: "TestPoster2", releasedOn: "22/08/2020", slug: "testSlug2", title: "TestTitle1"),
                                   MovieModel(backdrop: "testBackDrop3", cast: ["Test3Cast","Test4Cast"], classification: .the13, director: .string("TestDirector3"), genres: ["testGen3"], id: "testID3", imdbRating: 9.0, length: "2h", overview: "Nice", poster: "TestPoster3", releasedOn: "22/08/2020", slug: "testSlug3", title: "TestTitle3")]
    }
    
    class MockRouter: SearchViewRouter {
        override func popToViewController(from view: SearchMovieListPresenterToViewProtocol) {
            let view = Constants.loadStoryboard().instantiateViewController(identifier: Constants.shared.searchViewController) as! SearchViewController
            view.navigationController?.popViewController(animated: true)
        }
    }
    
    class MockView: SearchMovieListPresenterToViewProtocol {
        var showMovies = false
        var showProgressview = false
        func showSearchedMovies() {
            showMovies = true
        }
        
        func showSearchedError() {
            showMovies = true
        }
        
        func showProgressView() {
            showProgressview = true
        }
        
        func hideProgressView() {
            showProgressview = false
        }
        
        
    }
    
    var mockPresenter: SearchMoviePresenter!
    
    override func setUp() {
        mockPresenter = SearchMoviePresenter()
        mockPresenter.interactor = MockInteractor()
        mockPresenter.router = MockRouter()
        mockPresenter.view = MockView()
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testUpdateview() {
        mockPresenter.updateView(searchText: "BatMan")
        mockPresenter.view?.showSearchedMovies()
    }
    
    func testUpdateViewWithError() {
        mockPresenter.updateView(searchText: "")
        mockPresenter.SearchMoviesFetchedFailed()
    }
    
    func testGetMoviesCount() {
    }
    
    func testGotoPreviousViewController() {
        mockPresenter.router?.popToViewController(from: mockPresenter.view!)
    }
}
