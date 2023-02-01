//
//  PetshopCardViewModel.swift
//  Petshop
//
//  Created by Roberto Filho on 25/01/23.
//

import Foundation
import SwiftUI
import Combine

struct PetshopCardViewModel: Identifiable, Equatable {
    var id: Int = 0
    var icon: String = ""
    var date: String = ""
    var name: String = ""
    var label: String = ""
    var value: String = ""
    var state: Color = .green
    
    var petshopPublisher: PassthroughSubject<Bool, Never>
    
    static func == (lhs: PetshopCardViewModel, rhs: PetshopCardViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
}

extension PetshopCardViewModel {
    func petshopDetailView() -> some View {
        return PetshopCardViewRouter.makePetshopDetailView(id: id, name: name, label: label, petshopPublisher: petshopPublisher)
    }
}
