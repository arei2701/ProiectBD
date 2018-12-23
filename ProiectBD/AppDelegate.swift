//
//  AppDelegate.swift
//  ProiectBD
//
//  Created by Andrei Popa on 20/12/2018.
//  Copyright © 2018 Andrei Popa. All rights reserved.
//
var currentUser: NSMutableDictionary?

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        currentUser = UserDefaults.standard.object(forKey: "currentUser") as? NSMutableDictionary
        
        // checking is the glob variable that stores current user's info is empty or not
        if currentUser?["id"] != nil {
            
            // accessing TabBar controller via Main.storyboard
            let TabBar = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainMenuVC")
            
            // assigning TabBar as RootViewController of the project
            window?.rootViewController = TabBar
        }
        
        return true
    }
    
}

