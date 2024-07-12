//
//  ViewController.swift
//  UserOperations_with_Json
//
//  Created by Mehmet Tırpan on 12.07.2024.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    var users: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsers()
    }

    func fetchUsers() {
        NetworkManager.shared.fetchUsers { users in
            if let users = users {
                self.users = users
                print("Fetched \(users.count) users")
                for user in users {
                    print("User: \(user.name) (\(user.username))")
                }
            }
        }
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let username = usernameTextField.text, let password = passwordTextField.text else {
            return
        }

        var isLoginSuccessful = false

        for user in users {
            if user.username == username && password == user.email {
                print("Login successful for user: \(user.name)")
                isLoginSuccessful = true
                break
            }
        }

        if isLoginSuccessful {
            showAlert(title: "Login Successful", message: "Welcome, \(users.first?.name ?? "")")
        } else {
            showAlert(title: "Login Failed", message: "Invalid username or password")
        }
    }


    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
