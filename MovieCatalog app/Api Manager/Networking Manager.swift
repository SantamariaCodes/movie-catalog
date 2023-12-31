//
//  Networking Manager.swift
//  MovieCatalog app
//
//  Created by Diego Santamaria on 3/1/24.
//

import Foundation

final class NetworkingManager {
    
    static let shared = NetworkingManager()
    
    private init () {}
    
    func request<T: Codable> (_ absoluteURL: String, type: T.Type, completion: @escaping (Result<T,Error>) -> Void  )  {
        
        guard let url = URL(string: absoluteURL) else {
            completion(.failure(NetworkingError.invalidUrl))
            return
        }
    
        let request = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                completion(.failure(NetworkingError.custom(error: error!)))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...300) ~= response.statusCode else {
                let statusCode = (response as! HTTPURLResponse).statusCode
                completion(.failure(NetworkingError.invalidStatusCode(statusCode: statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkingError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let res = try decoder.decode(T.self, from: data)
                completion(.success(res))
            } catch {
                completion(.failure(NetworkingError.failedToDecode(error: error)))     
            }
            
            
        }
        dataTask.resume()
    }
    
}


extension NetworkingManager {
    enum NetworkingError: Error {
        case invalidUrl
        case custom(error: Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedToDecode(error: Error)
    }
}
