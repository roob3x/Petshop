//
//  SplashRemoteDataSource.swift
//  Petshop
//
//  Created by Roberto Filho on 23/01/23.
//

import Foundation
import Combine

class SplashRemoteDataSource {
    
    static var shared: SplashRemoteDataSource = SplashRemoteDataSource()
    
    private init () {
        
    }
    
    func refreshToken(request: RefreshRequest) -> Future<SignInResponse, AppError> {
        return Future<SignInResponse, AppError> { promise in
            
            WebService.call(path: .refreshToken, method: .put, body: request) { result in
                switch result {
                case .failure(let error, let data):
                    if let data = data {
                        if error == .unauthorized {
                            let decoder = JSONDecoder()
                            let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                            print(response)
                            //completion(nil, response)
                            promise(.failure(AppError.response(message: response?.detail.message ?? "Erro desconhecido no servidor")))
                        }
                    }
                    break
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(SignInResponse.self, from: data)
                    //completion(response, nil)
                    
                    guard let response = response else {
                        print("Log: Error parser \(String(data: data, encoding: .utf8)!)")
                        return
                    }
                    
                    promise(.success(response))
                    
                    break
                }
            }
            
        }
    }
    
}
