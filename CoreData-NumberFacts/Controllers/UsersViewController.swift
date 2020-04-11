//
//  UsersViewController.swift
//  CoreData-NumberFacts
//
//  Created by Kelby Mittan on 4/8/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    private var users = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        getUsers()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func getUsers() {
        users = CoreDataManager.shared.fetchUsers()
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createUserSegue" {
            guard let createUserVC = segue.destination as? CreateUserController else {
                fatalError("could not segue")
            }
            createUserVC.delegate = self
        }
    }
}

extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.name
        return cell
    }
    
    
}

extension UsersViewController: UITableViewDelegate {
    
}

extension UsersViewController: CreateUserDelegate {
    
    func didCreateUser(_ createUserViewController: CreateUserController, user: User) {
        users.append(user)
    }
    
    
}
