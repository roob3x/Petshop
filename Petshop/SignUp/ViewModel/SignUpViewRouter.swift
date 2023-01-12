//
//  SignUpViewRouter.swift
//  Petshop
//
//  Created by Roberto Filho on 03/01/23.
//

import SwiftUI

enum SignUpViewRouter {
    static func makeHomeView() -> some View {
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
}
