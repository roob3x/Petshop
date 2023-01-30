//
//  PetshopResponse.swift
//  Petshop
//
//  Created by Roberto Filho on 29/01/23.
//

import Foundation

struct PetshopResponse: Decodable {
    let id: Int
    let name: String
    let label: String
    let iconUrl: String?
    let value: Int?
    let lastDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case label
        case iconUrl = "icon_url"
        case value
        case lastDate = "last_date"
    }
}
