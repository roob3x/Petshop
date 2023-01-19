//
//  RemoteDataSource.swift
//  Petshop
//
//  Created by Roberto Filho on 19/01/23.
//

import Foundation

class RemoteDataSource {
    
    //padrao singleton
    // tem apenas 1 unico objeto vivo dentro da aplicacao
    
    static var shared: RemoteDataSource = RemoteDataSource()
    
    private init() {
        
    }
    
    func login(request: SignInRequest, completion: @escaping (SignInResponse?, SignInErrorResponse?) -> Void){
        WebService.call(path: .login, params: [
            URLQueryItem(name: "username", value: request.email),
            URLQueryItem(name: "password", value: request.password)
                                      ]) { result in
            switch result {
            case .failure(let error, let data):
                if let data = data {
                    if error == .unauthorized {
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(SignInErrorResponse.self, from: data)
                        completion(nil, response)
                    }
                }
                break
            case .sucess(let data):
                let decoder = JSONDecoder()
                let response = try? decoder.decode(SignInResponse.self, from: data)
                completion(response, nil)
                break
            }
        }
    }
}
