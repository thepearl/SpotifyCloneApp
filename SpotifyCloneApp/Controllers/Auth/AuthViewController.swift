//
//  AuthViewController.swift
//  SpotifyCloneApp
//
//  Created by mac on 2/28/21.
//

import UIKit
import WebKit

class AuthViewController: UIViewController, WKNavigationDelegate {
    
    let webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let configs = WKWebViewConfiguration()
        configs.defaultWebpagePreferences = prefs
        let webView = WKWebView(frame: .zero, configuration: configs)
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign in"
        self.view.backgroundColor = .systemBackground
        webView.navigationDelegate = self
        self.view.addSubview(webView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
}
