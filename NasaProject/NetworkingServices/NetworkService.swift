//
//  NetworkService.swift
//  NasaProject
//
//  Created by Чистяков Василий Александрович on 10.10.2021.
//

import Foundation

protocol Networking {
    func request(urlString: String, complition: @escaping(Data?, Error?)-> Void)
}

class NetworkService: Networking  {
    
    // построение запроса данных по URL
    func request(urlString: String, complition: @escaping(Data?, Error?)-> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, compition: complition)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, compition: @escaping (Data?, Error?)-> Void) ->
    URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                compition(data,error)
            }
        }
    }
}
