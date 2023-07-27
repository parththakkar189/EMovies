//
//  MovieDetailViewController.swift
//  MovieList
//
//  Created by Parth Thakkar on 2021-01-17.
//

import UIKit
import Search

class MovieDetailViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var scrlMovieDetail: UIScrollView!
    @IBOutlet weak var imgvwMovieBackdrop: UIImageView!
    @IBOutlet weak var imgvwMoviePoster: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var lblMovieYear: UILabel!
    @IBOutlet weak var lblMovieLength: UILabel!
    @IBOutlet weak var lblMovieDirector: UILabel!
    @IBOutlet weak var txtvwMovieOverview: UITextView!
    @IBOutlet weak var lblCast: UILabel!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnAddToFavourite: UIButton!
    @IBOutlet weak var btnFavourites: UIButton!
    // MARK: - Properties
    var presenter: MovieDetailViewToPresenterProtocol?
    var movie: MovieModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presenter?.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func actionBtnSearchClicked(sender: UIButton) {
        presenter?.goToSearch()
    }
    
    @IBAction func actionBtnHomeClicked(sender: UIButton) {
        presenter?.goToHome()
    }
    
    @IBAction func actionBtnAddToFavouriteClicked(sender: UIButton){
        presenter?.addToFavourites(movie: movie!)
    }
    
    @IBAction func actionBtnFavouritesClicked(sender: UIButton) {
        presenter?.goToFavourites()
    }
}

extension MovieDetailViewController: MovieDetailPresenterToViewProtocol{
    func addMovieToFavourite() {
        let alert = UIAlertController(title: "Alert", message: "Movie added successfully", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func addMovieeToFavouritesFailuer() {
        let alert = UIAlertController(title: "Alert", message: "Problem adding movie to favourites", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func showMovieDetail(movie: MovieModel) {
        self.movie = movie
        self.imgvwMovieBackdrop.sd_setImage(with: URL(string: self.movie!.backdrop), placeholderImage: UIImage(named: "refresh"))
        self.imgvwMoviePoster.sd_setImage(with: URL(string: self.movie!.poster), placeholderImage: UIImage(named: "refresh"))
        self.lblMovieTitle.text = self.movie!.title + " " + "(\(String(describing: self.movie?.imdbRating)))"
        self.lblMovieYear.text = "\(String(describing: self.movie!.releasedOn.toDate()))"
        self.lblMovieLength.text = self.movie!.length
        self.lblCast.text = self.movie!.cast.map {($0) }.compactMap({$0}).joined(separator: ",")
        self.txtvwMovieOverview.text = self.movie!.overview
    
    }
    
    func showError() {
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching movie detail", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
