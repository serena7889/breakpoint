//
//  LoginVC.swift
//  breakpoint
//
//  Created by Serena Lambert on 01/02/2018.
//  Copyright © 2018 Serena Lambert. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    // Outlets
    @IBOutlet weak var emailTxtField: InsetTextField!
    @IBOutlet weak var passwordTxtField: InsetTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTxtField.delegate = self
        passwordTxtField.delegate = self

    }
    
    @IBAction func signInBtnPressed(_ sender: Any) {
        if emailTxtField.text != nil && passwordTxtField.text != nil {
            
            AuthService.instance.loginUser(withEmail: emailTxtField.text!, andPassword: passwordTxtField.text!, loginComplete: { (success, loginError) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print("Login error: \(String(describing: loginError?.localizedDescription))")
                }
                
                AuthService.instance.registerUser(withEmail: self.emailTxtField.text!, andPassword: self.passwordTxtField.text!, userCreationComplete: { (success, registrationError) in
                    if success {
                        AuthService.instance.loginUser(withEmail: self.emailTxtField.text!, andPassword: self.passwordTxtField.text!, loginComplete: { (success, nil) in
                            if success {
                                self.dismiss(animated: true, completion: nil)
                                print("Successfully registered user")
                            }
                        })
                    } else {
                        print("Registration error: \(String(describing: registrationError?.localizedDescription))")
                    }
                })
            })
        }
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension LoginVC: UITextFieldDelegate {
    
}
