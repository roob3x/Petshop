//
//  PetshopViewRouter.swift
//  Petshop
//
//  Created by Roberto Filho on 30/01/23.
//

import Foundation
import SwiftUI

enum PetshopCardViewRouter {
    
    static func makePetshopDetailView(id: Int, name: String, label: String) -> some View {
        let viewModel = PetshopDetailViewModel(id: id, name: name, label: label, interactor: PetshopDetailInteractor())
        return PetshopDetailView(viewModel: viewModel)
    }
    
}
