//
//  HomeViewRouter.swift
//  Petshop
//
//  Created by Roberto Filho on 24/01/23.
//

import Foundation
import SwiftUI

enum HomeViewRouter {
    static func makePetshopView () -> some View {
        return PetshopView(viewModel: PetshopViewModel())
    }
}
