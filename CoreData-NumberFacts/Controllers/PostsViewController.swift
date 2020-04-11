//
//  ViewController.swift
//  CoreData-NumberFacts
//
//  Created by Kelby Mittan on 4/8/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private var posts = [Post]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        getPost()
    }
    
    private func getPost() {
        posts = CoreDataManager.shared.fetchPosts()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createPostSegue" {
            guard let createPostVC = segue.destination as? CreatePostController else {
                fatalError("could not segue")
            }
            createPostVC.delegate = self
        }
    }
    
    

}

extension PostsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        
        let post = posts[indexPath.row]
        
        cell.textLabel?.text = "\(post.title ?? "") \(post.number.description)"
        cell.detailTextLabel?.text = "Posted by: \(post.user?.name ?? "")"
        
        return cell
        
    }
    
    
}

extension PostsViewController: CreatePostDelegate {
    
    func didCreatePost(_ createPostViewController: CreatePostController, post: Post) {
        posts.append(post)
    }
    
}
