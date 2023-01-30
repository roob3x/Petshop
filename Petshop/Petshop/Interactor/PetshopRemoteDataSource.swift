//
//  PetshopRemoteDataSource.swift
//  Petshop
//
//  Created by Roberto Filho on 29/01/23.
//

import Foundation
import Combine

class PetshopRemoteDataSource {
    
    static var shared: PetshopRemoteDataSource = PetshopRemoteDataSource()
    
    private init () {
        
    }
    
    func fetchPetshop() -> Future<[PetshopResponse], AppError> {
        return Future<[PetshopResponse], AppError> { promise in
            
            WebService.call(path: .shopping, method: .get) { result in
                switch result {
                case .failure(_, let data):
                    if let data = data {
                        
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                        print(response)
                        promise(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido no servidor")))
                    }
                    break
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode([PetshopResponse].self, from: data)
                    //completion(response, nil)
                    
                    guard let res = response else {
                        print("Log: Error parser \(String(data: data, encoding: .utf8)!)")
                        return
                    }
                    
                    promise(.success(res))
                    
                    break
                }
            }
            
        }
    }
}
