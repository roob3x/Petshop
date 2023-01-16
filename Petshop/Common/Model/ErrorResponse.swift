//
//  ErrorResponse.swift
//  Petshop
//
//  Created by Roberto Filho on 14/01/23.
//

import Foundation

struct ErrorResponse: Decodable {
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
    
}
