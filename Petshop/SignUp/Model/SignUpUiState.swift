//
//  SignUpUiState.swift
//  Petshop
//
//  Created by Roberto Filho on 03/01/23.
//

import Foundation

enum SignUpUiState: Equatable {
    case none
    case loading
    case sucess
    case goToHomeScreen
    case error(String)
}
