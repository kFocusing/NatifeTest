//
//  PostCell.swift
//  NatifeTest
//
//  Created by Danylo Klymov on 29.01.2022.
//

import UIKit
//MARK: - Protocol -
protocol SizeCellDelegate: AnyObject {
    func didTap()
}

class PostCell: UITableViewCell {
    //MARK: - IBOutlets -
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var previewTextLabel: UILabel!
    @IBOutlet private weak var likesCountLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    //MARK: - Variable -
    weak var delegate: SizeCellDelegate?
    
    //MARK: - Internal -
    func configure(with post: PostModel) {
        titleLabel.text = post.title
        previewTextLabel.text = post.previewText
        likesCountLabel.text = String(post.likesCount)
        dateLabel.text = post.timeshamp.timeshampToDateString()
    }
    
}
