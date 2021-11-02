//
//  LoginViewController.swift
//  Messenger
//
//  Created by administrator on 02/11/2021.
//

import UIKit
import FirebaseAuth
class LoginViewController: UIViewController {
    
    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var stackView: UIStackView!
    
    
    @IBOutlet weak var signInlbl: UILabel!
    
    @IBOutlet weak var emailfield: UITextField!
    
    @IBOutlet weak var passwordfield: UITextField!
    
    
    @IBOutlet weak var loginbtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        emailfield.delegate = self
        passwordfield.delegate = self
    
        passwordfield.isSecureTextEntry = true
        
    }
    // Button Log In
    @IBAction func logInAccountAction(_ sender: UIButton) {
        
        emailfield.resignFirstResponder()
        passwordfield.resignFirstResponder()
        // If email and pawword empty show message to fill it
        guard let email = emailfield.text ,
              let password = passwordfield.text,
              !email.isEmpty ,
              !password.isEmpty, password.count >= 6 else{
                  let alert = UIAlertController(title: "Woops",
                                                message: "Please Enter All Information To Log In ",
                                                preferredStyle: .alert)
                  alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                  present(alert, animated: true)
                  
                  return
              }
        //firebase Log in
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { authResult , error   in
            guard let result = authResult , error == nil  else {
                print("Faild to log in usder with email: \(email)")
                return
            }
            let user = result.user
            print("Loged In User: \(user)")
            
            
            
        })
    }
    // size of the Logo
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Logo
        let size = view.width/2
        logo.frame = CGRect(x:(view.width - size) / 2 ,
                            y: 40,
                            width: size,
                            height: size)
        
        
        
    }
    
}
extension  LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailfield {
            passwordfield.becomeFirstResponder()
        }
        else if textField == passwordfield {
            print("Done")
        }
        return true
    }
    
}
