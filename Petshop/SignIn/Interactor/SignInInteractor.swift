//
//  SignInInteractor.swift
//  Petshop
//
//  Created by Roberto Filho on 19/01/23.
//

import Foundation
import Combine

class SignInInteractor {
    
    private let remote: RemoteDataSource = .shared
    //private let local : LocalDataSource
}

extension SignInInteractor {
    func login(loginRequest request: SignInRequest) -> Future<SignInResponse, AppError> {
        remote.login(request: request)
    }
}
