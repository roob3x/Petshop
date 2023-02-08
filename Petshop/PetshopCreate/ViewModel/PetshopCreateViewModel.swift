//
//  PetshopCreateViewModel.swift
//  Petshop
//
//  Created by Roberto Filho on 08/02/23.
//

import Foundation
import SwiftUI
import Combine

class PetshopCreateViewModel: ObservableObject {
    
    @Published var uiState: PetShopDetailUiState = .none
    @Published var name = ""
    @Published var label = ""
    
    private var cancellable: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    var petshopPublisher: PassthroughSubject<Bool,Never>?

    let interactor: PetshopDetailInteractor
    
    
    init(interactor: PetshopDetailInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellable?.cancel()
        for cancellable in cancellables {
            cancellable.cancel()
        }
    }
    
    func save() {
        self.uiState = .loading
    }
}
