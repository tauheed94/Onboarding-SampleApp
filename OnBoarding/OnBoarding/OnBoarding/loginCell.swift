//
//  loginCell.swift
//  OnBoarding
//
//  Created by iMac on 12/15/16.
//  Copyright © 2016 codekindle. All rights reserved.
//  Copyright © 2016 Mohd Tauheed Uddin Siddiqui. All rights reserved.

import UIKit
class loginCell  : UICollectionViewCell {
    
    let logo : UIImageView = {
        let image = UIImage(named : "logo")
        let imageView = UIImageView(image: image)
        
        return imageView
    }()
    let emailTextField : leftPannedTextField = {
        let tf = leftPannedTextField()
        tf.placeholder = "Email"
        tf.layer.borderColor = UIColor(white: 0.8 , alpha : 1).cgColor
        tf.layer.borderWidth = 1
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    let passwordTextField : leftPannedTextField = {
        let tf = leftPannedTextField()
        tf.placeholder = "Password"
        tf.layer.borderColor = UIColor(white: 0.8 , alpha : 1).cgColor
        tf.layer.borderWidth = 1
        tf.isSecureTextEntry = true
        return tf
    }()
    
    lazy var loginButton : UIButton = {
        let button = UIButton(type : .system)
        button.backgroundColor = .red
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        //button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(loggIn), for: .touchUpInside)
        return button
        
    }()
    weak var delegate : viewControllerDelegate?
    func loggIn(){
        delegate?.finishedLoggingIn()
    }
    
    
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(logo)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
       _ =  logo.anchor(centerYAnchor, left: nil, bottom: nil, right: nil, topConstant: -200, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 160, heightConstant: 160)
        logo.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        _ = emailTextField.anchor(logo.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 8, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
        
        _ = passwordTextField.anchor(emailTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
        
        _ = loginButton.anchor(passwordTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class leftPannedTextField : UITextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x+10, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
       return CGRect(x: bounds.origin.x+10, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
    
    
}




