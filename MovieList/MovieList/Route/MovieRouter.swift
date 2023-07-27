//
//  MovieRouter.swift
//  MovieList
//
//  Created by Parth Thakkar on 2021-01-15.
//

import Foundation
import UIKit

class MovieRouter: MovieListPresenterToRouterProtocol{

    class func createModule() -> UINavigationController {
    
        let view = mainstoryboard.instantiateViewController(identifier: movieViewController) as! MovieViewController
        let navigationController = UINavigationController(rootViewController: view)
        view.navigationController?.navigationBar.isHidden = true
        let presenter: MovieListViewToPresenterProtocol & MovieListInteractorToPresenterProtocol = MoviePresenter()
        let interactor: MovieListPresentorToInteractorProtocol = MovieListInteractor()
        let router: MovieListPresenterToRouterProtocol = MovieRouter()
        view.presenter = presenter
        view.presenter?.view = view
        view.presenter?.router = router
        view.presenter?.interactor = interactor
        view.presenter?.interactor?.presenter = presenter
        
        return navigationController
    }

    func pushToMovieDetail(on view: MovieListPresenterToViewProtocol, with movie: MovieModel) {
        let movieDetailViewController = MovieDetailRouter.createModule(movie: movie)
            
        let viewController = view as! MovieViewController
        viewController.navigationController?.pushViewController(movieDetailViewController, animated: true)
        
    }
}
