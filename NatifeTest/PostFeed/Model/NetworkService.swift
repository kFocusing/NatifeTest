//
//  NetworkService.swift
//  NatifeTest
//
//  Created by Danylo Klymov on 29.01.2022.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    
    public func getData(url: URL, completion: @escaping (Result<[PostData], Error>) -> Void) {
        let session = URLSession.shared
        session.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {
                completion(.failure(NetworkingError.failResponseJSON))
                return
            }
            let post = self.parseJson(data)
            completion(.success(post))
        }.resume()
    }
    
    
    private func parseJson(_ data: Data) -> [PostData] {
        let decoder = JSONDecoder()
        do {
            let decodateData = try decoder.decode(PostModel.self, from: data)
            return decodateData.posts
        } catch {
            return []
        }
    }
    
    private enum NetworkingError: Error {
        case failResponseJSON
        case failParseJSON
    }
    
}
