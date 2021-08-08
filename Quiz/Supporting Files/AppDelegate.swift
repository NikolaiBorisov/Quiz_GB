//
//  AppDelegate.swift
//  Quiz
//
//  Created by NIKOLAI BORISOV on 05.08.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = .systemIndigo
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.buttonFont25
        ]
        return true
    }
    
}
