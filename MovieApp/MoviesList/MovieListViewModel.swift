//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Ali Murad on 17/04/2019.
//  Copyright © 2019 Ali Murad. All rights reserved.
//

import Foundation
import UIKit // have to import due to CGFloat usuage

protocol MovieListViewModelDelegate {
    func showError(errorMsg: String) -> ()
    func reloadTableView() -> ()
}

class MovieListViewModel {
    
    //MARK:- Properties
    var moviesInformation       : MovieInformation?
    var isSearchModeOn          = false
    lazy var filteredMovies     : [Movie] = {
        let filteredMovies = [Movie]()
        return filteredMovies
    }()
    var numberOfCells : Int {
        return isSearchModeOn ? filteredMovies.count :  moviesInformation?.movies?.count ?? 0
    }
    
    var delegate : MovieListViewModelDelegate?
    let service : BaseServiceable
    
    //MARK:- Constants
    var cellHeight              : CGFloat = 90
    
    init(service: BaseServiceable = BaseService())
    {
        self.service = service
    }
    
    //MARK:- API Hit
    func fetchMovies(){
        let movieListRequestData = RequestData.movieList
        service.request(requestData: movieListRequestData, responseModel: MovieInformation.self) { [weak self] (dataObject, error) in
            guard let `self` = self else { return }
            if let error = error {
                self.delegate?.showError(errorMsg: error)
                return
            }
            guard let moviesInformation = dataObject as? MovieInformation else { return }
          
            self.moviesInformation = moviesInformation
            self.delegate?.reloadTableView()
        }
    }
    
    
    //MARK:- Methods for TableView Data
    
    
    func getMovieCellData(at indexPath: IndexPath) -> Movie? {
        if isSearchModeOn {
            return filteredMovies[indexPath.row]
        }else {
            return moviesInformation?.movies?[indexPath.row]
        }
    }
    
    //MARK:- Methods for prepare data for search
    func updateSearchResults(searchString: String) {
        if searchString.isEmpty {
            isSearchModeOn = false
        }
        else {
            if let movies  = moviesInformation?.movies {
                
                filteredMovies = movies.filter({
                    return $0.title!.lowercased().contains(searchString.lowercased())
                })
            }
            isSearchModeOn = true
        }
        self.delegate?.reloadTableView()
    }
    
}
