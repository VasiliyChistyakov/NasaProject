//
//  NetworkDataFetcher.swift
//  NasaProject
//
//  Created by Чистяков Василий Александрович on 10.10.2021.
//

import Foundation

protocol DataFetcher {
    func fetchGenericJSONData<T:Decodable>(urlString: String, response: @escaping (T?)-> Void)
}

class NetworkDataFetcher: DataFetcher {
    
    var networking: Networking
    
    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }
    
    func fetchGenericJSONData<T:Decodable>(urlString: String, response: @escaping (T?)-> Void) {
        print(T.self)
        networking.request(urlString: urlString) { data, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                response(nil)
            }
            let decode = self.decodeJson(type: T.self, from: data)
            response(decode)
        }
    }
    
    func decodeJson<T:Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed", jsonError)
            return nil
        }
    }
}
