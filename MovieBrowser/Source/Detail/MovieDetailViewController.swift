//
//  MovieDetailViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/26/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        
    }
    
    func configure(Movie : Movies) {
        
        if let poster = Movie.poster_path {
            Network().picture(poster_Path: poster) { response in
                
                DispatchQueue.main.async {
                    self.movieImage.image = response

                }
            }}
        
        
        titleLabel.text = Movie.title
        dateLabel.text = Movie.release_date
        descriptionLabel.text = Movie.overview
        
    }
    
    
}
