//
//  PetshopViewModel.swift
//  Petshop
//
//  Created by Roberto Filho on 24/01/23.
//

import Foundation
import Combine
import SwiftUI


class PetshopViewModel: ObservableObject {
    @Published var uiState: PetshopUiState = .loading
    
    @Published var title = ""
    @Published var headline = ""
    @Published var desc = ""
    
    private var cancellabledRequest: AnyCancellable?
    private var cancellableNotify: AnyCancellable?
    private let interactor: PetshopInteractor
    let isCharts: Bool
    
    private var petshopPublisher = PassthroughSubject<Bool, Never>()
    
    init(isCharts: Bool, interector: PetshopInteractor) {
        self.isCharts = isCharts
        self.interactor = interector
        
        cancellableNotify = petshopPublisher.sink(receiveValue: { saved in
            print("saved: \(saved)")
            self.onAppear()
            
        })
    }
    
    deinit {
        cancellabledRequest?.cancel()
    }
    
    func onAppear() {
        self.uiState = .loading
        
        
        cancellabledRequest = interactor.fetchPetshop()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion) {
                case .failure(let appError):
                    self.uiState = .error(appError.message)
                    break
                case .finished:
                    break
                }
            }, receiveValue: { response in
                if response.isEmpty {
                    self.uiState = .emptyList
                    
                    self.title = ""
                    self.headline = "Fique ligado!"
                    self.desc = "voce ainda nao possui compras!"
                }
                else {
                    self.uiState = .fullList(
                        response.map {
                            
                            let lastDate = $0.lastDate?.toDate(sourcePattern: "yyyy-MM-dd'T'HH:mm:ss", destPattern: "dd/MM/yyyy HH:mm") ?? ""
                            var state = Color.green
                            self.title = "Muito bom!"
                            self.headline = "Voce possui compras!"
                            self.desc = ""
                            
                            if lastDate < Date().toString(destPattern: "dd/MM/yyyy"){
                                state = .red
                                self.title = "Atencao"
                                self.headline = "Fique ligado!"
                                self.desc = "Voce esta atrasado nas compras!"
                            }
                            
                            return PetshopCardViewModel(id: $0.id, icon: $0.iconUrl ?? "", date: lastDate, name: $0.name, label: $0.label, value: "\($0.value ?? 0)", state: state, petshopPublisher: self.petshopPublisher)
                        }
                    )
                }
            })
    }

}

extension PetshopViewModel {
    func petshopCreateView() -> some View {
        return PetshopViewRouter.makePetshopCreateView(petshopPublisher: petshopPublisher)
    }
}
