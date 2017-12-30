//
//  NewUploadController.swift
//  EdSocialSC
//
//  Created by Phillip M Medrano on 12/6/17.
//  Copyright © 2017 Relativity Labs. All rights reserved.
//

import UIKit
import FirebaseDatabase

class NewPostController: UIViewController {
    
    var postsController: PostsController?
    
    
    lazy var uploadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "no-photo-selected")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                              action: #selector(handleSelectImageView)))
        
        return imageView
    }()
    
    let addCaptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Caption Below"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.white
        label.frame = CGRect(x:0,y:0,width:label.intrinsicContentSize.width,height:label.intrinsicContentSize.width)
        return label
    }()
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var uploadButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 80, g: 101, b: 161)
        button.setTitle("Upload Photo", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(handleNewPost), for: .touchUpInside)
        return button
    }()
    
    let captionTextField: UITextView = {
        let tf = UITextView()
        tf.autocorrectionType = .default
        tf.autocapitalizationType = .sentences
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        view.addSubview(uploadImageView)
        view.addSubview(addCaptionLabel)
        view.addSubview(inputsContainerView)
        view.addSubview(uploadButton)

        setupInputsContainerView()
        setupUploadImageView()
        setupEnterCaptionLabel()
        setupUploadButton()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.title = "Create New Image Post"
    }
    
    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    // SETUPS
    
    var inputsContainerViewHeightAnchor: NSLayoutConstraint?
    var captionTextFieldHeightAnchor: NSLayoutConstraint?

    
    func setupUploadImageView() {
        // need x,y,w,h constraints
        uploadImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        uploadImageView.bottomAnchor.constraint(equalTo: addCaptionLabel.topAnchor, constant: -18).isActive = true
        uploadImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        uploadImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func setupEnterCaptionLabel() {
        // need x,y,w,h constraints
        addCaptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addCaptionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        addCaptionLabel.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -6).isActive = true
        addCaptionLabel.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        addCaptionLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    func setupInputsContainerView() {
        //need x,y,w,h constraints
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerView.topAnchor.constraint(equalTo: addCaptionLabel.bottomAnchor, constant: 8).isActive = true

        
        inputsContainerViewHeightAnchor = inputsContainerView.heightAnchor.constraint(equalToConstant: 100)
        inputsContainerViewHeightAnchor?.isActive = true
        
        inputsContainerView.addSubview(captionTextField)
        
        
        //need x,y,w,h constraints
        captionTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        captionTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        captionTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        
        captionTextFieldHeightAnchor = captionTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1)
        captionTextFieldHeightAnchor?.isActive = true
    }
    
    func setupUploadButton() {
        //need x,y,w,h constraints
        uploadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        uploadButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        uploadButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        uploadButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }


}






