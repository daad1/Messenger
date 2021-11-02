//
//  ViewController.swift
//  Messenger
//
//  Created by administrator on 30/10/2021.
//
import UIKit
import FirebaseCore
import FacebookCore
import FacebookLogin

import FirebaseAuth
class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
        
        if !isLoggedIn {
                   // present login view controller
                   
                   let vc = LoginViewController()
                   let nav = UINavigationController(rootViewController: vc)
                   nav.modalPresentationStyle = .fullScreen
                   present(nav, animated: false)
               }
  

}
}

