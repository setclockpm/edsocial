//
//  NewUploadController.swift
//  EdSocialSC
//
//  Created by Phillip M Medrano on 12/6/17.
//  Copyright © 2017 Relativity Labs. All rights reserved.
//

import UIKit
import FirebaseDatabase

class NewPostController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
    }
    
    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}






