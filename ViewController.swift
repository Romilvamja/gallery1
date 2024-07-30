//
//  ViewController.swift
//  PasscodeLock
//
//  Created by macOS on 22/07/24.
//  Copyright © 2024 Oleg Ryasnoy. All rights reserved.
//

import UIKit

class ViewControllerr: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a UIButton for creating new password
        let createButton = UIButton(frame: CGRect(x: 50, y: 100, width: 200, height: 50))
        createButton.setTitle("Create Password", for: .normal)
        createButton.setTitleColor(.blue, for: .normal)
        createButton.addTarget(self, action: #selector(createPassword), for: .touchUpInside)
        view.addSubview(createButton)
        
        // Create a UIButton for changing existing password
        let changeButton = UIButton(frame: CGRect(x: 50, y: 200, width: 200, height: 50))
        changeButton.setTitle("Change Password", for: .normal)
        changeButton.setTitleColor(.blue, for: .normal)
        changeButton.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
        view.addSubview(changeButton)
    }
    
    @objc func createPassword() {
        // Function to create a new password
        let alert = UIAlertController(title: "Create Password", message: "Enter your new password", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        
        let createAction = UIAlertAction(title: "Create", style: .default) { [weak self] _ in
            if let password = alert.textFields?.first?.text {
                // Save password securely (for example, using Keychain or UserDefaults)
                UserDefaults.standard.set(password, forKey: "lockScreenPassword")
                UserDefaults.standard.synchronize()
                print("Password created successfully.")
            }
        }
        
        alert.addAction(createAction)
        present(alert, animated: true, completion: nil)
    }
    
    @objc func changePassword() {
        // Function to change existing password
        let alert = UIAlertController(title: "Change Password", message: "Enter your old and new passwords", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Old Password"
            textField.isSecureTextEntry = true
        }
        alert.addTextField { textField in
            textField.placeholder = "New Password"
            textField.isSecureTextEntry = true
        }
        
        let changeAction = UIAlertAction(title: "Change", style: .default) { [weak self] _ in
            guard let oldPassword = alert.textFields?[0].text, let newPassword = alert.textFields?[1].text else {
                return
            }
            
            let savedPassword = UserDefaults.standard.string(forKey: "lockScreenPassword") ?? ""
            
            if savedPassword == oldPassword {
                // Save new password securely (for example, using Keychain or UserDefaults)
                UserDefaults.standard.set(newPassword, forKey: "lockScreenPassword")
                UserDefaults.standard.synchronize()
                print("Password changed successfully.")
            } else {
                print("Incorrect old password.")
            }
        }
        
        alert.addAction(changeAction)
        present(alert, animated: true, completion: nil)
    }
}

