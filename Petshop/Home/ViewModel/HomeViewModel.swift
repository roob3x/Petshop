//
//  HomeViewModel.swift
//  Petshop
//
//  Created by Roberto Filho on 29/12/22.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    let petshopViewModel = PetshopViewModel(isCharts: false, interector: PetshopInteractor())
    let pershopForChartsViewModel = PetshopViewModel(isCharts: true, interector: PetshopInteractor())
    let profileViewModel = ProfileViewModel(interector: ProfileInterector())
    
}

extension HomeViewModel {
    func petshopView() -> some View {
        return HomeViewRouter.makePetshopView(viewModel: petshopViewModel)
    }
    
    func petshopForChartView() -> some View {
        return HomeViewRouter.makePetshopView(viewModel: pershopForChartsViewModel)
    }
    
    func profileView() -> some View {
        return HomeViewRouter.makeProfileView(viewModel: profileViewModel)
    }
}
