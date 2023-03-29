//
//  FeedViewController.swift
//  BeReal.
//
//  Created by Aaron Jacob on 3/28/23.
//

import UIKit
import PhotosUI

class FeedViewController: UIViewController, UITableViewDataSource {
    var posts: [Post]? {
        didSet {
            FeedTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // print("nRIS")
        // print(posts)
        guard let rowCount = posts?.count else {
            return 0
        }
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = FeedTableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell else {
            return UITableViewCell()
        }
        cell.configure(with: posts?[indexPath.row])
        return cell
    }
    
    @IBOutlet weak var FeedTableView: UITableView!
    
    @IBAction func didTapProfileBarButtonItem(_ sender: Any) {
        User.logout { [weak self] result in
            switch result {
            case .success(let user):
                
                print("✅ Successfully logged out user \(user)")
                
                // Post a notification that the user has successfully logged out.
                NotificationCenter.default.post(name: Notification.Name("logout"), object: nil)
                
            case .failure(let error):
                // Failed logout
                self?.showLogOutErrorAlert(description: error.localizedDescription)
            }
        }
    }
    
    private func queryPosts() {
        let query = Post.query()
            .include("user")
            .order([.descending("createdAt")])

        // Fetch objects (posts) defined in query (async)
        query.find { [weak self] result in
            switch result {
            case .success(let posts):
                // Update local posts property with fetched posts
                self?.posts = posts
                // print(self?.posts)
            case .failure(let error):
                self?.showFeedErrorAlert(description: error.localizedDescription)
            }
        }
    }
    
    private func showLogOutErrorAlert(description: String?) {
        let alertController = UIAlertController(title: "Unable to Log Out", message: description ?? "Unknown error", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    private func showFeedErrorAlert(description: String?) {
        let alertController = UIAlertController(title: "Unable to Load Feed", message: description ?? "Unknown error", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        FeedTableView.dataSource = self
        FeedTableView.allowsSelection = false
        FeedTableView.rowHeight = UITableView.automaticDimension
        
        queryPosts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        queryPosts()
        FeedTableView.reloadData()
    }
}
