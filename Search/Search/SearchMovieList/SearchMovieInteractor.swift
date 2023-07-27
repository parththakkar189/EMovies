//
//  SearchMovieInteractor.swift
//  Search
//
//  Created by Parth Thakkar on 2021-06-21.
//

import Foundation
import UIKit
import Alamofire

class SearchMovieListInteractor: SearchMovieListPresentorToInteractorProtocol {
    var presenter: SearchMovieListInteractorToPresenterProtocol?
    
    var movies: [MovieModel]?
    
    func fetchSearchedMovies(searchText: String) {
        let headers: HTTPHeaders = [
            "Authorization" : "Bearer Wookie2019",
            "Accept": "application/json"
        ]
        let params: [String: String] = ["q" : searchText]
        let searchURL = URL(string: "https://wookie.codesubmit.io/movies?")
        
        AF.request(searchURL!, method: .get, parameters: params, headers: headers).response { response in
            if(response.response?.statusCode == 200){
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let movieResponse = try decoder.decode(MovieResponse.self, from: data)
                    guard let movies = movieResponse.movies else { return }
                    self.movies = movies
                    self.presenter?.SearchMoviesFetched()
                } catch let error {
                    print(error.localizedDescription)
                    self.presenter?.SearchMoviesFetchedFailed()
                }
            }
            else {
                self.presenter?.SearchMoviesFetchedFailed()
            }
        }
    }

}
