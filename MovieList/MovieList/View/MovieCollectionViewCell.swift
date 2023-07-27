//
//  MovieCollectionViewCell.swift
//  MovieList
//
//  Created by Parth Thakkar on 2021-01-15.
//

import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var posterImage: UIImageView!
    
    // MARK:- Methods
    func setCell(imageUrl: String) {
        posterImage.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "refresh"))
    }
}
