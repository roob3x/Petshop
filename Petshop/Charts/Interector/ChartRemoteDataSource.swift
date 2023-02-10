//
//  ChartRemoteDataSource.swift
//  Petshop
//
//  Created by Roberto Filho on 08/02/23.
//

import Foundation
import Combine

class ChartRemoteDataSource {

    static var shared: ChartRemoteDataSource = ChartRemoteDataSource()
    
    private init() {
        
    }
    
    func fetchPetshopValues(petshopId: Int) -> Future<[PetshopValueResponse], AppError>{
        return Future { promise in
            let path = String(format: WebService.Endpoint.petshopValues.rawValue, petshopId)
            WebService.call(path: path, method: .get) { result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(ErrorResponse.self, from: data)
                        print(response?.detail)
                        promise(.failure(AppError.response(message: response?.detail ?? "Error interno no servidor")))
                    }
                    break
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode([PetshopValueResponse].self, from: data)
                    
                    guard let res = response else {
                        print("Log: Error parser \(String(data: data, encoding: .utf8))")
                        return
                    }
                    promise(.success(res))
                    break
                }
            }
        }
    }
}
