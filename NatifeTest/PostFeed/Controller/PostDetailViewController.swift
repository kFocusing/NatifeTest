//
//  PostDetailViewController.swift
//  NatifeTest
//
//  Created by Danylo Klymov on 30.01.2022.
//

import UIKit

class PostDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    
    var id: Int!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDetailData()
    }
    
   
    private func getDetailData() {
        let urlString = "https://raw.githubusercontent.com/aShaforostov/jsons/master/api/posts/\(String(id)).json"
        guard let url = URL(string: urlString) else { return }
        NetworkService.shared.getDataID(url: url) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let detail):
                self.updateDetail(detail: detail)
            }
        }
    }
    
    private func updateDetail(detail: DetailPostData) {
        DispatchQueue.main.async {
            self.titleLabel.text = detail.title
            self.textView.text = detail.text
//            self.image = UIImag
            self.dateLabel.text = detail.timeshamp.timeshampToDateString()
        }
    }
}
