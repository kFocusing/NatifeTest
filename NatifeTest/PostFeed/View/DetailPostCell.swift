//
//  DetailPostCell.swift
//  NatifeTest
//
//  Created by Danylo Klymov on 31.01.2022.
//

import UIKit

class DetailPostCell: UITableViewCell {

    @IBOutlet weak var imageInto: UIImageView!
    
    func configure (imgData: Data) {
        self.imageInto.image = UIImage(data: imgData)
    }
}
