//
//  PetshopDetailInteractor.swift
//  Petshop
//
//  Created by Roberto Filho on 31/01/23.
//

import Foundation
import Combine

class PetshopDetailInteractor {
    private let remote: PetshopDetailRemoteDataSource = .shared
    private let local: LocalDataSource = .shared
}

extension PetshopDetailInteractor {
    func save(petshopId: Int, petshopValueRequest request: PetshopValueRequest) -> Future<Bool, AppError> {
        return remote.save(petshopId: petshopId, request: request)
    }
}
