//
//  PostCell.swift
//  NatifeTest
//
//  Created by Danylo Klymov on 29.01.2022.
//

import UIKit
import ReadMoreTextView

class PostCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var textView: ReadMoreTextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    func configure(with post: PostData) {
//        textView.translatesAutoresizingMaskIntoConstraints = true
        titleLabel.text = post.title
        textView.text = post.previewText
        likesCountLabel.text = String(post.likesCount)
        dateLabel.text = post.timeshamp.timeshampToDateString()
        setupReadMore()
        
    }
    
    func setupReadMore() {
        textView.shouldTrim = true
        textView.maximumNumberOfLines = 2
        textView.attributedReadMoreText = NSAttributedString(string: "... Read more")
        textView.attributedReadLessText = NSAttributedString(string: " Read less")
    }
}

