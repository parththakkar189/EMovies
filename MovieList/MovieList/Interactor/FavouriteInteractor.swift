//
//  FavouriteInteractor.swift
//  MovieList
//
//  Created by Parth Thakkar on 2021-01-18.
//

import Foundation


class FavouriteMovieListInteractor: FavouriteMovieListPresentorToInteractorProtocol {
    var presenter: FavouriteMovieListInteractorToPresenterProtocol?
    
    var movies: [MovieModel]?
    
    func fetchFavouriteMovies() {
        if appDelegate.arrFavourite.count > 0{
            movies = appDelegate.arrFavourite
            presenter?.FavouriteMoviesFetched()
        }
    }
    
    
}
