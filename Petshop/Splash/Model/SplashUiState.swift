//
//  SplashUiState.swift
//  Petshop
//
//  Created by Roberto Filho on 29/12/22.
//

import Foundation

enum SplashUiState {
    case loading
    case goToSignInScreen
    case goToSignUpScreen
    case goToHomeScreen
    case error(String)
}
