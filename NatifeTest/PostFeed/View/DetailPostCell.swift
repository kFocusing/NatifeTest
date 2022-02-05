//
//  DetailPostCell.swift
//  NatifeTest
//
//  Created by Danylo Klymov on 31.01.2022.
//

import UIKit

class DetailPostCell: UITableViewCell {
    //MARK: - IBOutlet -
    @IBOutlet private weak var imageIntoStackView: UIImageView!
    
    //MARK: - Internal -
    func configure (imageData: Data) {
        imageIntoStackView.image = UIImage(data: imageData)
    }
}
