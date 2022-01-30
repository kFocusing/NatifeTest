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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "postDetailSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                if let postDetailVC = segue.destination as? PostDetailViewController {
                    postDetailVC.id = posts[indexPath.row].postID
                }
            }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "postDetailSegue", sender: nil)
    }
}
