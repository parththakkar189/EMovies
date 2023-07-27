//
//  MoviesPresenter.swift
//  MovieList
//
//  Created by Parth Thakkar on 2021-01-15.
//

import Foundation

class MoviePresenter: MovieListViewToPresenterProtocol {
    
    // MARK: - Properties
    weak var view: MovieListPresenterToViewProtocol?
    var interactor: MovieListPresentorToInteractorProtocol?
    var router: MovieListPresenterToRouterProtocol?
    
    // MARK: - Methods
    func updateView() {
        view?.showProgressView()
        interactor?.fetchMovies()
    }
    
    func getMoviesListCount() -> Int? {
        return interactor?.movies?.count
    }
    
    func getMoviesListCount(section: String) -> [MovieModel]? {
        return interactor?.movies?.filter({ (model) -> Bool in
            model.genres.contains(section)
        })
    }
    
    func getMovie(index: Int) -> MovieModel? {
        return interactor?.movies?[index]
    }
    
    func didSelectRowAt(index: Int, section: String) {
        interactor?.featchMovieForDetail(at: index, from: section)
    }
    
    func deselectRowAt(index: Int, section: Int) {
        view?.deselectRowAt(row: index, section: section)
    }
}

// MARK: - MovieListInteractorToPresenterProtocol
extension MoviePresenter: MovieListInteractorToPresenterProtocol {
    
    func MoviesFetched() {
        view?.hideProgressView()
        view?.showMovies()
        
    }
    
    func MoviesFetchedFailed() {
        view?.hideProgressView()
        view?.showError()
    }
    
    func getMovieSuccess(_ movie: MovieModel) {
        router?.pushToMovieDetail(on: view!, with: movie)
    }
    
    func getMovieFailure() {
        print("Couldn't retrieve movie by index")
    }
}
