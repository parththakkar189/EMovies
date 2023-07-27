//
//  FavouriteProtocols.swift
//  MovieList
//
//  Created by Parth Thakkar on 2021-01-18.
//

import Foundation
import UIKit

protocol FavouriteMovieListPresenterToViewProtocol: class {
    func showFavouriteMovies()
    func showFavouriteMovieError()
}

protocol FavouriteMovieListInteractorToPresenterProtocol: class {
    func FavouriteMoviesFetched()
    func FavouriteMoviesFetchedFailed()
}

protocol FavouriteMovieListPresentorToInteractorProtocol: class {
    var presenter: FavouriteMovieListInteractorToPresenterProtocol? { get set }
    var movies: [MovieModel]? { get }
    
    func fetchFavouriteMovies()
}

protocol FavouriteMovieListPresenterToRouterProtocol: class {
    static func createModule() -> UIViewController
    func popToViewController(from view: FavouriteMovieListPresenterToViewProtocol)
}

protocol FavouriteMovieListViewToPresenterProtocol: class {
    var view: FavouriteMovieListPresenterToViewProtocol? { get set }
    var interactor: FavouriteMovieListPresentorToInteractorProtocol? { get set }
    var router: FavouriteMovieListPresenterToRouterProtocol? { get set }
    
    func updateView()
    func getMoviesListCount() -> Int?
    func getMovie(index: Int) -> MovieModel?
    func goToPreviousViewController()
}
