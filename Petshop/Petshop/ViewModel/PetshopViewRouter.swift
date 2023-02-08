//
//  PetshopViewRouter.swift
//  Petshop
//
//  Created by Roberto Filho on 08/02/23.
//

import Foundation
import Combine
import SwiftUI

enum PetshopViewRouter {
    static func makePetshopCreateView(petshopPublisher: PassthroughSubject<Bool, Never>) -> some View {
        let viewModel = PetshopCreateViewModel(interactor: PetshopDetailInteractor())
        viewModel.petshopPublisher = petshopPublisher
        return PetshopCreateView(viewModel: viewModel)
    }
}
