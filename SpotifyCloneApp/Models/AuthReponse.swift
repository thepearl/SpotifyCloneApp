//
//  AuthReponse.swift
//  SpotifyCloneApp
//
//  Created by mac on 2/28/21.
//

import Foundation

struct AuthReponse: Decodable {
    let access_token: String
    let expires_in: Double
    let refresh_token: String?
    let scope: String
    let token_type: String
}
