//
//  NetworkService.swift
//  NatifeTest
//
//  Created by Danylo Klymov on 29.01.2022.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    
    public func getData(url: URL, completion: @escaping (Result<[PostModel], Error>) -> Void) {
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
    
    
    private func parseJson(_ data: Data) -> [PostModel] {
        let decoder = JSONDecoder()
        do {
            let decodateData = try decoder.decode(PostData.self, from: data)
            return decodateData.posts
        } catch {
            return []
        }
    }
    
    
    // id
    public func getDataID(url: URL, completion: @escaping (Result<DetailPostData, Error>) -> Void) {
        let session = URLSession.shared
        session.dataTask(with: url) { (data, _, error) in
            guard let data = data, error == nil else {
                completion(.failure(NetworkingError.failResponseJSON))
                return
            }
            if let post = self.parseJsonID(data) {
                completion(.success(post))
            } else {
                completion(.failure(NetworkingError.failParseJSON))
            }
        }.resume()
    }
    
    
    private func parseJsonID(_ data: Data) -> DetailPostData? {
        let decoder = JSONDecoder()
        do {
            let decodateData = try decoder.decode(RequestDetailPostData.self, from: data)
            return decodateData.post
        } catch {
            return nil
        }
    }
    
    private enum NetworkingError: Error {
        case failResponseJSON
        case failParseJSON
    }
    
}
