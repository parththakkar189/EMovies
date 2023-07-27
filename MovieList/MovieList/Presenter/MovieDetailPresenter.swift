//
//  MovieDetailPresenter.swift
//  MovieList
//
//  Created by Parth Thakkar on 2021-01-17.
//

import Foundation
import UIKit

class MovieDetailPresenter: MovieDetailViewToPresenterProtocol {
    
    // MARK: Properties
    weak var view: MovieDetailPresenterToViewProtocol?
    var interactor: MovieDetailPresentorToInteractorProtocol?
    var router: MovieDetailPresenterToRouterProtocol?
    
    func viewDidLoad() {
        interactor?.fetchMovieDetail()
    }

    func goToSearch() {
        router?.pushToSearchDetail(on: view!, identifier: searchViewController)
    }
    
    func goToHome() {
        router?.popToViewController(from: view!)
    }
    
    func addToFavourites(movie: MovieModel) {
        interactor?.addMovieToFavourites(movie: movie)
    }
    
    func goToFavourites() {
        router?.pushToSearchDetail(on: view!, identifier: favouriteViewController)
    }
}

extension MovieDetailPresenter: MovieDetailInteractorToPresenterProtocol{
    func addMovieToFavouriteSuccess() {
        view?.addMovieToFavourite()
    }
    
    func addMovieeToFavouritesFailuer() {
        view?.showError()
    }
    
    func getMovieDetailSuccess(_ movie: MovieModel) {
        view?.showMovieDetail(movie: movie)
    }
    
    func getMovieDetailFailure() {
        view?.showError()
    }
    
    
}
