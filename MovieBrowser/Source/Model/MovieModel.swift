//
//  MovieModel.swift
//  MovieBrowser
//
//  Created by Fabian Cooper on 8/18/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation
import UIKit

struct TopLevel : Decodable {
    
    var results : [Movies]

}

struct Movies : Decodable {
    
    var title : String?
    var release_date : String?
    var vote_average : Double?
    var overview : String?
    var poster_path : String?
    
}
