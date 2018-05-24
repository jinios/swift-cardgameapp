//
//  AppDelegate.swift
//  CardGameApp
//
//  Created by YOUTH2 on 2018. 4. 12..
//  Copyright © 2018년 JINiOS. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let mainViewController = self.window?.rootViewController as! ViewController
        mainViewController.cardGameDelegate = CardGameManager.shared()
        NotificationCenter.default.addObserver(self, selector: #selector(restart), name: .deviceShaked, object: nil)
        return true
    }

    @objc func restart() {
        let mainViewController = self.window?.rootViewController as! ViewController
        mainViewController.cardGameDelegate = CardGameManager.restartSharedDeck()
    }

}

