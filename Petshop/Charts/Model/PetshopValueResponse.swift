//
//  PetshopValueResponse.swift
//  Petshop
//
//  Created by Roberto Filho on 08/02/23.
//

import Foundation

struct PetshopValueResponse: Decodable {
    
    let id: Int
    let value: Int
    let petshopId: Int
    let createdDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case value
        case petshopId = "habit_id"
        case createdDate = "created_date"
    }
}
