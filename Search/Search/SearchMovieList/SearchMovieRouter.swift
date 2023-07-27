//
//  SearchMovieRouter.swift
//  Search
//
//  Created by Parth Thakkar on 2021-06-21.
//
    
import Foundation
import UIKit
public class SearchViewRouter: SearchMovieListPresenterToRouterProtocol {
    public static func createModule() -> UIViewController {
        let viewController = Constants.loadStoryboard().instantiateViewController(identifier: Constants.shared.searchViewController) as SearchViewController
        let presenter: SearchMovieListViewToPresenterProtocol & SearchMovieListInteractorToPresenterProtocol = SearchMoviePresenter()
        viewController.presenter = presenter
        viewController.presenter?.router = SearchViewRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = SearchMovieListInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        return viewController
    }
    
    func popToViewController(from view: SearchMovieListPresenterToViewProtocol){
        let view = view as! SearchViewController
        view.navigationController?.popViewController(animated: true)
    }
}
