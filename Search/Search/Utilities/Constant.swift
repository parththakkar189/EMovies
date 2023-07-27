//
//  Constant.swift
//  Search
//
//  Created by Parth Thakkar on 2021-06-22.
//

import Foundation
import UIKit

internal class Constants {
    static let shared = Constants()
    let storyboard = UIStoryboard(name: "Search", bundle: Bundle(identifier: "com.ParthThakkar.Search"))
    
    //Controllers
    let searchViewController = "SearchViewController"
    let movieCollectionViewCell  = "testCell"
    
    static func loadStoryboard() -> UIStoryboard {
        let storyBoard = UIStoryboard(name: "Search", bundle: Bundle(identifier: "com.ParthThakkar.Search"))
        return storyBoard
    }
}
