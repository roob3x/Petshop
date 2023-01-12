//
//  WebService.swift
//  Petshop
//
//  Created by Roberto Filho on 11/01/23.
//

import Foundation

enum WebService {
    
    enum Endpoint: String {
        case base = "https://petstore.swagger.io/"
        case postUser = "/v2/user"
    }
    
    private static func completeUrl(path: Endpoint) -> URLRequest? {
        guard let url = URL(string: "\(Endpoint.base.rawValue)\(path.rawValue)") else { return nil }
        
        return URLRequest(url: url)
    }
    
    static func postUser(id: Int,
                         Fullname: String,
                         email: String,
                         password: String,
                         document: String,
                         phone: String,
                         birthday: String,
                         gender: Int) {
        let json: [String : Any] = [
              "id": id,
              "username": email,
              "firstName": Fullname,
              "lastName": Fullname,
              "email": email,
              "password": password,
              "phone": phone,
              "userStatus": gender
        ]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        guard var urlRequest = completeUrl(path: .postUser) else { return }
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: urlRequest) {data, response, error in
            guard let data = data, error == nil else {
                print(error)
                return
            }
            print(String(data: data, encoding: .utf8))
            
            print("response\n")
            
            print(response)
            
            if let r = response as? HTTPURLResponse {
                print(r.statusCode)
            }
        }
        task.resume()
    }
}
