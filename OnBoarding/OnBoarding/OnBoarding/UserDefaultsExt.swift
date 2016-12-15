//
//  UserDefaultsExt.swift
//  OnBoarding
//
//  Created by iMac on 12/15/16.
//  Copyright © 2016 codekindle. All rights reserved.
//  Copyright © 2016 Mohd Tauheed Uddin Siddiqui. All rights reserved.

import Foundation
extension UserDefaults {
    enum UserdefaultKeys : String {
        case isLoggedIn
    }
    func setLoginIn(value: Bool){
        set(value, forKey: UserdefaultKeys.isLoggedIn.rawValue)
        synchronize()
    }
    func isLoggedIn() -> Bool {
       return bool(forKey: UserdefaultKeys.isLoggedIn.rawValue)
    }
}
