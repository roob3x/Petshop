//
//  HomeView.swift
//  Petshop
//
//  Created by Roberto Filho on 29/12/22.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        Text("Bem vindo a home!")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
