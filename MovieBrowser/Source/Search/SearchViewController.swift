//
//  SearchViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/19/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var movies = [Movies]()
    var search : [String] = []
    
    let cellID = "MovieCell"
    
    @IBOutlet weak var movieView: UITableView!
    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        movieView.delegate = self
        movieView.dataSource = self
        
        searchField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textDidChange(_ textField : UITextField){
        search = []
        guard let searchQuery = textField.text
        
        else {
            
            return
        }
        
        Network().loadData(search: searchQuery){ response in
            
            self.movies = response.results
            DispatchQueue.main.async {
                self.movieView.reloadData()
            }
            
        }

        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movie = movies[indexPath.row]
               guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: cellID,
                    for: indexPath
               ) as? MovieViewCell
               else{
                return UITableViewCell()
               }
        
        cell.titleLabel?.text = movie.title
        cell.dateLabel?.text = movie.release_date
        cell.ratingLabel?.text = String(movie.vote_average ?? 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow  = movies[indexPath.row]
            
        
        let detailScreen = MovieDetailViewController.init(nibName: "MovieDetail", bundle: nil)
        _ = detailScreen.view
        
        self.navigationController?.pushViewController(detailScreen, animated: true)
        
        detailScreen.configure(Movie: selectedRow)
        
        }
    
}

