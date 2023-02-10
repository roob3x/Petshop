//
//  PetshopCreateRemoteDataSource.swift
//  Petshop
//
//  Created by Roberto Filho on 10/02/23.
//

import Foundation
import Combine

class PetshopCreateRemoteDataSource {
    
    //padrao singleton
    // tem apenas 1 unico objeto vivo dentro da aplicacao
    
    static var shared: PetshopCreateRemoteDataSource = PetshopCreateRemoteDataSource()
    
    private init() {
        
    }
    
    func save(request: PetshopCreateRequest) -> Future<Void, AppError>{
        return Future<Void, AppError> { promise in
            
            WebService.call(path: .shopping, params: [
                URLQueryItem(name: "name", value: request.name),
                URLQueryItem(name: "label", value: request.label)
                                          ]) { result in
                switch result {
                case .failure(let error, let data):
                    if let data = data {
                        if error == .unauthorized {
                            let decoder = JSONDecoder()
                            let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                            //completion(nil, response)
                            promise(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido no servidor")))
                        }
                    }
                    break
                case .success(_):
                    promise(.success( () ))
                   // completion(response, nil)
                    break
                }
            }
        }
    }
}
