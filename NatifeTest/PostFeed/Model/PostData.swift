//
//  PreviewPost.swift
//  NatifeTest
//
//  Created by Danylo Klymov on 29.01.2022.
//

import Foundation

// MARK: - PostData -
struct PostData: Codable {
    let posts: [PostModel]
}

// MARK: - PostModel -
struct PostModel: Codable {
    let postID, timeshamp: Int
    let title, previewText: String
    let likesCount: Int

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case timeshamp, title
        case previewText = "preview_text"
        case likesCount = "likes_count"
    }
}
