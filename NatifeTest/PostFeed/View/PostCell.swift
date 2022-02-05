//
//  PostCell.swift
//  NatifeTest
//
//  Created by Danylo Klymov on 29.01.2022.
//

import UIKit

//MARK: - Protocol -
protocol SizeCellDelegate: AnyObject {
    func readMoreTapped()
    func updateIsExpended(withID id: Int)
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
    private var post: PostModel?
    private var id = Int()
    
    //MARK: - IBAction -
    @IBAction func readMorePressed(_ sender: Any) {
        guard var post = self.post, let delegate = delegate  else { return }
        if post.isExpended {
            post.isExpended = !post.isExpended
            previewTextLabel.numberOfLines = 2
            readMoreButton.setTitle("Читать далее...", for: .normal)
            delegate.updateIsExpended(withID: post.postID)
        } else {
            post.isExpended = !post.isExpended
            previewTextLabel.numberOfLines = 0
            readMoreButton.setTitle("Свернуть текст", for: .normal)
            delegate.updateIsExpended(withID: post.postID)
        }
        updateLayout()
        self.post = post
    }
    
    //MARK: - Internal -
    func configure(with post: PostModel) {
        self.post = post
        titleLabel.text = post.title
        previewTextLabel.text = post.previewText
        likesCountLabel.text = String(post.likesCount)
        dateLabel.text = post.timeshamp.timeshampToDateString()
        configureExpandButton()
    }
    
    //MARK: - Private -
    private func configureExpandButton() {
        guard let post = self.post else { return }
        if post.isExpended {
            previewTextLabel.numberOfLines = 0
            readMoreButton.setTitle("Свернуть текст", for: .normal)
        } else {
            previewTextLabel.numberOfLines = 2
            readMoreButton.setTitle("Читать далее...", for: .normal)
        }
        previewTextLabel.text = post.previewText
        readMoreButton.isHidden = checkNeededReadMoreButton()
    }
    
    private func checkNeededReadMoreButton() -> Bool{
        return previewTextLabel.maxNumberOfLines <= 2
    }
    
    private func updateLayout() {
        setNeedsLayout()
        layoutIfNeeded()
        delegate?.readMoreTapped()
    }
}


