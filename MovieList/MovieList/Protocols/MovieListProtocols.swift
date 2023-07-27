//
//  MovieListProtocols.swift
//  MovieList
//
//  Created by Parth Thakkar on 2021-01-15.
//

import Foundation
import UIKit


protocol MovieListPresenterToViewProtocol: class {
    func showMovies()
    func showError()
    
    func showProgressView()
    func hideProgressView()
    
    func deselectRowAt(row: Int, section: Int)
}

protocol MovieListInteractorToPresenterProtocol: class {
    func MoviesFetched()
    func MoviesFetchedFailed()
    
    func getMovieSuccess(_ movie: MovieModel)
    func getMovieFailure()
    
}

protocol MovieListPresentorToInteractorProtocol: class {
    var presenter: MovieListInteractorToPresenterProtocol? { get set }
    var movies: [MovieModel]? { get }
    
    func fetchMovies()
    func featchMovieForDetail(at index: Int, from section: String)
}

protocol MovieListPresenterToRouterProtocol: class {
    static func createModule() -> UINavigationController
    func pushToMovieDetail(on view: MovieListPresenterToViewProtocol, with movie: MovieModel)
}

protocol MovieListViewToPresenterProtocol: class {
    var view: MovieListPresenterToViewProtocol? { get set }
    var interactor: MovieListPresentorToInteractorProtocol? { get set }
    var router: MovieListPresenterToRouterProtocol? { get set }
    
    func updateView()
    func getMoviesListCount() -> Int?
    func getMoviesListCount(section: String) -> [MovieModel]?
    func getMovie(index: Int) -> MovieModel?
    
    func didSelectRowAt(index: Int, section: String)
    func deselectRowAt(index: Int, section: Int)
}


