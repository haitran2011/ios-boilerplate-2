//
//  AppDelegate.swift
//  NewsApp
//
//  Created by Ryoichi Hara on 2017/05/20.
//  Copyright © 2017年 Ryoichi Hara. All rights reserved.
//

import UIKit
import Presentation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool { // swiftlint:disable:this line_length
        
        let bundle = Bundle(for: ListViewController.self)
        let storyboard = UIStoryboard(name: "List", bundle: bundle)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = storyboard.instantiateInitialViewController()
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}
