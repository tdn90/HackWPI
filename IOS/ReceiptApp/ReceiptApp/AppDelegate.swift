//
//  AppDelegate.swift
//  ReceiptApp
//
//  Created by Ryan Johnson on 1/18/19.
//  Copyright © 2019 Ryan Johnson. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var email: String?
    var token: String?
    var usern: String?
    let userDefault = UserDefaults.standard
    let url = "http://130.215.214.195:3000"

    func saveDefaults() {
        userDefault.set(email, forKey: "user_email")
        userDefault.set(token, forKey: "user_token")
        userDefault.set(usern, forKey: "user_name")
    }
    
    func loadDefaults() {
        if let r_email = userDefault.string(forKey: "user_email") {
            email = r_email
        } else {
            email = nil
        }
        if let r_token = userDefault.string(forKey: "user_token") {
            token = r_token
        } else {
            token = nil
        }
        if let r_usern = userDefault.string(forKey: "user_name") {
            usern = r_usern
        } else {
            usern = nil
        }
    }
    
    func clearDefaults() {
        userDefault.removeObject(forKey: "user_email")
        userDefault.removeObject(forKey: "user_token")
        userDefault.removeObject(forKey: "user_name")
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

