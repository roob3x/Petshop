//
//  SignUpViewModel.swift
//  Petshop
//
//  Created by Roberto Filho on 03/01/23.
//

import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
    
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var document = ""
    @Published var phone = ""
    @Published var birthday = ""
    @Published var gender = Gender.male
    
    var publisher: PassthroughSubject<Bool, Never>!
    
    @Published var uiState: SignUpUiState = .none
    
    func signUp() {
        self.uiState = .loading
        
        // Pegar a string -> dd/MM/yyyy -> Date
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFormatted = formatter.date(from: birthday)
        
        // validar a data
        guard let dateFormatted = dateFormatted else {
            self.uiState = .error("Data invalida \(birthday)")
            return
        }
        
        //Date -> yyyy-MM-dd -> String
        formatter.dateFormat = "yyyy-MM-dd"
        let birthday = formatter.string(from: dateFormatted)
        
        //WebService.postUser(request: SignUpRequest.init(fullName: fullName, email: email, password: password, document: document, phone: phone, birthday: birthday, gender: gender.index))
       // DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            //self.uiState = .sucess
            //self.publisher.send(true)
           // self.uiState = .
            //self.uiState = .error("Preencha o formulario corretamente")
            
       // }
    }
}


extension SignUpViewModel {
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}
