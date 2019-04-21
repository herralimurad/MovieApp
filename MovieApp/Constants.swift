//
//  Constants.swift
//  MovieApp
//
//  Created by Ali Murad on 17/04/2019.
//  Copyright © 2019 Ali Murad. All rights reserved.
//


import Foundation


struct Constants {
    static var APIKey = "85d7084a9d494a93b094b9d319cb4317"
}

struct URLs {
    static var PopularMoviesURL = "https://api.themoviedb.org/3/movie/popular/"
    static var ImageURL = "http://image.tmdb.org/t/p/w342/"
    static var MovieDetailsURL = "https://api.themoviedb.org/3/movie/"
    static var MovieTrailerURL = "https://api.themoviedb.org/3/movie/"+PlaceHolders.MovieId+"/videos"
}

struct ParameterNames {
    static let APIKey = "api_key"
}

struct ScreenTitles {
    static let MovieListController   = "Movie Catalog"
    static let MovieDetailController = "Movie Detail"
}

struct Messages {
    static var Genres   = "Genres"
    static var Date     = "Date"
    static var Overview = "Overview"
    static let JSONParsingError     = "Could not Parse Json"
    static let NetworkUnavailable   = "No network connection"
}

struct CellNames {
    static let MovieCell = "MovieCell"
}

struct ViewControllers {
    static let DetailScreen = "MovieDetailViewController"
}

struct Images {
    static let PlaceHolderImage = "Image"
}


struct DateFormate {
    static let FormatFromServer = "yyyy-MM-dd"
    static let FormatToShow     = "dd.MM.yyyy"
}

struct PlaceHolders {
    static let MovieId              = "#MOVIE_ID#"
}
