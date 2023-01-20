//
//  AppError.swift
//  Petshop
//
//  Created by Roberto Filho on 19/01/23.
//

import Foundation

enum AppError: Error {
    
case response(message: String)
    
    public var message: String {
        switch self {
        case .response(let message):
            return message
        }
    }
}
