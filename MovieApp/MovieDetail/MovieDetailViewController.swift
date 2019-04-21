//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Ali Murad on 18/04/2019.
//  Copyright © 2019 Ali Murad. All rights reserved.
//

import UIKit
import XCDYouTubeKit
import AVKit

class MovieDetailViewController : UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var movieThumbnail: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDetailsStackView: UIStackView!
    @IBOutlet weak var trailerButton : UIButton!
    //MARK:- Properties
    lazy var viewModel : MovieDetailViewModel = {
        let viewModel = MovieDetailViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    
    lazy var playerViewController : AVPlayerViewController = {
        let playerViewController = AVPlayerViewController()
        return playerViewController
    }()
    
    //MARK:- Life Cyle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.fetchMovieDetails()
    }
    
    //MARK:- Button Actions
    @IBAction func actionForWatchTrailer(_ sender: UIButton) {
        viewModel.fetchMovieTrailer {
            self.playVideo(videoIdentifier: self.viewModel.movieTrailers?.trailers?.first?.key)
        }
    }
    
    //MARK:- Methods
    func setupUI(){
        self.title = ScreenTitles.MovieDetailController
        self.movieDetailsStackView.subviews.forEach({ $0.removeFromSuperview() })
        movieDetailsStackView.spacing = 20
        trailerButton.isHidden = true
    }
    
    // Method to create date, genres and overview section dynamically
    func createTitleDescriptionView(title: String, description: String?) {
        guard let desc  = description else { return }
        
        let stackview = UIStackView()
        stackview.axis = .vertical
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.text = title
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        
        let descLabel = UILabel()
        descLabel.textColor = .black
        descLabel.text = desc
        descLabel.numberOfLines = 0
        descLabel.lineBreakMode = .byWordWrapping
        descLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        stackview.addArrangedSubview(titleLabel)
        stackview.addArrangedSubview(descLabel)
        self.movieDetailsStackView.addArrangedSubview(stackview)
        titleLabel.sizeToFit()
        descLabel.sizeToFit()
    }
    
    // Play youtube video with video identifier
    func playVideo(videoIdentifier: String?) {
        
        self.present(playerViewController, animated: true, completion: nil)
        
        XCDYouTubeClient.default().getVideoWithIdentifier(videoIdentifier) { [weak playerViewController] (video: XCDYouTubeVideo?, error: Error?) in
            if let streamURLs = video?.streamURLs, let streamURL = (streamURLs[XCDYouTubeVideoQualityHTTPLiveStreaming] ?? streamURLs[YouTubeVideoQuality.hd720] ?? streamURLs[YouTubeVideoQuality.medium360] ?? streamURLs[YouTubeVideoQuality.small240]) {
                NotificationCenter.default.addObserver(self, selector: #selector(self.videoDidEnd(notification:)) , name:  NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerViewController?.player?.currentItem)
                
                playerViewController?.player = AVPlayer(url: streamURL)
                playerViewController?.player?.play()
                
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    // for dissmiss view on video end
    @objc func videoDidEnd(notification: Notification) {
        NotificationCenter.default.removeObserver(self, name:  NSNotification.Name.AVPlayerItemDidPlayToEndTime, object:  notification.object)
        playerViewController.dismiss(animated: true, completion: nil)
        
    }
    
}


// Struct for youtube video quality
struct YouTubeVideoQuality {
    static let hd720 = NSNumber(value: XCDYouTubeVideoQuality.HD720.rawValue)
    static let medium360 = NSNumber(value: XCDYouTubeVideoQuality.medium360.rawValue)
    static let small240 = NSNumber(value: XCDYouTubeVideoQuality.small240.rawValue)
}


extension MovieDetailViewController : MovieDetailViewModelDelegate {
    func showError(errorMsg: String) {
        let alert = UIAlertController(title: "", message: errorMsg, preferredStyle: .alert)
        let doneButton = UIAlertAction(title: "Ok", style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(doneButton)
        self.present(alert, animated: true)
    }
    
    func populateScreenWith(imageURL: URL?, title: String?, genre: String?, releaseDate: String?, overview: String?) { self.movieTitle.text = title
        self.trailerButton.isHidden = false
        if let url = imageURL {
            self.movieThumbnail.setImageWith(url, placeholderImage: UIImage(named: Images.PlaceHolderImage))
        }
        self.createTitleDescriptionView(title: Messages.Genres, description: genre)
        self.createTitleDescriptionView(title: Messages.Date, description: releaseDate)
        self.createTitleDescriptionView(title: Messages.Overview, description: overview)
    }
    
}
