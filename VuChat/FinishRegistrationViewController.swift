//
//  FinishRegistrationViewController.swift
//  VuChat
//
//  Created by Vu Duong on 11/12/18.
//  Copyright © 2018 Vu Duong. All rights reserved.
//

import UIKit
import ProgressHUD

class FinishRegistrationViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    var email : String!
    var password : String!
    var avatarImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(email, password)

        
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        cleanTextfield()
        dismissKeyboard()
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        
        dismissKeyboard()
        ProgressHUD.show("Registering...")
        
        if nameTextField.text != "" && surnameTextField.text != "" && countryTextField.text != "" && cityTextField.text != "" && phoneTextField.text != "" {
            
            FUser.registerUserWith(email: email!, password: password!, firstName: nameTextField.text!, lastName: surnameTextField.text!) { (error) in
                
                if error != nil {
                    ProgressHUD.dismiss()
                    ProgressHUD.showError(error!.localizedDescription)
                    return
                }
                
                self.registerUser()
            }
            
        } else {
            
            ProgressHUD.showError("All fields are required!")
        }
        
    }
    
    //MARK: Helpers
    
    func registerUser() {
        
        let fullName = nameTextField.text! + " " + surnameTextField.text!
        
        var tempDictionary : Dictionary = [kFIRSTNAME : nameTextField.text!, kLASTNAME : surnameTextField.text!, kFULLNAME : fullName, kCOUNTRY : countryTextField.text!, kCITY : cityTextField.text!, kPHONE : phoneTextField.text!] as [String : Any]
        
        if avatarImage != nil {
            
            imageFromInitials(firstName: nameTextField.text!, lastName: surnameTextField.text!) { (avatarInitials) in
                
                let avatarIMG = avatarInitials.jpegData(compressionQuality: 0.7)
                let avatar = avatarIMG!.base64EncodedData(options: NSData.Base64EncodingOptions(rawValue: 0))
                
                tempDictionary[kAVATAR] = avatar
                
                //finishRegistration
            }
            
        } else {
            
            let avatarData = avatarImage?.jpegData(compressionQuality: 0.7)
            let avatar = avatarData!.base64EncodedData(options: NSData.Base64EncodingOptions(rawValue: 0))
            
            tempDictionary[kAVATAR] = avatar
            
            //finishRegistration
            

        }
        
    }
    
    func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    func cleanTextfield() {
        nameTextField.text = ""
        surnameTextField.text = ""
        countryTextField.text = ""
        cityTextField.text = ""
        phoneTextField.text = ""
    }

}
