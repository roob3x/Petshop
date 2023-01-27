//
//  PetshopUiState.swift
//  Petshop
//
//  Created by Roberto Filho on 24/01/23.
//

import Foundation

enum PetshopUiState: Equatable{
    case loading
    case emptyList
    case fullList
    case error(String)
}
