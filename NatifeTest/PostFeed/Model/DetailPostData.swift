//
//  DetailPostData.swift
//  NatifeTest
//
//  Created by Danylo Klymov on 31.01.2022.
//

import Foundation
// MARK: - RequestDetailPostData -
struct RequestDetailPostData: Codable {
    let post: DetailPostData
}

// MARK: - DetailPostData -
struct DetailPostData: Codable {
    let postID, timeshamp: Int
    let title, text: String
    let images: [String]?
    let likesCount: Int

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case timeshamp, title, text, images
        case likesCount = "likes_count"
    }
}
