//
//  PetshopViewModelDetail.swift
//  Petshop
//
//  Created by Roberto Filho on 30/01/23.
//

import Foundation
import SwiftUI
import Combine

class PetshopDetailViewModel: ObservableObject {
    
    @Published var uiState: PetShopDetailUiState = .none
    @Published var value = ""
    
    private var cancellable: AnyCancellable?
    var cancellables = Set<AnyCancellable>()
    var petshopPublisher: PassthroughSubject<Bool,Never>?
    
    let id: Int
    let name: String
    let label: String
    let interactor: PetshopDetailInteractor
    
    
    init(id: Int, name: String, label: String, interactor: PetshopDetailInteractor) {
        self.id = id
        self.name = name
        self.label = label
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
        cancellable = interactor.save(petshopId: id, petshopValueRequest: PetshopValueRequest(value: value))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion) {
                case .failure(let appError):
                    self.uiState = .error(appError.message)
                    break
                case .finished:
                    break
                }
            }, receiveValue: { created in
                if created {
                    self.uiState = .success
                    self.petshopPublisher?.send(created)
                }
            })
    }
}
