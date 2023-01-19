//
//  SignInInteractor.swift
//  Petshop
//
//  Created by Roberto Filho on 19/01/23.
//

import Foundation

class SignInInteractor {
    
    private let remote: RemoteDataSource = .shared
    //private let local : LocalDataSource
}

extension SignInInteractor {
    func login(request: SignInRequest, completion: @escaping (SignInResponse?, SignInErrorResponse?) -> Void) {
        remote.login(request: request, completion: completion)
    }
}
