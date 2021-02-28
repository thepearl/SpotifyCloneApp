//
//  TabBarViewController.swift
//  SpotifyCloneApp
//
//  Created by mac on 2/28/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let firstController = HomeViewController()
        let secondController = SearchViewController()
        let thirdController = LibraryViewController()
        
        firstController.title = "Browse"
        secondController.title = "Search"
        thirdController.title = "Library"
        
        firstController.navigationItem.largeTitleDisplayMode = .always
        secondController.navigationItem.largeTitleDisplayMode = .always
        thirdController.navigationItem.largeTitleDisplayMode = .always
        
        let firstNavigationController = UINavigationController(rootViewController: firstController)
        let secondNavigationController = UINavigationController(rootViewController: secondController)
        let thirdCNavigationController = UINavigationController(rootViewController: thirdController)
        
        firstNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        secondNavigationController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        thirdCNavigationController.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "music.note.list"), tag: 3)
        
        firstNavigationController.navigationBar.prefersLargeTitles = true
        secondNavigationController.navigationBar.prefersLargeTitles = true
        thirdCNavigationController.navigationBar.prefersLargeTitles = true
        
        setViewControllers([firstNavigationController, secondNavigationController, thirdCNavigationController], animated: false)


    }
}
