//
//  ViewController.swift
//  EdSocialSC
//
//  Created by Phillip M Medrano on 12/2/17.
//  Copyright © 2017 Relativity Labs. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class UploadsController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        let image = UIImage(named: "new-post-icon")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleNewUpload))
        checkUserIsLoggedIn()
        
        
    }
    
    func handleNewUpload() {
        let newUploadController = NewUploadController()
        let navController = UINavigationController(rootViewController: newUploadController)
        present(navController, animated: true, completion: nil)
    }
    
    func checkUserIsLoggedIn() {
        // User isn't logged in
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String: Any] {
                    self.navigationItem.title = dictionary["name"] as? String
                }
            }, withCancel: nil)
        }

    }
    
    func handleLogout() {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }
    
}

