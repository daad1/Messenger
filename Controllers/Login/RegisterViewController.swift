//
//  CreateAccountViewController.swift
//  Messenger
//
//  Created by administrator on 30/10/2021.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var selectPhoto: UIButton!
    @IBOutlet weak var takePhoto: UIImageView!
    
    @IBOutlet weak var signUplbl: UILabel!
    
    @IBOutlet weak var namefield: UITextField!
    
    @IBOutlet weak var emailtextfield: UITextField!
    
    @IBOutlet weak var passwordtextfield: UITextField!
    
    @IBOutlet weak var createAccount: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Make Photo Circle
        takePhoto.layer.borderWidth = 1
        takePhoto.layer.masksToBounds = false
        takePhoto.layer.cornerRadius = takePhoto.frame.height / 2
        takePhoto.clipsToBounds = true
        
        
        emailtextfield.delegate = self
        passwordtextfield.delegate = self
        
        // Password Hiding
        passwordtextfield.isSecureTextEntry = true
        
    }
    
    
    
    
    @IBAction func selectPhotoAction(_ sender: UIButton) {
        showPhoto()
        
    }
    // option photo
    func showPhoto(){
        let alert = UIAlertController(title: "Take Photo Frome:", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {action
            in
            self.getPhoto(type: .camera)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler:
                                        {action in
            self.getPhoto(type: .photoLibrary)
            
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    func getPhoto(type : UIImagePickerController.SourceType){
        let picker = UIImagePickerController()
        picker.sourceType = type
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            print("image not found")
            return
            
        }
        takePhoto.image = image
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Button Create Account
    
    @IBAction func createAccountAction(_ sender: UIButton) {
        namefield.resignFirstResponder()
        emailtextfield.resignFirstResponder()
        passwordtextfield.resignFirstResponder()
        // If name , email and pawword empty show message to fill it
        guard let name = namefield.text ,
              let email = emailtextfield.text,
              let password = passwordtextfield.text,
              !name.isEmpty,
              !email.isEmpty ,
              !password.isEmpty, password.count >= 6 else{
                  let alert = UIAlertController(title: "Woops",
                                                message: "Please Enter All Information To Create a New Account ",
                                                preferredStyle: .alert)
                  alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                  present(alert, animated: true)
                  
                  return
              }
        // firebase Register
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { authResult , error   in
            guard let result = authResult , error == nil  else {
                print("Error cureating user")
                return
            }
            let user = result.user
            print("Create User: \(user)")
            
            
        })
    }
   
}


extension  RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailtextfield {
            passwordtextfield.becomeFirstResponder()
        }
        else if textField == passwordtextfield {
            print("Done")
        }
        return true
    }
    
}



