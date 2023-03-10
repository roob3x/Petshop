//
//  HomeView.swift
//  Petshop
//
//  Created by Roberto Filho on 29/12/22.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    @State var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            viewModel.petshopView()
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("Menu")
                }.tag(0)
            
            viewModel.petshopForChartView()
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Graficos")
                }.tag(1)
            
            viewModel.profileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Perfil")
                }.tag(2)
            
        }
        .background(Color.white)
        .accentColor(Color.blue)
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
