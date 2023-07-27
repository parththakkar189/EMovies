//
//  SearchViewRouter.swift
//  MovieList
//
//  Created by Parth Thakkar on 2021-01-17.
//

import Foundation
import UIKit
//class SearchViewRouter: SearchMovieListPresenterToRouterProtocol {
//    static func createModule() -> UIViewController {
//        let viewController = mainstoryboard.instantiateViewController(identifier: searchViewController) as! SearchViewController
//        
//        let presenter: SearchMovieListViewToPresenterProtocol & SearchMovieListInteractorToPresenterProtocol = SearchMoviePresenter()
//        viewController.presenter = presenter
//        viewController.presenter?.router = SearchViewRouter()
//        viewController.presenter?.view = viewController
//        viewController.presenter?.interactor = SearchMovieListInteractor()
//        viewController.presenter?.interactor?.presenter = presenter
//        return viewController
//    }
//    
//    func popToViewController(from view: SearchMovieListPresenterToViewProtocol){
//        let view = view as! SearchViewController
//        view.navigationController?.popViewController(animated: true)
//    }
//}
