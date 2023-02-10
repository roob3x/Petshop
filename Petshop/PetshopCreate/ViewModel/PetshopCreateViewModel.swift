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
    
    @Published var image: Image? = Image(systemName:  "camera.fill")
    @Published var imageData: Data? = nil
    
    
    private var cancellable: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    var petshopPublisher: PassthroughSubject<Bool,Never>?

    let interactor: PetshopCreateInteractor
    
    
    init(interactor: PetshopCreateInteractor) {
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
        
        cancellable = interactor.save(petshopCreateRequest: PetshopCreateRequest(imageData: imageData, name: name, label: label))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion) {
                case .failure(let appError):
                    self.uiState = .error(appError.message)
                    break
                case . finished:
                    break
                }
                
            }, receiveValue: {
                self.uiState = .success
                self.petshopPublisher?.send(true)
            })
    }
}
