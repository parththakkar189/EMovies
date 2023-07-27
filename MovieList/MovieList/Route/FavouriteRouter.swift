//
//  FavouriteRouter.swift
//  MovieList
//
//  Created by Parth Thakkar on 2021-01-18.
//

import Foundation
import UIKit

class FavouriteViewRouter: FavouriteMovieListPresenterToRouterProtocol {
    
    static func createModule() -> UIViewController {
        let viewController = mainstoryboard.instantiateViewController(identifier: favouriteViewController) as! FavouriteViewController
        
        let presenter: FavouriteMovieListViewToPresenterProtocol & FavouriteMovieListInteractorToPresenterProtocol = FavouriteMoviePresenter()
        viewController.presenter = presenter
        viewController.presenter?.router = FavouriteViewRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = FavouriteMovieListInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        return viewController
    }
    
    func popToViewController(from view: FavouriteMovieListPresenterToViewProtocol){
        let view = view as! FavouriteViewController
        view.navigationController?.popViewController(animated: true)
    }
}
