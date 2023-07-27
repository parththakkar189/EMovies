//
//  FavouritePresenter.swift
//  MovieList
//
//  Created by Parth Thakkar on 2021-01-18.
//

import Foundation
import UIKit

class FavouriteMoviePresenter: FavouriteMovieListViewToPresenterProtocol {
    var view: FavouriteMovieListPresenterToViewProtocol?
    
    var interactor: FavouriteMovieListPresentorToInteractorProtocol?
    
    var router: FavouriteMovieListPresenterToRouterProtocol?
    
    func updateView() {
        interactor?.fetchFavouriteMovies()
    }
    
    func getMoviesListCount() -> Int? {
        return interactor?.movies?.count
    }
    
    func getMovie(index: Int) -> MovieModel? {
        return interactor?.movies![index]
    }
    
    func goToPreviousViewController() {
        router?.popToViewController(from: view!)
    }
}

extension FavouriteMoviePresenter: FavouriteMovieListInteractorToPresenterProtocol{
    func FavouriteMoviesFetched() {
        view?.showFavouriteMovies()
    }
    
    func FavouriteMoviesFetchedFailed() {
        view?.showFavouriteMovieError()
    }
    
    
}
