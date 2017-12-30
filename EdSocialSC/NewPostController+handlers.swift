//
//  PostsController+handlers.swift
//  EdSocialSC
//
//  Created by Phillip M Medrano on 12/28/17.
//  Copyright © 2017 Relativity Labs. All rights reserved.
//

import UIKit
import Firebase

extension NewPostController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func handleSelectImageView() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    
    func handleNewPost() {
        guard let caption = captionTextField.text
            else {
                print("Form is not valid.")
                return
        }
        
        // Storing photo on Firebase
        let imageName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("social_media_images").child("\(imageName).jpg")
        
        if let uploadedImage = self.uploadImageView.image, let uploadData = UIImageJPEGRepresentation(uploadedImage, 0.1) {
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                
                if error != nil {
                    print(error!)
                    return
                }
                
                if let uploadedImageUrl = metadata?.downloadURL()?.absoluteString {
                    let values = ["caption": caption, "uploadedImageUrl": uploadedImageUrl]
                    print(values["caption"]!)
//                    self.registerPostIntoDatabaseWithUID(uid: uid, values: values)
                }
            })
        }
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            uploadImageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled photo selection")
        dismiss(animated: true, completion: nil)
    }

    
}
