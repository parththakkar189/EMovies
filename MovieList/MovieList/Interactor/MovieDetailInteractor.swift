//
//  MovieDetailInteractor.swift
//  MovieList
//
//  Created by Parth Thakkar on 2021-01-17.
//

import Foundation

class MovieDetailInteractor: MovieDetailPresentorToInteractorProtocol {
    
    //MARK: MovieDetailInteractor
    var movie: MovieModel?
    var presenter: MovieDetailInteractorToPresenterProtocol?
    
    func fetchMovieDetail() {
        presenter?.getMovieDetailSuccess(movie!)
    }
    
    func addMovieToFavourites(movie: MovieModel) {
        if !appDelegate.arrFavourite.contains(movie) {
            appDelegate.arrFavourite.append(movie)
            presenter?.addMovieToFavouriteSuccess()
        }
        else{
            presenter?.addMovieeToFavouritesFailuer()
        }
    }
}
