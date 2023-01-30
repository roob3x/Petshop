//
//  HomeViewModel.swift
//  Petshop
//
//  Created by Roberto Filho on 29/12/22.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    let viewModel = PetshopViewModel(interector: PetshopInteractor())
    
}

extension HomeViewModel {
    func petshopView() -> some View {
        return HomeViewRouter.makePetshopView(viewModel: viewModel)
    }
}
