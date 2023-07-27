//
//  SearchMovieEntity.swift
//  Search
//
//  Created by Parth Thakkar on 2021-06-21.
//

import Foundation
// MARK: - Movie
struct MovieModel: Codable, Equatable {
    
    static func == (lhs: MovieModel, rhs: MovieModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    
    let backdrop: String
    let cast: [String]
    let classification: Classification
    let director: Director
    let genres: [String]
    let id: String
    let imdbRating: Double
    let length, overview: String
    let poster: String
    var releasedOn, slug, title: String

    enum CodingKeys: String, CodingKey {
        case backdrop, cast, classification, director, genres, id
        case imdbRating = "imdb_rating"
        case length, overview, poster
        case releasedOn = "released_on"
        case slug, title
    }
}

enum Classification: String, Codable {
    case the13 = "13+"
    case the18 = "18+"
    case the7 = "7+"
}

enum Director: Codable {
    
    case string(String)
    case stringArray([String])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Director.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Director"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .stringArray(let x):
            try container.encode(x)
        }
    }
}
struct MovieResponse: Codable {
    let movies: Array<MovieModel>?
}
