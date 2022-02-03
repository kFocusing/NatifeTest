//
//  NetworkService.swift
//  NatifeTest
//
//  Created by Danylo Klymov on 29.01.2022.
//

import Foundation

class NetworkService {
    //MARK: - Static -
    static let shared = NetworkService()
    
    //MARK: - Internal -
    func getData<T: Codable>(url: URL, expacting: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let session = URLSession.shared
        session.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {
                completion(.failure(NetworkingError.failResponseJSON))
                return
            }
            if let post = self.parseJson(data, expacting: expacting) {
                completion(.success(post))
            } else {
                completion(.failure(NetworkingError.failParseJSON))
            }
        }.resume()
    }
    
    //MARK: - Private -
    private func parseJson<T: Codable>(_ data: Data, expacting: T.Type) -> T? {
        let decoder = JSONDecoder()
        do {
            let decodateData = try decoder.decode(expacting, from: data)
            return decodateData
        } catch {
            return nil
        }
    }
    
    private enum NetworkingError: Error {
        case failedResponseJSON
        case failedParseJSON
    }
    
}
