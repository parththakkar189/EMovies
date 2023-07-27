//
//  MovieListResponse.swift
//  MovieList
//
//  Created by Parth Thakkar on 2021-01-15.
//

import Foundation


struct MovieResponse: Codable {
    let movies: Array<MovieModel>?
}
