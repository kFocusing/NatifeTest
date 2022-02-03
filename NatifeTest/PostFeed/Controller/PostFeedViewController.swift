//
//  PostFeedViewController.swift
//  NatifeTest
//
//  Created by Danylo Klymov on 29.01.2022.
//

import UIKit

class PostFeedViewController: UIViewController {
    //MARK: - IBOutlet -
    @IBOutlet private weak var tableView: UITableView!
    
    //MARK: - Variable -
    var posts = [PostModel]()
    
    //MARK: - Life Cicle -
    override func viewDidLoad() {
        super.viewDidLoad()
        getPosts()
    }
    
    //MARK: - IBAction -
    @IBAction private func sortButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Choose type of sorting",
                                      message: nil,
                                      preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Default",
                                              style: .default,
                                              handler: {_ in self.getPosts() }))
                alert.addAction(UIAlertAction(title: "Date",
                                              style: .default,
                                              handler: {_ in
                    self.posts = self.posts.sorted(by: { $0.timeshamp > $1.timeshamp })
                    self.tableView.reloadData()
                }))
                alert.addAction(UIAlertAction(title: "Rating",
                                              style: .default,
                                              handler: { _ in
                    self.posts = self.posts.sorted(by: { $0.likesCount > $1.likesCount })
                    self.tableView.reloadData()
                }))
                alert.addAction(UIAlertAction(title: "Cancel",
                                              style: .cancel,
                                              handler: nil))
                
                self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Iternal -
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "postDetailSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                if let postDetailVC = segue.destination as? PostDetailViewController {
                    postDetailVC.id = posts[indexPath.row].postID
                }
            }
        }
    }
    
    //MARK: - Private -
    private func getPosts() {
        let urlString = "https://raw.githubusercontent.com/aShaforostov/jsons/master/api/main.json"
        guard let url = URL(string: urlString) else { return }
        NetworkService.shared.getData(url: url, expacting: PostData.self) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let posts):
                self.updatePosts(posts: posts.posts)
            }
        }
    }
    
    private func updatePosts(posts: [PostModel]) {
        DispatchQueue.main.async {
            self.posts = posts
            self.tableView.reloadData()
        }
    }
}

//MARK: - Extensions -
//MARK: - UITableViewDataSource -
extension PostFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        cell.configure(with: post)
        cell.delegate = self
        return cell
    }
}

//MARK: - UITableViewDelegate -
extension PostFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "postDetailSegue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - SizeCellDelegate -
extension PostFeedViewController: SizeCellDelegate {
    func didTap() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}
