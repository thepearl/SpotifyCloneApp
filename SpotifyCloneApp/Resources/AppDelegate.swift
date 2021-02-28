//
//  AppDelegate.swift
//  SpotifyCloneApp
//
//  Created by mac on 2/27/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        if AuthManager.shared.isSignedIn
        {
            window.rootViewController = TabBarViewController()
        }
        else
        {
            let welcomeViewController = UINavigationController(rootViewController: WelcomeViewController())
            welcomeViewController.navigationBar.prefersLargeTitles = true
            welcomeViewController.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always
            window.rootViewController = welcomeViewController
        }
         
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}
