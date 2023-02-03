//
//  ProfileInterector.swift
//  Petshop
//
//  Created by Roberto Filho on 02/02/23.
//

import Foundation
import Combine

class ProfileInterector {
    private let remote: ProfileRemoteDataSource = .shared
}

extension ProfileInterector {
    func fetchUser() -> Future<ProfileResponse, AppError> {
        return remote.fetchUser()
    }
}
