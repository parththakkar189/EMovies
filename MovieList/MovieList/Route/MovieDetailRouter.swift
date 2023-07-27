//
//  MovieDetailRouter.swift
//  MovieList
//
//  Created by Parth Thakkar on 2021-01-17.
//

import Foundation
import UIKit
import Search

class MovieDetailRouter: MovieDetailPresenterToRouterProtocol {
    

    // MARK: Static methods
    class func createModule(movie: MovieModel) -> UIViewController {
        let viewController = mainstoryboard.instantiateViewController(identifier: movieDetailViewController) as! MovieDetailViewController
        
        let presenter: MovieDetailViewToPresenterProtocol & MovieDetailInteractorToPresenterProtocol = MovieDetailPresenter()
        viewController.presenter = presenter
        viewController.presenter?.router = MovieDetailRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = MovieDetailInteractor()
        viewController.presenter?.interactor?.movie = movie
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
 
    func pushToSearchDetail(on view: MovieDetailPresenterToViewProtocol, identifier: String) {
        let viewController = view as! MovieDetailViewController
        switch identifier {
        case searchViewController:
            let searchViewController = SearchViewRouter.createModule()
            viewController.navigationController?.pushViewController(searchViewController, animated: true)
        case favouriteViewController:
            let favController = FavouriteViewRouter.createModule()
            viewController.navigationController?.pushViewController(favController, animated: true)
        default:
            print("Problem in navigation")
        }
        
    }
    
    func popToViewController(from view: MovieDetailPresenterToViewProtocol){
        let view = view as! MovieDetailViewController
        view.navigationController?.popViewController(animated: true)
    }
}
