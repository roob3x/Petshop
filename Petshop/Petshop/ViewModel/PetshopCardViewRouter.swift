//
//  PetshopViewRouter.swift
//  Petshop
//
//  Created by Roberto Filho on 30/01/23.
//

import Foundation
import SwiftUI
import Combine

enum PetshopCardViewRouter {
    
    static func makePetshopDetailView(id: Int, name: String, label: String, petshopPublisher: PassthroughSubject<Bool, Never>) -> some View {
        let viewModel = PetshopDetailViewModel(id: id, name: name, label: label, interactor: PetshopDetailInteractor())
        viewModel.petshopPublisher = petshopPublisher
        return PetshopDetailView(viewModel: viewModel)
    }
    
    static func makeChartView(id: Int) -> some View{
        let viewModel = ChartViewModel(petshopId: id, interector: ChartInterector())
        return ChartView(viewModel: viewModel)
    }
    
}
