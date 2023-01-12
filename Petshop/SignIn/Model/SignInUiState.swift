//
//  SignInUiState.swift
//  Petshop
//
//  Created by Roberto Filho on 29/12/22.
//

import Foundation

enum SignInUiState: Equatable {
    case none
    case loading
    case goToHomeScreen
    case error(String)
}
