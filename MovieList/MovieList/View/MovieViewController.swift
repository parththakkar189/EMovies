//
//  MovieViewController.swift
//  MovieList
//
//  Created by Parth Thakkar on 2021-01-15.
//

import UIKit
import PKHUD
class MovieViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var movieListCollectionView: UICollectionView!
    
    //MARK: Properties
    var presenter: MovieListViewToPresenterProtocol?
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.updateView()
        self.setUpCollectionView()
    }
   
    //MARK: Methods
    func setUpCollectionView(){
        self.navigationController!.navigationBar.isHidden = true
        self.movieListCollectionView.dataSource = self
    }
    
}

extension MovieViewController: MovieListPresenterToViewProtocol {
    func showProgressView() {
        HUD.show(.progress, onView: self.view)
    }
    
    func hideProgressView() {
        HUD.hide()
    }
    
    func deselectRowAt(row: Int, section: Int) {
        movieListCollectionView.deselectItem(at: IndexPath(row: row, section: section), animated: false)
    }
    
    func showMovies() {
        DispatchQueue.main.async {
            self.movieListCollectionView.reloadData()
        } 
    }
        
    func showError() {
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching movies", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension MovieViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
         return appDelegate.arrGenre.count

     }
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let movies = presenter?.getMoviesListCount(section: appDelegate.arrGenre[section]) {
            return movies.count
         }else{
             let alert = UIAlertController(title: "Alert", message: "No movies found.", preferredStyle: UIAlertController.Style.alert)
             alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
             self.present(alert, animated: true, completion: nil)
         }
         return 0
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCollectionViewCell, for: indexPath) as! MovieCollectionViewCell
         
        let movie = presenter?.getMoviesListCount(section: appDelegate.arrGenre[indexPath.section])?[indexPath.row]
         guard let image = movie?.poster else {
             return UICollectionViewCell()
         }
        cell.setCell(imageUrl: image)
         return cell
     }
     
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
         switch kind {
         case UICollectionView.elementKindSectionHeader:
             let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: movieHeaderViewCell, for: indexPath) as! MovieHeaderViewCell
             cell.lblMovieGenre.text = appDelegate.arrGenre[indexPath.section]
             return cell
         default:
             let alert = UIAlertController(title: "Alert", message: "Something went wrong", preferredStyle: UIAlertController.Style.alert)
             alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
             self.present(alert, animated: true, completion: nil)
         }

         return UICollectionReusableView()
     }
}


extension MovieViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(index: indexPath.row, section: appDelegate.arrGenre[indexPath.section])
        presenter?.deselectRowAt(index: indexPath.row, section: indexPath.section)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension MovieViewController: UICollectionViewDelegateFlowLayout{
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
