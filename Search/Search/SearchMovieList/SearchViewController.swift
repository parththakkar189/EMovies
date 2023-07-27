//
//  SearchViewController.swift
//  Search
//
//  Created by Parth Thakkar on 2021-06-21.
//

import UIKit
import PKHUD

class SearchViewController: UIViewController, UISearchBarDelegate {

    //MARK: IBOutlet
    @IBOutlet weak var searchMovieCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btnBack: UIButton!
    //MARK: Properties
    var presenter: SearchMovieListViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if validateSearchText(string: searchBar.text!) {
            presenter?.updateView(searchText: searchBar.text!)
            searchBar.text = ""
        }
        searchBar.resignFirstResponder()
    }
    
    @IBAction func actionBtnBackClicked(sender: UIButton){
        presenter?.goToPreviousViewController()
    }
    
    func validateSearchText(string: String) -> Bool {
        if string.isEmpty {
            return false
        }
        return true
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.shared.movieCollectionViewCell, for: indexPath) as! testCell
        if let movie = presenter?.getMovie(index: indexPath.row) {
            cell.imagePoster.sd_setImage(with: URL(string: movie.poster), placeholderImage: nil)
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
