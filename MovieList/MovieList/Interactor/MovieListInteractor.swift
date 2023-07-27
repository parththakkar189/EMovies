//
//  MovieListInteractor.swift
//  MovieList
//
//  Created by Parth Thakkar on 2021-01-15.
//

import Foundation
import Alamofire

class MovieListInteractor: MovieListPresentorToInteractorProtocol{
    
    //MARK: Properties
    var presenter: MovieListInteractorToPresenterProtocol?
    var movies: [MovieModel]?
    
    
    
    
    //MARK: Methods
    func fetchMovies() {
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer Wookie2019",
            "Accept": "application/json"
        ]
        
        AF.request(MOVIE_API, method: .get, parameters: nil, headers: headers).response { response in
            if(response.response?.statusCode == 200){
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let movieResponse = try decoder.decode(MovieResponse.self, from: data)
                    guard let movies = movieResponse.movies else { return }
                    self.movies = movies
                    self.fetchGenre(arrMovies: movies)
                    self.presenter?.MoviesFetched()
                } catch let error {
                    print(error.localizedDescription)
                }
            }
            else {
                self.presenter?.MoviesFetchedFailed()
            }
        }
    }
    
    func featchMovieForDetail(at index: Int, from section: String) {
        if let movie = movies?.filter({ (movie) -> Bool in
            movie.genres.contains(section)
        })[index]{
            presenter?.getMovieSuccess(movie)
        }
        
        
    }
    
    //MARK: Generate Catagories Locally
    func fetchGenre(arrMovies: [MovieModel]) {
        for movie in arrMovies{
            self.extractGenres(arrGenre: movie.genres)
        }
    }
    
    func extractGenres(arrGenre: Array<String>){
        for genre in arrGenre{
            if !appDelegate.arrGenre.contains(genre){
                appDelegate.arrGenre.append(genre)
            }
        }
    }
}
