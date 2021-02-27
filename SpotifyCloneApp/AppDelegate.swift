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
        window?.overrideUserInterfaceStyle = .light
        
        let rootNavC = UINavigationController(rootViewController: ViewController.instantiateFromStoryboard(MAIN_STORYBOARD))
        rootNavC.isNavigationBarHidden = true
        window?.rootViewController = rootNavC
        window?.makeKeyAndVisible()
        return true
    }
}

let MAIN_STORYBOARD = "Main"


extension UIViewController
{
    class func instantiateFromStoryboard(_ name: String) -> Self
    {
        return instantiateFromStoryboardHelper(name)
    }
    
    fileprivate class func instantiateFromStoryboardHelper<T>(_ name: String) -> T
    {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! T
        return controller
    }}
