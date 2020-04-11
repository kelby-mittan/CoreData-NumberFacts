//
//  CreateUserController.swift
//  CoreData-NumberFacts
//
//  Created by Kelby Mittan on 4/8/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit


protocol CreateUserDelegate: AnyObject {
    func didCreateUser(_ createUserViewController: CreateUserController, user: User)
}

class CreateUserController: UITableViewController {

    @IBOutlet var createUserTextField: UITextField!
    
    @IBOutlet var datePicker: UIDatePicker!
    
    weak var delegate: CreateUserDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.maximumDate = Date()
    }

    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        guard let userNameText = createUserTextField.text, !userNameText.isEmpty else {
            return
        }
        
        let date = datePicker.date
        
        let user = CoreDataManager.shared.createUser(name: userNameText, dob: date)
        
        delegate?.didCreateUser(self, user: user)
        
        dismiss(animated: true)
    }
    
    
}
