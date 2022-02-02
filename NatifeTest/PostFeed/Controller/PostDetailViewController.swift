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
    @IBOutlet private weak var placeholderView: UIView!
    @IBOutlet private weak var heartImage: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - UIElements -
    private lazy var imageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - Variables -
    var id: Int!
    
    //MARK: - Private Variables -
    private var imagesString = [String]()
    
    //MARK: Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        startActivityIndicator()
        addStackView()
        addStackViewConstraints()
        getDetailData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)
    }
    
    //MARK: - Private -
    private func startActivityIndicator() {
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
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
            self.renderImages()
            self.heartImage.isHidden = false
            self.activityIndicator.stopAnimating()
        }
    }
    
    private func addStackView() {
        placeholderView.addSubview(imageStackView)
    }
    
    private func addStackViewConstraints() {
        NSLayoutConstraint.activate([imageStackView.topAnchor.constraint(equalTo: placeholderView.topAnchor),
                                     imageStackView.bottomAnchor.constraint(equalTo: placeholderView.bottomAnchor),
                                     imageStackView.leftAnchor.constraint(equalTo: placeholderView.leftAnchor),
                                     imageStackView.rightAnchor.constraint(equalTo: placeholderView.rightAnchor)])
    }
    
    private func addImageViewConstraints(imageView: UIImageView) {
          NSLayoutConstraint.activate([imageView.heightAnchor.constraint(equalToConstant: 200)])
    }
    
    private func renderImages() {
        for path in imagesString {
            guard let url = URL(string: path),
                  let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else { return }
            let imageView = UIImageView(image: image)
            addImageViewConstraints(imageView: imageView)
            imageStackView.addArrangedSubview(imageView)
        }
    }
}
