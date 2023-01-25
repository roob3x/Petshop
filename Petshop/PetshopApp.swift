//
//  PetshopApp.swift
//  Petshop
//
//  Created by Roberto Filho on 28/12/22.
//

import SwiftUI

@main
struct PetshopApp: App {
    var body: some Scene {
        WindowGroup {
            SplashView(viewModel: SplashViewModel(interactor: SplashInteractor()))
        }
    }
}
