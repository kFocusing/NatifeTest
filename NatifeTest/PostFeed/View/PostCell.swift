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
    @IBOutlet private weak var readMoreButton: UIButton!
    
    //MARK: - Variable -
    weak var delegate: SizeCellDelegate?
    
    //MARK: - IBAction -
    @IBAction func readMorePressed(_ sender: Any) {
        if readMoreButton.titleLabel?.text == "Читать далее..." {
            previewTextLabel.numberOfLines = 0
            readMoreButton.setTitle("Свернуть текст", for: .normal)
        } else {
            previewTextLabel.numberOfLines = 2
            readMoreButton.setTitle("Читать далее...", for: .normal)
        }
        updateLayout()
    }
    
    //MARK: - Internal -
    func configure(with post: PostModel) {
        titleLabel.text = post.title
        previewTextLabel.text = post.previewText
        likesCountLabel.text = String(post.likesCount)
        dateLabel.text = post.timeshamp.timeshampToDateString()
        setReadMoreButton(with: post.previewText)
    }
    
    //MARK: - Private -
    private func setReadMoreButton(with string: String) {
        let frame = 6.28 * Double(string.count)
        let constFrame = previewTextLabel.frame.width * 2
        if frame > constFrame {
            previewTextLabel.numberOfLines = 2
            readMoreButton.isHidden = false
        } else {
            previewTextLabel.numberOfLines = 0
            readMoreButton.isHidden = true
            readMoreButton.frame.size = CGSize(width: 0, height: 0)
        }
        previewTextLabel.text = string
    }
    
    private func updateLayout() {
        setNeedsLayout()
        layoutIfNeeded()
        self.delegate?.didTap()
    }
}
