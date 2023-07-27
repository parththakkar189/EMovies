//
//  File.swift
//  Search
//
//  Created by Parth Thakkar on 2021-06-21.
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
        interactor?.fetchSearchedMovies(searchText: searchText)
        view?.showProgressView()
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
