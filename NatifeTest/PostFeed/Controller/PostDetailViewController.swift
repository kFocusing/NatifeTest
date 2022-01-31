//
//  PostDetailViewController.swift
//  NatifeTest
//
//  Created by Danylo Klymov on 30.01.2022.
//

import UIKit

class PostDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var picturesTableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var id: Int!
    var imagesString = [String]()
    
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
        self.imagesString = detail.images!
        DispatchQueue.main.async {
            self.titleLabel.text = detail.title
            self.textLabel.text = detail.text
            self.dateLabel.text = detail.timeshamp.timeshampToDateString()
            self.likesCountLabel.text = String(detail.likesCount)
            self.picturesTableView.frame.size.height = CGFloat(237 * self.imagesString.count)
            self.picturesTableView.reloadData()
        }
    }
}


extension PostDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesString.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pictureCell", for: indexPath) as! DetailPostCell
        guard let imgURL = URL(string: imagesString[indexPath.row]) else { return cell }
        do {
            let imgData = try Data(contentsOf: imgURL)
            cell.configure(imgData: imgData)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return cell
    }
}
