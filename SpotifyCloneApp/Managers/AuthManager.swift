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
    
    struct Constants {
        static let clientID = "0abc9b55ac794b8c83332c600364232e"
        static let clientSecret = "a8e0b0cd3862487fbebf2375ede86496"
    }
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
