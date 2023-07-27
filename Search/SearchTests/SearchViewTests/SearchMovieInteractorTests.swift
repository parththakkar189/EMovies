//
//  SearchMovieInteractorTests.swift
//  SearchTests
//
//  Created by Parth Thakkar on 2021-07-01.
//

import XCTest
import Alamofire
@testable import Search
class SearchMovieInteractorTests: XCTestCase {

    var mockInteractor: SearchMovieListInteractor!
    var movies: [MovieModel]?
    
    
    class MockPresenter: SearchMovieListInteractorToPresenterProtocol {
        var movieFeatched = false
        func SearchMoviesFetched() {
            movieFeatched = true
        }
        
        func SearchMoviesFetchedFailed() {
            movieFeatched = false
        }
    
    }
    
    override func setUp() {
        mockInteractor = SearchMovieListInteractor()
        mockInteractor.presenter = MockPresenter()
        super.setUp()
    }

    func testGetMoviesAPICallSuccess() {
        let expectation = expectation(description: "Get Searched Movie List")
        let searchText = "BatMan"
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer Wookie2019",
            "Accept": "application/json"
        ]
        let params: [String: Any] = ["q" : searchText]
        let searchURL = URL(string: "https://wookie.codesubmit.io/movies?")
        AF.request(searchURL!, method: .get, parameters: params, headers: headers).response { response in
            if(response.response?.statusCode == 200){
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let movieResponse = try decoder.decode(MovieResponse.self, from: data)
                    guard let movies = movieResponse.movies else { return }
                    self.movies = movies
                    XCTAssertNotNil(self.movies)
                    XCTAssertEqual(self.movies?.count, 2)
                    self.mockInteractor.presenter!.SearchMoviesFetched()
                } catch let error {
                    XCTAssertNil(error)
                    XCTAssertEqual(self.movies, nil)
                    self.mockInteractor.presenter!.SearchMoviesFetchedFailed()
                }
                expectation.fulfill()
            }
            else {
                self.mockInteractor.presenter!.SearchMoviesFetchedFailed()
            }
        }
        wait(for: [expectation], timeout: 5.0)

    }

    func testGetMovieSearchedAPI() {
        let expectation = expectation(description: "Get searched name movie")
        self.mockInteractor.fetchSearchedMovies(searchText: "BatMan")
        expectation.fulfill()
        wait(for: [expectation], timeout: 10.0)
    }
}
