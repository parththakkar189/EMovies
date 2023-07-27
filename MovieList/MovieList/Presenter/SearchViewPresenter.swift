//
//  SearchViewPresenter.swift
//  MovieList
//
//  Created by Parth Thakkar on 2021-01-17.
//

import Foundation
import UIKit

class SearchMoviePresenter: SearchMovieListViewToPresenterProtocol{
    
    

    //MARK: Properties
    
    var view: SearchMovieListPresenterToViewProtocol?
    
    var interactor: SearchMovieListPresentorToInteractorProtocol?
    
    var router: SearchMovieListPresenterToRouterProtocol?
    
    //MARK: Methods
    
    func updateView(searchText: String) {
        view?.showProgressView()
        interactor?.fetchSearchedMovies(searchText: searchText)
     }
     
     func getMoviesListCount() -> Int? {
        interactor?.movies?.count
     }
    
    func getMovie(index: Int) -> MovieModel? {
        interactor?.movies?[index]
    }
    
    func goToPreviousViewController() {
        router?.popToViewController(from: view!)
    }
}

extension SearchMoviePresenter: SearchMovieListInteractorToPresenterProtocol {
    func SearchMoviesFetched() {
        view?.hideProgressView()
        view?.showSearchedMovies()
    }
    
    func SearchMoviesFetchedFailed() {
        view?.hideProgressView()
        view?.showSearchedError()
    }
}
