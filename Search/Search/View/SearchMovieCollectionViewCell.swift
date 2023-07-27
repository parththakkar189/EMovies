//
//  MovieCollectionViewCell.swift
//  Search
//
//  Created by Parth Thakkar on 2021-06-22.
//

import UIKit
import SDWebImage

class SearchMovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgPoster: UIImageView!
    
    func setCell(imgUrl: String) {
        imgPoster.sd_setImage(with: URL(string: imgUrl), placeholderImage: nil)
    }
}


class testCell: UICollectionViewCell {
    @IBOutlet weak var imagePoster: UIImageView!
    
    func setCell(imgUrl: String) {
        imagePoster.sd_setImage(with: URL(string: imgUrl), placeholderImage: nil)
    }
}
