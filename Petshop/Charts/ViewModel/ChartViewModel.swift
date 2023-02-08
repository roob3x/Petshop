//
//  ChartViewModel.swift
//  Petshop
//
//  Created by Roberto Filho on 08/02/23.
//

import Foundation
import Combine
import Charts
import SwiftUI

class ChartViewModel: ObservableObject {
    @Published var uiState = ChartUiState.loading
    @Published var entries: [ChartDataEntry] = []
    @Published var dates: [String] = []
    
    private var cancellable: AnyCancellable?
    
    private let petshopId: Int
    private let interector: ChartInterector
    
    init(petshopId: Int, interector: ChartInterector){
        self.petshopId = petshopId
        self.interector = interector
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    func onAppear() {
        cancellable = interector.fetchPetshopValues(petshopId: petshopId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch(completion) {
                case .failure(let appError):
                    self.uiState = .error(appError.message)
                case .finished:
                    break
                }
                
            }, receiveValue: { res in
                if res.isEmpty {
                    self.uiState = .emptyChart
                }
                else {
                    self.dates = res.map { $0.createdDate }
                    self.entries = zip(res.startIndex..<res.endIndex, res).map { index, response in
                        ChartDataEntry(x: Double(index), y: Double(response.value))
                    }
                    self.uiState = .fullChart   
                }
                
            })
    }
}
