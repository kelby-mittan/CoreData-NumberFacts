//
//  CreatePostController.swift
//  CoreData-NumberFacts
//
//  Created by Kelby Mittan on 4/8/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

protocol CreatePostDelegate: AnyObject {
    func didCreatePost(_ createPostViewController: CreatePostController, post: Post)
}

class CreatePostController: UITableViewController {

    @IBOutlet var postTitleTextField: UITextField!
    
    @IBOutlet var numberFactTextField: UITextField!
    
    @IBOutlet var pickerView: UIPickerView!
    
    private var users = [User]()
    
    private var selectedUser: User?
    
    weak var delegate: CreatePostDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configurePickerView()
        getUsers()
        selectedUser = users.first
    }
    
    private func configurePickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    private func getUsers() {
        users = CoreDataManager.shared.fetchUsers()
    }

    @IBAction func submitButtonPressed(_ sender: UIButton) {
        
        guard let postTitle = postTitleTextField.text , !postTitle.isEmpty, let numberFactText = numberFactTextField.text, !numberFactText.isEmpty , let numberFact = Double(numberFactText) else {
            print("missing fields")
            return
        }
        
        guard let user = selectedUser else {
            print("missing user")
            return
        }
        
        let post = CoreDataManager.shared.createPost(user: user, number: numberFact, title: postTitle)
        
        delegate?.didCreatePost(self, post: post)
        
        dismiss(animated: true)
    }

}

extension CreatePostController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let user = users[row]
        return user.name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedUser = users[row]
    }
    
}

extension CreatePostController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return users.count
    }
    
    
}
