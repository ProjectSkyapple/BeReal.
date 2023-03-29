//
//  AuthenticationViewController.swift
//  BeReal.
//
//  Created by Aaron Jacob on 3/28/23.
//

import UIKit
import ParseSwift

class AuthenticationViewController: UIViewController {
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var LogInButton: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    
    @IBAction func didTapSignUpButton(_ sender: Any) {
        // Check that the text field values are non-nil
        guard let name = NameTextField.text, let password = PasswordTextField.text, !name.isEmpty, !password.isEmpty else {
            self.showSignUpErrorAlert(description: "Enter your name and create a password for your account.")
            return
        }
        
        // Create a new user
        var newUser = User()
        newUser.username = name
        newUser.password = password
        
        newUser.signup { [weak self] result in
            switch result {
            case .success(let user):
                
                print("✅ Successfully signed up user \(user.username!)")
                
                // Post a notification that the user has successfully signed up.
                NotificationCenter.default.post(name: Notification.Name("login"), object: nil)
                
            case .failure(let error):
                // Failed sign up
                self?.showSignUpErrorAlert(description: error.localizedDescription)
            }
        }
    }
    
    @IBAction func didTapLogInButton(_ sender: Any) {
        // Check that the text field values are non-nil
        guard let name = NameTextField.text, let password = PasswordTextField.text, !name.isEmpty, !password.isEmpty else {
            self.showLogInErrorAlert(description: "Check that you have entered your name and password.")
            return
        }
        
        // Log in
        User.login(username: name, password: password) { [weak self] result in
            switch result {
            case .success(let user):
                print("✅ Successfully logged in as user: \(user.username!)")
                
                // Post a notification that the user has successfully logged in.
                NotificationCenter.default.post(name: Notification.Name("login"), object: nil)
                
            case .failure(let error):
                self?.showLogInErrorAlert(description: error.localizedDescription)
            }
        }
    }
    
    private func showSignUpErrorAlert(description: String?) {
        let alertController = UIAlertController(title: "Unable to Sign Up", message: description ?? "Unknown error", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    private func showLogInErrorAlert(description: String?) {
        let alertController = UIAlertController(title: "Unable to Log In", message: description ?? "Unknown error", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}
