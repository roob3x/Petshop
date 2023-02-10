//
//  ChartInterector.swift
//  Petshop
//
//  Created by Roberto Filho on 08/02/23.
//

import Foundation
import Combine

class ChartInterector {
    
    private let remote: ChartRemoteDataSource = .shared
}

extension ChartInterector {
  
    func fetchPetshopValues(petshopId: Int) -> Future<[PetshopValueResponse], AppError> {
    return remote.fetchPetshopValues(petshopId: petshopId)
  }

}
