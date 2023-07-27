//
//  SearchViewController.swift
//  MovieList
//
//  Created by Parth Thakkar on 2021-01-17.
//

import UIKit
import PKHUD
class SearchViewController: UIViewController, UISearchBarDelegate {

    //MARK: IBOutlet
    @IBOutlet weak var searchMovieCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    //MARK: Properties
    var presenter: SearchMovieListViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter?.updateView(searchText: searchBar.text!)
        searchBar.resignFirstResponder()
        searchBar.text = ""
    }
    
    @IBAction func actionBtnBackClicked(sender: UIButton){
        presenter?.goToPreviousViewController()
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let movies = presenter?.getMoviesListCount() {
           return movies
        }
        else{
            let alert = UIAlertController(title: "Alert", message: "No movies found.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCollectionViewCell, for: indexPath) as! MovieCollectionViewCell
        if let movie = presenter?.getMovie(index: indexPath.row) {
            cell.setCell(imageUrl: movie.poster)
        }
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.width/3.0
        let cellHeight = cellWidth

        return CGSize(width: cellWidth, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension SearchViewController: SearchMovieListPresenterToViewProtocol {
    func showProgressView() {
        HUD.show(.progress, onView: self.view)
    }
    
    func hideProgressView() {
        HUD.hide()
    }
    

    func showSearchedMovies() {
        self.searchMovieCollectionView.dataSource = self
        self.searchMovieCollectionView.delegate = self
        DispatchQueue.main.async {
            self.searchMovieCollectionView.reloadData()
        }
    }
    
    func showSearchedError() {
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching movies", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}
