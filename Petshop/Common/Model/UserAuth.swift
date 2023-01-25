//
//  UserAuth.swift
//  Petshop
//
//  Created by Roberto Filho on 23/01/23.
//

import Foundation

struct UserAuth: Codable {
    var idToken: String
    var refreshToken: String
    var expires: Double = 0.0
    var tokenType: String
    
    enum CodingKeys: String, CodingKey {
        case idToken = "access_token"
        case refreshToken = "refresh_token"
        case expires
        case tokenType = "token_type"
    }
}
