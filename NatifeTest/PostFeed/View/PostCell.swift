//
//  PostCell.swift
//  NatifeTest
//
//  Created by Danylo Klymov on 29.01.2022.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var previewTextLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func configure(with post: PostModel) {
        self.titleLabel.text = post.title
        self.previewTextLabel.text = post.previewText
        self.likesCountLabel.text = String(post.likesCount)
        self.dateLabel.text = post.timeshamp.timeshampToDateString()
    }
}

