//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Ali Murad on 18/04/2019.
//  Copyright © 2019 Ali Murad. All rights reserved.
//

import Foundation

protocol MovieDetailViewModelDelegate {
    func populateScreenWith(imageURL: URL?, title: String?, genre: String?, releaseDate: String?, overview: String?)
    func showError(errorMsg: String)
}

class MovieDetailViewModel {
    
    //MARK: - Properties
    var movieDetails : MovieDetails?
    var movieId: Int?
    var movieTrailers: TrailersInformation?
    var service: BaseServiceable
    var delegate: MovieDetailViewModelDelegate?
    
    
    init(baseService: BaseServiceable = BaseService()) {
        service = baseService
    }
    
    //MARK: - API Hits
    // fetch movie details with movie id
    func fetchMovieDetails() {
        if let id = movieId {
            let movieDetailsRequestData = RequestData.movieDetail(id: id)
            service.request(requestData: movieDetailsRequestData, responseModel: MovieDetails.self) { [weak self] (dataObject, error) in
                guard let `self` = self else { return }
                if let error = error {
                    self.delegate?.showError(errorMsg: error)
                    return
                }
                guard let movieDetails = dataObject as? MovieDetails else { return }
                self.movieDetails = movieDetails
                self.parseMovieDetailObject(movieDetailObj: movieDetails)
            }
        }
    }
    

    // get video identifier of movie trailer from API
    func fetchMovieTrailer(completion: @escaping (()->())){
        if let id = movieId {
            let movieDetailsRequestData = RequestData.movieTrailer(id: id)
            service.request(requestData: movieDetailsRequestData, responseModel: TrailersInformation.self) { [weak self] (dataObject, error) in
                guard let `self` = self else { return }
                if let error = error {
                    self.delegate?.showError(errorMsg: error)
                    return
                }
                guard let movieTrailers = dataObject as? TrailersInformation else { return }
                self.movieTrailers = movieTrailers
                completion()
            }
        }
        
    }
    //MARK: - Methods
    // get comma separeted genres from genres array
    func getFormatedGenres(genres: [Genre]) -> String {
        let names = genres.map({ (genre) -> String in
            if let name = genre.name {
                return name
            }
            return ""
            
        })
        return names.joined(separator: ", ")
    }
    // parse MovieDetails object and return properties which are available and required
    func parseMovieDetailObject(movieDetailObj: MovieDetails?) {
        var imageURL : URL? = nil
        var genre : String? = nil
        var title : String? = nil
        var releaseDate : String? = nil
        var overview: String? = nil
        
        title = movieDetailObj?.title
        if let imageName = movieDetailObj?.backdropPath {
            imageURL = URL(string: URLs.ImageURL + imageName)
        }
        if let genres = movieDetailObj?.genres {
            genre = getFormatedGenres(genres: genres)
            
        }
        if let date = movieDetailObj?.releaseDate,
            let formatedDate = convertDate(fromFormat: DateFormate.FormatFromServer, toFormat: DateFormate.FormatToShow, dateString: date) {
            releaseDate = formatedDate
        }
        if let overV = movieDetailObj?.overview {
            overview = overV
        }
        self.delegate?.populateScreenWith(imageURL: imageURL, title: title, genre: genre, releaseDate: releaseDate, overview: overview)
        
    }
    
    
    // Helper method to convert data formate
    func convertDate(fromFormat: String, toFormat: String, dateString: String) -> String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = fromFormat
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = toFormat
        
        if let date = dateFormatterGet.date(from: dateString) {
            return dateFormatterPrint.string(from: date)
        }
        return nil
    }
    
}
