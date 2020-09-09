//
//  DownloadImage.swift
//  Pokemon app
//
//  Created by Scizor on 09/09/20.
//  Copyright © 2020 Scizor. All rights reserved.
//

import UIKit

final class DownloadImage {
    static var shared = DownloadImage()
    
    func getPokemonImage(id: String, completion: @escaping (UIImage?, Error?) -> Void) {
        let url = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
        guard let imageURL = URL(string: url) else { return }
        
        var request = URLRequest(url: imageURL)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(nil, error)
                return
            }
            
            guard let imageData = data else {
                completion(nil, error)
                return
            }
            
            guard let image = UIImage(data: imageData) else {
                completion(nil, error)
                return
            }
            
            completion(image, nil)
        }.resume()
    }
}

