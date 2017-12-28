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

class PostsController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        let image = UIImage(named: "new-post-icon")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(handleNewPost))
        checkUserIsLoggedIn()
        
        
    }
    
    func handleNewPost() {
        let newPostController = NewPostController()
        let navController = UINavigationController(rootViewController: newPostController)
        present(navController, animated: true, completion: nil)
    }
    
    func checkUserIsLoggedIn() {
        // User isn't logged in
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
           fetchUserAndSetupNavBarTitle()
        }

    }
    
    func fetchUserAndSetupNavBarTitle() {
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                // User is signed in. Show home screen
                guard let uid = auth.currentUser?.uid else {
                    //for some reason uid = nil
                    return
                }
                print("uid: \(uid)")
                
                Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                    if let dictionary = snapshot.value as? [String: Any] {
                        self.navigationItem.title = dictionary["name"] as? String
                    }
                }, withCancel: nil)
                
            } else {
                // No User is signed in. Show user the login screen
            }
        }
        
    }
    
    func handleLogout() {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        
        let loginController = LoginController()
        loginController.postsController = self
        present(loginController, animated: true, completion: nil)
    }
    
}

