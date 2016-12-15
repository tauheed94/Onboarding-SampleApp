//
//  NavController.swift
//  OnBoarding
//
//  Created by iMac on 12/15/16.
//  Copyright © 2016 codekindle. All rights reserved.
//  Copyright © 2016 Mohd Tauheed Uddin Siddiqui. All rights reserved.

import UIKit
protocol signOutDelegate : class {
    func showLogin()
}
class NavController: UINavigationController , signOutDelegate {
    
    override func viewDidLoad() {
        view.backgroundColor = .green
        
        if isLoggedIn() {
            let homeController = HomeController()
            homeController.delegate = self
            viewControllers = [homeController]
        } else{
            perform(#selector(showLogin), with: nil, afterDelay: 0.01)
        }

        
}
    fileprivate func isLoggedIn() -> Bool {
        return UserDefaults.standard.isLoggedIn()
    }
    
    
    
    func showLogin() {
        let loginController = ViewController()
        present(loginController , animated : true , completion : {
            
        })
    }
}

class HomeController: UIViewController {
    func setUpNavButtons(){
        let signOutButton = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOut))
        navigationItem.leftBarButtonItem = signOutButton
    }
    weak var delegate : signOutDelegate?
     func signOut(){
        UserDefaults.standard.setLoginIn(value: false)
        UserDefaults.standard.synchronize()
        let loginController = ViewController()
        present(loginController , animated : true , completion : {
            
        })     //   perform(#selector(delegate?.showLogin), with: nil, afterDelay: 0.01)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavButtons()
        view.backgroundColor = .red
    }
}
