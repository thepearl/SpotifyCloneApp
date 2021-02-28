//
//  WelcomeViewController.swift
//  SpotifyCloneApp
//
//  Created by mac on 2/28/21.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("Sign in with Spotify", for: .normal)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Spotify Clone"
        view.backgroundColor = .systemGreen
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInButton.frame = CGRect(x: 20,
                                    y: view.height-50-view.safeAreaInsets.bottom,
                                    width: view.width-40,
                                    height: 50)
    }
    
    @objc func didTapSignIn()
    {
        let authViewController = AuthViewController()
        authViewController.completionHandeler = {[weak self] success in
            guard let self = self else { return }
            self.handleSignInSuccess(for: success)
        }
        authViewController.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(authViewController, animated: true)
    }
    
    private func handleSignInSuccess(for success: Bool)
    {
        guard success
        else
        {
            let uiAlert = UIAlertController(title: "Bad news", message: "Sounds bad ! Something went wrong while trying to sign in :(", preferredStyle: .alert)
            uiAlert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(uiAlert, animated: true, completion: nil)
            return
        }
        let mainAppTabBarController = TabBarViewController()
        mainAppTabBarController.modalPresentationStyle = .fullScreen
        present(mainAppTabBarController, animated: true, completion: nil)
    }
}
