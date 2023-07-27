//
//  SearchMovieEntityTests.swift
//  SearchTests
//
//  Created by Parth Thakkar on 2021-06-30.
//

import XCTest
@testable import Search
class SearchMovieEntityTests: XCTestCase {

    func testMovieEntity() {
        let movie = MovieModel(backdrop: "testBackDrop", cast: ["Test1Cast","Test2Cast"], classification: .the13, director: .string("TestDirector"), genres: ["testGen1"], id: "testID", imdbRating: 9.0, length: "2h", overview: "Nice", poster: "TestPoster", releasedOn: "22/08/2020", slug: "testSlug", title: "TestTitle")
        XCTAssertEqual(movie.title, "TestTitle")
    }

}
