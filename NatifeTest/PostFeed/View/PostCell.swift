//
//  PostCell.swift
//  NatifeTest
//
//  Created by Danylo Klymov on 29.01.2022.
//

import UIKit
import ExpandableLabel

class PostCell: UITableViewCell {
    //MARK: - IBOutlets -
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var previewTextLabel: ExpandableLabel!
    @IBOutlet private weak var likesCountLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    
    
    //MARK: - Internal -
    func configure(with post: PostModel) {
        self.titleLabel.text = post.title
        self.previewTextLabel.text = post.previewText
        self.likesCountLabel.text = String(post.likesCount)
        self.dateLabel.text = post.timeshamp.timeshampToDateString()
        previewTextLabel.numberOfLines = 2
        previewTextLabel.collapsed = true
        previewTextLabel.collapsedAttributedLink = NSAttributedString(string: "Read More")
        previewTextLabel.expandedAttributedLink = NSAttributedString(string: "Read Less")
        previewTextLabel.setLessLinkWith(lessLink: "Close", attributes: [NSAttributedString.Key.foregroundColor:UIColor.red], position: nil)
        previewTextLabel.ellipsis = NSAttributedString(string: "...")
    }
} 
