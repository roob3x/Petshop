//
//  ProfileViewModel.swift
//  Petshop
//
//  Created by Roberto Filho on 02/02/23.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var fullNameValidation = FullNameValidation()
    @Published var phoneValidation = PhoneValidation()
    @Published var birthdayValidation = BirthdayValidation()
    
}

class FullNameValidation: ObservableObject {
    @Published var failure = false
    
    var value: String = "" {
        didSet {
            failure = value.count < 5
        }
    }
}

class PhoneValidation: ObservableObject {
    @Published var failure = false
    
    var value: String = "" {
        didSet {
            failure = value.count < 10 || value.count >= 12
        }
    }
}

class BirthdayValidation: ObservableObject {
    @Published var failure = false
    
    var value: String = "" {
        didSet {
            failure = value.count != 10
        }
    }
}

