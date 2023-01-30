//
//  PetshopInteractor.swift
//  Petshop
//
//  Created by Roberto Filho on 29/01/23.
//

import Foundation
import Combine

class PetshopInteractor {
    
    private let remote: PetshopRemoteDataSource = .shared
    
}

extension PetshopInteractor {
    func fetchPetshop() -> Future<[PetshopResponse], AppError> {
        return remote.fetchPetshop()
    }
}
