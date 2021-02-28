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
        static let tokenAPIUrl = "https://accounts.spotify.com/api/token"
        static let redirectURL = "https://www.instagram.com/"
        static let scopes = "user-read-private%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-modify%20user-library-read%20user-read-email"
    }
    var isSignedIn: Bool {
        return accessToken != nil
    }
    
    private var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    
    private var refreshToken: String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    
    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expires_in") as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let expirationDate = tokenExpirationDate else { return false }
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        return currentDate.addingTimeInterval(fiveMinutes) >= expirationDate
    }
    
    public var signInURL: URL? {
        let baseAuthURL = "https://accounts.spotify.com/authorize"
        let scopes = Constants.scopes
        let urlPath = "\(baseAuthURL)?response_type=code&client_id=\(Constants.clientID)&scope=\(scopes)&redirect_uri=\(Constants.redirectURL)&show_dialog=TRUE"
        return URL(string: urlPath)
    }
    
    public func exchangeCodeForAccessToken(code: String, completion: @escaping (Bool) -> Void)
    {
        //GET Token
        guard let url = URL(string: Constants.tokenAPIUrl) else { return }
        
        var component = URLComponents()
        component.queryItems = [ URLQueryItem(name: "grant_type", value: "authorization_code"), URLQueryItem(name: "code", value: code), URLQueryItem(name: "redirect_uri", value: Constants.redirectURL)]
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.setValue("application/x-www-form-urlencoded ",
                         forHTTPHeaderField: "Content-Type")
        
        
        request.httpBody = component.query?.data(using: .utf8)
        
        let basicToken = Constants.clientID + ":" + Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString()
        else { print("Couldn't encode header"); completion(false); return}
        
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) {[weak self] (data, response, error) in
            guard
                let unwrappedData = data,
                error == nil
            else { completion(false); return }
            
            do
        {
            let result = try JSONDecoder().decode(AuthReponse.self, from: unwrappedData)
            print("\n---------SUCCESS------\n------JSON Object-----\n")
            print(result)
            self?.cacheToken(for: result)
            completion(true)
        }
            catch
            {
                print(error.localizedDescription)
                completion(false)
            }
        }
        
        task.resume()
    }
    
    private func cacheToken(for authResponse: AuthReponse)
    {
        UserDefaults.standard.setValue(authResponse.access_token, forKey: "access_token")
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(authResponse.expires_in)), forKey: "expires_in")
        if let refreshToken = authResponse.refresh_token
        {
            UserDefaults.standard.setValue(refreshToken, forKey: "refresh_token")
        }
    }
    
    public func refreshAccessTokenIfNeeded(completion: @escaping ((Bool) -> Void))
    {
//        guard shouldRefreshToken
//        else
//        {
//            completion(true)
//            return
//        }
        
        guard
            let refreshToken = self.refreshToken
        else { completion(false); return }
        
        // refresh token
        guard let url = URL(string: Constants.tokenAPIUrl) else { return }
        
        var component = URLComponents()
        component.queryItems = [ URLQueryItem(name: "grant_type", value: "refresh_token"), URLQueryItem(name: "refresh_token", value: refreshToken)]
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.setValue("application/x-www-form-urlencoded ",
                         forHTTPHeaderField: "Content-Type")
        
        
        request.httpBody = component.query?.data(using: .utf8)
        
        let basicToken = Constants.clientID + ":" + Constants.clientSecret
        let data = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString()
        else { print("Couldn't encode header"); completion(false); return}
        
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) {[weak self] (data, response, error) in
            guard
                let unwrappedData = data,
                error == nil
            else { completion(false); return }
            
            do
        {
            let result = try JSONDecoder().decode(AuthReponse.self, from: unwrappedData)
            print("\n---------SUCCESS REFRESH TOKEN------\n------JSON Object-----\n")
            print(result)
            self?.cacheToken(for: result)
            completion(true)
        }
            catch
            {
                print(error.localizedDescription)
                completion(false)
            }
        }
        
        task.resume()
        
    }
}
