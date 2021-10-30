//
//  CreateAccountViewController.swift
//  Messenger
//
//  Created by administrator on 30/10/2021.
//

import UIKit

class CreateAccountVC: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    @IBOutlet weak var selectPhoto: UIButton!
    @IBOutlet weak var takePhoto: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectPhotoAction(_ sender: UIButton) {
        showPhoto()
        
    }
    
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
}
