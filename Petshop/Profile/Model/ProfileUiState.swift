//
//  ProfileUiState.swift
//  Petshop
//
//  Created by Roberto Filho on 02/02/23.
//

import Foundation

enum ProfileUiState: Equatable {
    case none
    case loading
    case fetchSucess
    case fetchError(String)
    
    case updateLoading
    case updateSuccess
    case updateError(String)
}
