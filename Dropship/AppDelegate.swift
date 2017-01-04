//
//  AppDelegate.swift
//  Dropship
//
//  Created by dev1 on 12/7/16.
//  Copyright © 2016 North Forge. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
    private let navController = UINavigationController()
    private let startupController = CombatController()

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        navController.setViewControllers([startupController], animated: false)
        window!.rootViewController = navController
        window!.makeKeyAndVisible()
        return true
	}
    
    
}

