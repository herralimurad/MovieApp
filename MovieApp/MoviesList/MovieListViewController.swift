//
//  MovieListViewController.swift
//  MovieApp
//
//  Created by Ali Murad on 16/04/2019.
//  Copyright © 2019 Ali Murad. All rights reserved.
//

import UIKit
import IHKeyboardAvoiding

class MovieListViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var nrfView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK:- Properties
    lazy var viewModel : MovieListViewModel = {
        let viewModel = MovieListViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.fetchMovies() // API hit for fetching movies list
        
    }
    
    //MARL:- Methods
    func setupView(){
        self.title = ScreenTitles.MovieListController
        KeyboardAvoiding.avoidingView = self.searchBar // Library usuage for avoiding search bar hidding behind keyboard
    }
    
    
    
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowsCount = viewModel.numberOfCells
        nrfView.isHidden = rowsCount != 0
        return rowsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellNames.MovieCell) as! MovieCell
        if let movie = viewModel.getMovieCellData(at: indexPath) {
            cell.populateCell(movie: movie)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: ViewControllers.DetailScreen) as? MovieDetailViewController {
            if let movie = viewModel.getMovieCellData(at: indexPath) {
                vc.viewModel.movieId = movie.id
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.cellHeight
    }
}


extension MovieListViewController:  UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.updateSearchResults(searchString: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.isSearchModeOn = false
        searchBar.resignFirstResponder()
    }
}

extension MovieListViewController : MovieListViewModelDelegate {
    func showError(errorMsg: String) {
        let alert = UIAlertController(title: "", message: errorMsg, preferredStyle: .alert)
        let doneButton = UIAlertAction(title: "Ok", style: .default) { _ in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(doneButton)
        self.present(alert, animated: true)
        self.tableview.delegate = self // tableview delegates are set there because we want to see no record found screen only in case of error not before it.
        self.tableview.dataSource = self
    }
    func reloadTableView() {
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.reloadData()
    }
}
