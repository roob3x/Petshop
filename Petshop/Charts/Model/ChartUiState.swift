//
//  ChartUiState.swift
//  Petshop
//
//  Created by Roberto Filho on 08/02/23.
//

import Foundation

enum ChartUiState: Equatable {
    case loading
    case emptyChart
    case fullChart
    case error(String)
}
