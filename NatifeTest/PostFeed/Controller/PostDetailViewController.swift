//
//  PostDetailViewController.swift
//  NatifeTest
//
//  Created by Danylo Klymov on 30.01.2022.
//

import UIKit

class PostDetailViewController: UIViewController {
    //MARK: - IBOutlets -
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var likesCountLabel: UILabel!
    @IBOutlet private weak var picturesTableView: UITableView!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    //MARK: - Variables -
    var id: Int!
    
    //MARK: - Private Variables -
    private var imagesString = [String]()
    
    //MARK: Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetailData()
    }
    
    //MARK: - Private -
    private func getDetailData() {
        let idString = String(id)
        let urlString = "https://raw.githubusercontent.com/aShaforostov/jsons/master/api/posts/\(idString).json"
        guard let url = URL(string: urlString) else { return }
        NetworkService.shared.getData(url: url, expacting: RequestDetailPostData.self) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let detail):
                self.updateDetail(detail: detail.post)
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
            self.picturesTableView.reloadData()
        }
    }
}

//MARK: - Extensions -
//MARK: - UITableViewDataSource -
extension PostDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imagesString.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pictureCell", for: indexPath) as! DetailPostCell
        guard let imageURL = URL(string: imagesString[indexPath.row]) else { return cell }
        setImageToCell(cell, imageURL: imageURL)
        return cell
    }
    
    private func setImageToCell(_ cell: DetailPostCell, imageURL: URL) {
        do {
            let imageData = try Data(contentsOf: imageURL)
            cell.configure(imageData: imageData)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
