//
//  AuthManager.swift
//  SpotifyCloneApp
//
//  Created by mac on 2/28/21.
//

import Foundation

final class AuthManager
{
    static var shared = AuthManager()
    private init(){}
    
    var isSignedIn: Bool {
        return false
    }
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var tokenExpirationDate: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool? {
        return false
    }
}
