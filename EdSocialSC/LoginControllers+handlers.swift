//
//  LoginControllers+handlers.swift
//  EdSocialSC
//
//  Created by Phillip M Medrano on 12/18/17.
//  Copyright © 2017 Relativity Labs. All rights reserved.
//

import UIKit
import Firebase

extension LoginController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func handleRegister() {
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text
        else {
            print("Form is not valid.")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user: User?, error) in
            if error != nil {
                print(error!)
            }
            guard let uid = user?.uid else {
                return
            }
            
            
            
            // Successfully Authenticated User
            // ----------------------------------------------------------------------------------------
            
            
            // Storing photo on Firebase
            let imageName = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child("social_media_images").child("\(imageName).jpg")
            
            if let profileImage = self.profileImageView.image, let uploadData = UIImageJPEGRepresentation(profileImage, 0.1) {
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    
                    if error != nil {
                        print(error!)
                        return
                    }
                    
                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                        let values = ["name": name, "email": email, "profileImageUrl": profileImageUrl]
                        self.registerUserIntoDatabaseWithUID(uid: uid, values: values)

                    }
                })
            }
            
        })
        
    }

    
    private func registerUserIntoDatabaseWithUID(uid: String, values: [String: Any]) {
        
        var ref: DatabaseReference!
        ref = Database.database().reference(fromURL: "https://presidiosc-edsocial.firebaseio.com/")
        let usersReference = ref.child("users").child(uid)
        
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                print(err!)
                return
            }
            
            self.postsController?.navigationItem.title = values["name"] as? String
            self.dismiss(animated: true, completion: nil)
            print(("Saved user successfully into Firebase DB"))
        })
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            profileImageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled photo selection")
        dismiss(animated: true, completion: nil)
    }
}
