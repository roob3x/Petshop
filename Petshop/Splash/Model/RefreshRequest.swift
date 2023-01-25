//
//  RefreshRequest.swift
//  Petshop
//
//  Created by Roberto Filho on 23/01/23.
//

import Foundation

struct RefreshRequest: Encodable {
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "refresh_token"
    }
}
