//
//  MovieDetailViewProtocols.swift
//  MovieList
//
//  Created by Parth Thakkar on 2021-01-17.
//

import Foundation
import UIKit

protocol MovieDetailPresenterToViewProtocol: class {
    func showMovieDetail(movie: MovieModel)
    func showError()
    
    func addMovieToFavourite()
    func addMovieeToFavouritesFailuer()
}

protocol MovieDetailInteractorToPresenterProtocol: class {
    func getMovieDetailSuccess(_ movie: MovieModel)
    func getMovieDetailFailure()
    
    func addMovieToFavouriteSuccess()
    func addMovieeToFavouritesFailuer()
}

protocol MovieDetailPresentorToInteractorProtocol: class {
    var presenter: MovieDetailInteractorToPresenterProtocol? { get set }
    var movie: MovieModel? { get set}
    
    func fetchMovieDetail()
    func addMovieToFavourites(movie: MovieModel)
}

protocol MovieDetailPresenterToRouterProtocol: class {
    static func createModule(movie: MovieModel) -> UIViewController
    func pushToSearchDetail(on view: MovieDetailPresenterToViewProtocol, identifier: String)
    func popToViewController(from view: MovieDetailPresenterToViewProtocol)
}

protocol MovieDetailViewToPresenterProtocol: class {
    var view: MovieDetailPresenterToViewProtocol? { get set }
    var interactor: MovieDetailPresentorToInteractorProtocol? { get set }
    var router: MovieDetailPresenterToRouterProtocol? { get set }
    
    func viewDidLoad()
    func addToFavourites(movie: MovieModel)
    func goToSearch()
    func goToHome()
    func goToFavourites()
}
