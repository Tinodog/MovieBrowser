//
//  Network.swift
//  SampleApp
//
//  Created by Struzinski, Mark - Mark on 9/17/20.
//  Copyright © 2020 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class Network {
    
    let apiKey = "5885c445eab51c7004916b9c0313e2d3"
    
    func loadData(search : String, completion: @escaping (TopLevel) -> ()) {
        
        guard let url = URL(string:"https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=en-US&query=\(search)&page=1&include_adult=false") else {
            return
        }
    
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            guard let responseData = data else{
                print("Did not recieve data")
                return
            }
            
            if let error = error {
                print("\(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                        (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
              }
            
            do {
                
                let movies : TopLevel = try! JSONDecoder().decode(TopLevel.self, from: responseData)
                completion(movies)
            }
            
        })
        task.resume()
    }
    
    func picture(poster_Path : String ,completion: @escaping (UIImage) -> ()) {
        
       let imageString = "https://image.tmdb.org/t/p/w500\(poster_Path)"
        
        let url = URL(string: imageString)!
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            guard let responseData = data else{
                print("Did not recieve data")
                return
            }
            
            if let error = error {
                print("\(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                        (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
              }
            
            let image = UIImage(data: responseData)
            completion(image!)
        
    }
    
)
        task.resume()
    }
}
