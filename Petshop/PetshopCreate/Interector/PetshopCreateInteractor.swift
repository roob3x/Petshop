//
//  PetshopCreateInterector.swift
//  Petshop
//
//  Created by Roberto Filho on 10/02/23.
//

import Foundation
import Combine

class PetshopCreateInteractor {
    
    private let remote: PetshopCreateRemoteDataSource = .shared
}

extension PetshopCreateInteractor {
    func save(petshopCreateRequest request: PetshopCreateRequest) -> Future<Void, AppError> {
        remote.save(request: request)
    }
    
}
