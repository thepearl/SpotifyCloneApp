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
    
    public var completionHandeler: ((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign in"
        self.view.backgroundColor = .systemBackground
        webView.navigationDelegate = self
        self.view.addSubview(webView)
        guard let authURL = AuthManager.shared.signInURL else { return }
        webView.load(URLRequest(url: authURL))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!)
    {
        guard
            let url = webView.url,
            let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: {$0.name == "code"})?.value
        else { return }
        webView.isHidden = true
        
        //Exchange code with spotify for refresh token
        AuthManager.shared.exchangeCodeForAccessToken(code: code) { [weak self] (success) in
            guard success, let self = self else { return }
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
                self.completionHandeler?(success)
            }
        }
    }
}
