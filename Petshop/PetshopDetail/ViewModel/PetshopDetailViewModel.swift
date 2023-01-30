//
//  PetshopViewModelDetail.swift
//  Petshop
//
//  Created by Roberto Filho on 30/01/23.
//

import Foundation
import SwiftUI

class PetshopDetailViewModel: ObservableObject {
    
    @Published var uiState: PetShopDetailUiState = .none
    @Published var value = ""
    
    let id: Int
    let name: String
    let label: String
    
    init(id: Int, name: String, label: String) {
        self.id = id
        self.name = name
        self.label = label
    }
    
}
