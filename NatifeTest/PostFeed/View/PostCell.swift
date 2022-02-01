//
//  PostCell.swift
//  NatifeTest
//
//  Created by Danylo Klymov on 29.01.2022.
//

import UIKit

class PostCell: UITableViewCell {
    //MARK: - IBOutlets -
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var previewTextLabel: UILabel!
    @IBOutlet private weak var likesCountLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    //MARK: - Internal -
    func configure(with post: PostModel) {
        titleLabel.text = post.title
        previewTextLabel.text = post.previewText
        likesCountLabel.text = String(post.likesCount)
        dateLabel.text = post.timeshamp.timeshampToDateString()
        addReadMore()
    }
    
    //MARK: - Private -
    private func addReadMore() {
        let readmoreFont = UIFont(name: "Helvetica-BoldOblique", size: 14.0)
        let readmoreFontColor = UIColor.black
        self.previewTextLabel.addTrailing(with: "...", moreText: "READ MORE", moreTextFont: readmoreFont!, moreTextColor: readmoreFontColor)
    }
}
