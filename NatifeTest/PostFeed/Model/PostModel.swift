//
//  PreviewPost.swift
//  NatifeTest
//
//  Created by Danylo Klymov on 29.01.2022.
//

import Foundation

// MARK: - Welcome
struct PostModel: Codable {
    let posts: [PostData]
}

// MARK: - Post
struct PostData: Codable {
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
