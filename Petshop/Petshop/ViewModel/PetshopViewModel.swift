//
//  PetshopViewModel.swift
//  Petshop
//
//  Created by Roberto Filho on 24/01/23.
//

import Foundation

class PetshopViewModel: ObservableObject {
    @Published var uiState: PetshopUiState = .emptyList
    
    @Published var title = "Voce ainda nao possui compras"
    @Published var headline = "Aqui voce encontra os melhores produtos"
    @Published var desc = "O seu pet merece ❤️"
    
    func onAppear() {
        self.uiState = .loading
        
        DispatchQueue.main.asyncAfter(deadline: .now () + 1) {
            var rows: [PetshopCardViewModel] = []
            
            rows.append(PetshopCardViewModel(id: 1, icon: "https://via.placeholder.com/150", date: "01/01/2023 00:00:00", name: "Ossinho", label: "horas", value: "2", state: .green))
            rows.append(PetshopCardViewModel(id: 2, icon: "https://via.placeholder.com/150", date: "01/01/2023 00:00:00", name: "Racao Golden", label: "horas", value: "3", state: .green))
            rows.append(PetshopCardViewModel(id: 3, icon: "https://via.placeholder.com/150", date: "01/01/2023 00:00:00", name: "Biscoito Premier", label: "horas", value: "4", state: .green))
            
            self.uiState = .fullList(rows)
        }
    }

}
