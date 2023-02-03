//
//  ProfileViewModel.swift
//  Petshop
//
//  Created by Roberto Filho on 02/02/23.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    
    @Published var uiState: ProfileUiState = .none
    
    @Published var fullNameValidation = FullNameValidation()
    @Published var phoneValidation = PhoneValidation()
    @Published var birthdayValidation = BirthdayValidation()
    
    var userId: Int?
    @Published var email = ""
    @Published var document = ""
    @Published var gender: Gender?
    
    private var cancellable: AnyCancellable?
    
    private let interector: ProfileInterector
    
    init(interector: ProfileInterector) {
        self.interector = interector
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func fetchUser() {
        self.uiState = .loading
        cancellable = interector.fetchUser()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion) {
                case .failure(let appError):
                    self.uiState = .fetchError(appError.message)
                    break
                case .finished:
                    break
                }
                
            }, receiveValue: { response in
                self.userId = response.id
                self.email = response.email
                self.document = response.document
                self.gender = Gender.allCases[response.gender]
                self.fullNameValidation.value = response.fullName
                self.phoneValidation.value = response.phone
                
                // Pegar a string -> dd/MM/yyyy -> Date
                let formatter = DateFormatter()
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.dateFormat = "yyyy-MM-dd"
                
                let dateFormatted = formatter.date(from: response.birthday)
                
                // validar a data
                guard let dateFormatted = dateFormatted else {
                    self.uiState = .fetchError("Data invalida \(response.birthday)")
                    return
                }
                
                //Date -> yyyy-MM-dd -> String
                formatter.dateFormat = "dd/MM/yyyy"
                let birthday = formatter.string(from: dateFormatted)
                
                self.birthdayValidation.value = birthday
                self.uiState = .fetchSucess
            })
    }
    
}

class FullNameValidation: ObservableObject {
    @Published var failure = false
    
    var value: String = "Monica meneses araujo" {
        didSet {
            failure = value.count < 5
        }
    }
}

class PhoneValidation: ObservableObject {
    @Published var failure = false
    
    var value: String = "81 979141181" {
        didSet {
            failure = value.count < 10 || value.count >= 12
        }
    }
}

class BirthdayValidation: ObservableObject {
    @Published var failure = false
    
    var value: String = "20/03/1969" {
        didSet {
            failure = value.count != 10
        }
    }
}

