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
    
    func configure(with post: PostData) {
        self.titleLabel.text = post.title
        self.previewTextLabel.text = post.previewText
        self.likesCountLabel.text = String(post.likesCount)
        self.dateLabel.text = timeshampToDateString(timeshamp: post.timeshamp)
    }
    
    fileprivate func timeshampToDateString(timeshamp: Int) -> String {
        
        let date = Date(timeIntervalSince1970: Double(timeshamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+2")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm  MM/dd/yyyy"
        let strDate = dateFormatter.string(from: date)
        
        return strDate
    }
}

