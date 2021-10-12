//
//  NetworkFetchService.swift
//  NasaProject
//
//  Created by Чистяков Василий Александрович on 10.10.2021.
//

import Foundation
import UIKit

class NetworkFetchService {
    
    let jsonNasa = "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY"
    
    var dataFetcher: DataFetcher
    
    init(dataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.dataFetcher = dataFetcher
    }
    
    func fetchDataNasaImage(complitionHandler: @escaping (NasaImageModel?)-> Void) {
        let jsonNasa = "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY"
        dataFetcher.fetchGenericJSONData(urlString: jsonNasa, response: complitionHandler)
    }
    
    func fetchDataNasaRover(complitionHandler: @escaping (NasaRoverModel?)-> Void) {
        
        let urlString = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=2015-6-3&api_key=DEMO_KEY"
        dataFetcher.fetchGenericJSONData(urlString: urlString, response: complitionHandler)
    }
    
    
    func fecthImage(urlString: String, complitionHandler: @escaping (UIImage)-> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response , error in
            guard let data = data, let iamge = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                complitionHandler(iamge)
            }
        }.resume()
    }
    
}
