//
//  pageCell.swift
//  OnBoarding
//
//  Created by iMac on 12/13/16.
//  Copyright © 2016 codekindle. All rights reserved.
//  Copyright © 2016 Mohd Tauheed Uddin Siddiqui. All rights reserved.

import UIKit

class pageCell : UICollectionViewCell {
    override init(frame : CGRect){
        super.init(frame: frame)
        setupViews()
    }
    var page: page? {
        didSet {
            guard let page = page else{
                return
            }
            
            var imageName = page.imageName
            if UIDevice.current.orientation.isLandscape{
                imageName += "_landscape"
            }
            
            imageView.image = UIImage(named : imageName)
            let color = UIColor(white: 0.3, alpha: 1)
            let attributedString = NSMutableAttributedString(string: page.title, attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 18, weight: UIFontWeightMedium) , NSForegroundColorAttributeName : color])
            attributedString.append(NSAttributedString(string:"\n\n\(page.message)", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 14) , NSForegroundColorAttributeName : color]))
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let length = attributedString.string.characters.count
            attributedString.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location : 0, length: length))
                
            textView.attributedText = attributedString
        }
    }
    let separatorView : UIView = {
    let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return view
    }()
    let imageView : UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    let textView : UITextView = {
        let tv = UITextView()
        tv.contentInset = UIEdgeInsetsMake(24, 0, 0, 0)
        tv.isEditable = false
        return tv
    }()
    
    
    func setupViews(){
        addSubview(imageView)
        addSubview(textView)
        addSubview(separatorView)
        
        imageView.anchorToTop(topAnchor, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
        separatorView.anchorToTop(nil, left: leftAnchor, bottom: textView.topAnchor, right: rightAnchor)
        separatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        textView.anchorToTop(nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
