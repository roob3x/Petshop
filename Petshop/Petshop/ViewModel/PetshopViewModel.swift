//
//  PetshopViewModel.swift
//  Petshop
//
//  Created by Roberto Filho on 24/01/23.
//

import Foundation

class PetshopViewModel: ObservableObject {
    @Published var uiState: PetshopUiState = .emptyList
    
    @Published var title = "Atencao"
    @Published var headline = "Fique ligado!"
    @Published var desc = "Voce esta atrasado nos habitos!"

}
