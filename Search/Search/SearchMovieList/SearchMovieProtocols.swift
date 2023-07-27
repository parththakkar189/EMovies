//
//  SearchMovieProtocols.swift
//  Search
//
//  Created by Parth Thakkar on 2021-06-21.
//

import Foundation
import UIKit

protocol SearchMovieListPresenterToViewProtocol: AnyObject {
    func showSearchedMovies()
    func showSearchedError()
    
    func showProgressView()
    func hideProgressView()
}

protocol SearchMovieListInteractorToPresenterProtocol: AnyObject {
    func SearchMoviesFetched()
    func SearchMoviesFetchedFailed()
}

protocol SearchMovieListPresentorToInteractorProtocol: AnyObject {
    var presenter: SearchMovieListInteractorToPresenterProtocol? { get set }
    var movies: [MovieModel]? { get }
    
    func fetchSearchedMovies(searchText: String)
}

protocol SearchMovieListPresenterToRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
    func popToViewController(from view: SearchMovieListPresenterToViewProtocol)
}

protocol SearchMovieListViewToPresenterProtocol: AnyObject {
    var view: SearchMovieListPresenterToViewProtocol? { get set }
    var interactor: SearchMovieListPresentorToInteractorProtocol? { get set }
    var router: SearchMovieListPresenterToRouterProtocol? { get set }
    
    func updateView(searchText: String)
    func getMoviesListCount() -> Int?
    func getMovie(index: Int) -> MovieModel?
    func goToPreviousViewController()
}
