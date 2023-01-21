//
//  SignUpRemoteDataSource.swift
//  Petshop
//
//  Created by Roberto Filho on 21/01/23.
//

import Foundation
import Combine

class SignUpRemoteDataSource {
    
    //padrao singleton
    // tem apenas 1 unico objeto vivo dentro da aplicacao
    
    static var shared: SignUpRemoteDataSource = SignUpRemoteDataSource()

    
    private init() {
        
    }
    
    func postUser(request: SignUpRequest) -> Future<Bool, AppError>{
        return Future { promise in
            WebService.call(path: .postUser, body: request) { result in
                switch result {
                case .failure(let error, let data):
                    if let data = data {
                        if error == .badRequest {
                            let decoder = JSONDecoder()
                            let response = try? decoder.decode(ErrorResponse.self, from: data)
                            print(response?.detail)
                            //completion(nil, response)
                            promise(.failure(AppError.response(message: response?.detail ?? "Error interno no servidor")))
                        }
                    }
                    break
                case .success(_):
                   // completion(true, nil)
                    promise(.success(true))
                    break
                }
            }
        }
    }
}
