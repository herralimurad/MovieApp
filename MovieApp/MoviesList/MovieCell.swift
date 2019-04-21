//
//  MovieCell.swift
//  MovieApp
//
//  Created by Ali Murad on 16/04/2019.
//  Copyright © 2019 Ali Murad. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieThumbnail: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    
    
    func populateCell(movie: Movie) {
        movieName.text = movie.title
        if let imageName = movie.thumbnailImage {
            if let url = URL(string: URLs.ImageURL + imageName) {
                movieThumbnail.setImageWith(url, placeholderImage: UIImage(named: Images.PlaceHolderImage))
            }
        }
    }
}
