//
//  Constants.swift
//  MovieList
//
//  Created by Parth Thakkar on 2021-01-15.
//

import Foundation
import UIKit

let mainstoryboard: UIStoryboard = UIStoryboard(name:"Main",bundle: Bundle.main)
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let MOVIE_API: URL = URL(string: "https://wookie.codesubmit.io/movies")!
//let MOVIE_SEARCH_API: String = "https://wookie.codesubmit.io/movies?q=" //<search_term>
let token: String = "Wookie2019"
let movieHeaderViewCell: String = "MovieHeaderViewCell"
let movieCollectionViewCell = "MovieCollectionViewCell"
let movieViewController = "MovieViewController"
let movieDetailViewController = "MovieDetailViewController"
let searchViewController = "SearchViewController"
let favouriteViewController = "FavouriteViewController"
let placeholder = "Search Movie..."

extension String {
    func toDate(withFormat format: String = "yyyy-MM-dd'T'HH:mm:ss") -> Int {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    guard let date = dateFormatter.date(from: self) else {
      preconditionFailure("Take a look to your format")
    }
    let calendar = Calendar.current
    let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        return components.year!
  }
}
