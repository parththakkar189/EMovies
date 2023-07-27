//
//  FavouriteViewController.swift
//  MovieList
//
//  Created by Parth Thakkar on 2021-01-18.
//

import UIKit

class FavouriteViewController: UIViewController {

    
    @IBOutlet weak var favouriteMovieCollectionView: UICollectionView!
    @IBOutlet weak var btnBack: UIButton!
    
    var presenter: FavouriteMovieListViewToPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.updateView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func actioBtnBackClicked(sender: UIButton){
        presenter?.goToPreviousViewController()
    }
}

extension FavouriteViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = presenter?.getMoviesListCount(){
            return count
        } else{
            let alert = UIAlertController(title: "Alert", message: "No favourite movies found.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCollectionViewCell, for: indexPath) as! MovieCollectionViewCell
         
        let movie = presenter?.getMovie(index: indexPath.row)
         guard let image = movie?.poster else {
             return UICollectionViewCell()
         }
        cell.setCell(imageUrl: image)
         return cell
    }
    
    
}

extension FavouriteViewController: UICollectionViewDelegateFlowLayout{
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

extension FavouriteViewController: UICollectionViewDelegate{}

extension FavouriteViewController: FavouriteMovieListPresenterToViewProtocol{
    func showFavouriteMovies() {
        DispatchQueue.main.async {
            self.favouriteMovieCollectionView.reloadData()
        }
    }
    
    func showFavouriteMovieError() {
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching movies", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
