//
//  ViewController.swift
//  OnBoarding
//
//  Created by iMac on 12/13/16.
//  Copyright © 2016 codekindle. All rights reserved.
//  Copyright © 2016 Mohd Tauheed Uddin Siddiqui. All rights reserved.

import UIKit
protocol viewControllerDelegate : class {
    func finishedLoggingIn()
}
class ViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , viewControllerDelegate  {
    
    
    //Add Pages Here
    //Struct page include three parameters to be set.
    //1. Title , 2. Message to be displayed under Title , 3 . Image Name, same image with that name should be in Assests folder.
    //If you want to implement the landscape mode too Add image to be used in landscape with _landscape to it. Example : if in portrait image name is: "image" the assets should also have "image_landscape" in the assests. So the image in landscape will be used instead.
    
    let pages : [page] = {
        let firstPage = page(title: "Share a great message!", message: "Everyone you love need to listen to your message! ", imageName: "image1")
        let secondPage = page(title: "Lorem ipsum", message: "Add another great message here!  ", imageName: "image2")
        return [firstPage, secondPage]
    }()
    
    
    
    let cellId = "cellId"
    let loginCellId = "loginCellId"
    
    lazy var collectionView : UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    fileprivate func registercell(){
        collectionView.register(pageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(loginCell.self, forCellWithReuseIdentifier: loginCellId)
        
    }
    
    lazy var pageController : UIPageControl = {
       let pc = UIPageControl()
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = .black
        pc.numberOfPages = self.pages.count + 1
        return pc
    }()
    
    let skipButton : UIButton = {
        let button =  UIButton(type: .system)
        button.setTitle("Skip", for: .normal)
        button.addTarget(self, action: #selector(skip), for: .touchUpInside)
        button.tintColor = .orange
        return button
    }()
    func skip(){
        pageController.currentPage = pages.count - 1
        nextPage()
    }
    
    let nextButton : UIButton = {
        let button =  UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        button.tintColor = .orange
        return button
    }()
    
    func nextPage(){
        if pageController.currentPage == pages.count{
            return
        }
        if pageController.currentPage == pages.count - 1 {
            moveControlConstraintsOffScreen()
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        let indexPath = IndexPath(item: pageController.currentPage + 1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        pageController.currentPage += 1
    }
    
    fileprivate func moveControlConstraintsOffScreen(){
        pageControlBottomAnchor.constant = 40
        nextButtonBottomAnchor.constant = -30
        skipButtonBottomAnchor.constant = -30
    }
    
    var pageControlBottomAnchor = NSLayoutConstraint()
    var skipButtonBottomAnchor = NSLayoutConstraint()
    var nextButtonBottomAnchor = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.addSubview(pageController)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        observeKeyboardNotification()
        nextButtonBottomAnchor = nextButton.anchor(view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 60, heightConstant: 40).first!
        skipButtonBottomAnchor =  skipButton.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 20, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 60, heightConstant: 40).first!
        
        pageControlBottomAnchor  = pageController.anchor(nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 30)[1]
        collectionView.anchorToTop(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        registercell()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == pages.count {
            let logincell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath) as! loginCell
            
           logincell.delegate = self
            return logincell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! pageCell
        
        let page = pages[indexPath.item]
        cell.page = page
        
        return cell
    }
    
    func finishedLoggingIn(){
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        guard let mainNavController = rootViewController as? NavController else {
            return
        }
        mainNavController.viewControllers = [HomeController()]
        
        
        UserDefaults.standard.setLoginIn(value: true)
        UserDefaults.standard.synchronize()
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func observeKeyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: .UIKeyboardWillHide, object: nil)
    }
    func keyboardShow(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            let y : CGFloat = UIDevice.current.orientation.isLandscape ? -100 : -30
            self.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    func keyboardHide(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x/view.frame.width)
        pageController.currentPage = pageNumber
        
        if pageNumber == pages.count{
            moveControlConstraintsOffScreen()
            
        } else {
        pageControlBottomAnchor.constant = 0
        nextButtonBottomAnchor.constant = 20
        skipButtonBottomAnchor.constant = 20
        }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView.collectionViewLayout.invalidateLayout()
        
        let indexPath = IndexPath(item: pageController.currentPage, section: 0)
        DispatchQueue.main.async {
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.collectionView.reloadData()
        }
    
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.endEditing(true)
    }
    
    
  }

