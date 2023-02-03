//
//  HomeViewModel.swift
//  Petshop
//
//  Created by Roberto Filho on 29/12/22.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    let viewModel = PetshopViewModel(interector: PetshopInteractor())
    let profileViewModel = ProfileViewModel(interector: ProfileInterector())
    
}

extension HomeViewModel {
    func petshopView() -> some View {
        return HomeViewRouter.makePetshopView(viewModel: viewModel)
    }
    
    func profileView() -> some View {
        return HomeViewRouter.makeProfileView(viewModel: profileViewModel)
    }
}
