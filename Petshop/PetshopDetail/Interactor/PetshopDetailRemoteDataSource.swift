//
//  PetshopRemoteDataSource.swift
//  Petshop
//
//  Created by Roberto Filho on 31/01/23.
//

import Foundation
import Combine

class PetshopDetailRemoteDataSource {
    static var shared: PetshopDetailRemoteDataSource = PetshopDetailRemoteDataSource()
    
    private init () {
        
    }
    
    func save(petshopId: Int, request: PetshopValueRequest) -> Future<Bool, AppError> {
        return Future<Bool, AppError> { promise in
            let path = String(format: WebService.Endpoint.petshopValues.rawValue, petshopId)
            WebService.call(path: path, method: .post, body: request) { result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                        print(response)
                        promise(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido no servidor")))
                    }
                    break
                case .success(_):
                    
                    promise(.success(true))
                    
                    break
                }
            }
            
        }
    }
}
