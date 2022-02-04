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
    var postID: Int
    let timeshamp: Int
    let title: String
    let previewText: String
    let likesCount: Int
    var isExpended: Bool = false

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case timeshamp, title
        case previewText = "preview_text"
        case likesCount = "likes_count"
    }
}
