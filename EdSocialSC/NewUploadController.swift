//
//  NewUploadController.swift
//  EdSocialSC
//
//  Created by Phillip M Medrano on 12/6/17.
//  Copyright © 2017 Relativity Labs. All rights reserved.
//

import UIKit
import FirebaseDatabase

class NewUploadController: UITableViewController {
    
    let cellID = "cellID"
    var users = [EndUser]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        tableView.register(UserCell.self, forCellReuseIdentifier: cellID)
        fetchUser()
    }
    
    func fetchUser() {
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: Any] {
                let user = EndUser()
                
                // If this setter is used without surrounding DispatchQueue block, 
                // app will crash if class properties don't exactly match
                // up with the Firebase keys.
                // ---> user.setValuesForKeys(dictionary)
                
                user.name = dictionary["name"] as? String
                user.email = dictionary["email"] as? String
                self.users.append(user)
                // This will crash because of background data, use dispatch_async to fix
                // self.tableView.reloadData()

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }, withCancel: nil)
    }
    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cells need to be dequeued for memory efficiency so following statement ...
        // -> let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID)
        // ... would be a temporary hack ^

        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let user = users[indexPath.row]
        
        cell.detailTextLabel?.text = user.email
        cell.textLabel?.text = user.name
        return cell
    }

}






class UserCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

