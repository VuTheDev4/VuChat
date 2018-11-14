//
//  WelcomeViewController.swift
//  VuChat
//
//  Created by Vu Duong on 11/7/18.
//  Copyright © 2018 Vu Duong. All rights reserved.
//

import UIKit
import ProgressHUD

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    //MARK: IBActions
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        
        dismissKeyboard()
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            loginUser()
            
        } else {
            ProgressHUD.showError("Email and Password is missing!")
        }
        
        
    }
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        
        
        dismissKeyboard()
        
        if emailTextField.text != "" && passwordTextField.text != "" && repeatPasswordTextField.text != "" {
            
            if passwordTextField.text == repeatPasswordTextField.text {
                
                registerUser()
            } else {
                
                ProgressHUD.show("Password does not match!")
                
            }
            
            
            
        } else {
            ProgressHUD.showError("All fields are required!")
        }
    }
    
    @IBAction func backgroundTapped(_ sender: Any) {
        dismissKeyboard()
    }
    
    //MARK: HelperFunctions
    
    func loginUser() {
        
        ProgressHUD.show("Login...")
        FUser.loginUserWith(email: emailTextField.text!, password: passwordTextField.text!) { (error) in
            
            if error != nil {
               ProgressHUD.showError(error!.localizedDescription)
                return
            }
            
            self.goToApp()
        }
        
    }
    
    func registerUser() {
        
    performSegue(withIdentifier: "welcomeToFinishRegistration", sender: self)
        
        cleanTextfield()
        dismissKeyboard()
        
    }
    
    func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    func cleanTextfield() {
        emailTextField.text = ""
        passwordTextField.text = ""
        repeatPasswordTextField.text = ""
    }
    
    //MARK: GoToApp
    
    func goToApp() {
        
        ProgressHUD.dismiss()
        cleanTextfield()
        dismissKeyboard()
        
        print("Show the app")
    }
    
    //MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "welcomeToFinishRegistration" {
            let vc = segue.destination as! FinishRegistrationViewController
            vc.email = emailTextField.text!
            vc.password = passwordTextField.text!
            
            
        }
    }
}
