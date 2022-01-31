//
//  PostFeedViewController.swift
//  NatifeTest
//
//  Created by Danylo Klymov on 29.01.2022.
//

import UIKit

class PostFeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var posts = [PostData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPosts()
    }
    
    @IBAction func sortPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Choose type of sorting", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Default", style: .default, handler: {_ in
            self.getPosts() }))
        alert.addAction(UIAlertAction(title: "Date", style: .default, handler: {_ in
            self.posts = self.posts.sorted(by: { $0.timeshamp > $1.timeshamp })
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Rating", style: .default, handler: { _ in
            self.posts = self.posts.sorted(by: { $0.likesCount > $1.likesCount })
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    private func getPosts() {
        let urlString = "https://raw.githubusercontent.com/aShaforostov/jsons/master/api/main.json"
        guard let url = URL(string: urlString) else { return }
        NetworkService.shared.getData(url: url) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let posts):
                self.updatePosts(posts: posts)
            }
        }
    }
    
    private func updatePosts(posts: [PostData]) {
        DispatchQueue.main.async {
            self.posts = posts
            self.tableView.reloadData()
        }
    }
}

extension PostFeedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        cell.configure(with: post)
        return cell
    }
}
