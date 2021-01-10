//
//  MyCoin.swift
//  LifeCycle
//
//  Created by HanaHan on 2021/01/10.
//

import Foundation

class MyCoin {
    static var shared = MyCoin()
    
    func getMyCoinFromUserDefault() -> [String]? {
        let coin : [String]? = UserDefaults.standard.object(forKey: "myCoin") as? [String]
        return coin
    }

    func setMyCoinToUserDefault(data : [String] ) {
        UserDefaults.standard.set(data, forKey: "myCoin")
        UserDefaults.standard.synchronize()
    }
}
