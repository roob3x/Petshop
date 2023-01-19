//
//  WebService.swift
//  Petshop
//
//  Created by Roberto Filho on 11/01/23.
//

import Foundation

enum WebService {
    
    enum Endpoint: String {
        case base = "https://habitplus-api.tiagoaguiar.co"
        case postUser = "/users"
        case login = "/auth/login"
    }
    
    enum NetWorkError {
        case badRequest
        case notFound
        case unauthorized
        case internalServerError
    }
    
    enum Result {
        case sucess(Data)
        case failure(NetWorkError, Data?)
    }
    
    enum ContentType: String {
        case json = "application/json"
        case formUrl = "application/x-www-form-urlencoded"
    }
    
    private static func completeUrl(path: Endpoint) -> URLRequest? {
        guard let url = URL(string: "\(Endpoint.base.rawValue)\(path.rawValue)") else {return nil }
        return URLRequest(url: url)
    }
    
    private static func call(path: Endpoint, contentType: ContentType, data: Data?, completion: @escaping (Result) -> Void) {
        guard var urlRequest = completeUrl(path: path) else { return }
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
        urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = data
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                print(error)
                completion(.failure(.internalServerError, nil))
                return
            }
            
            if let r = response as? HTTPURLResponse {
                switch r.statusCode{
                case 400:
                    completion(.failure(.badRequest, data))
                    break
                case 401:
                    completion(.failure(.unauthorized, data))
                    break
                case 200:
                    completion(.sucess(data))
                default:
                    break
                }
            }
            
            print(String(data: data, encoding: .utf8))
            print("response\n")
            print(response)
            
        }
        
        task.resume()
    }
    
    public static func call<T: Encodable> (path: Endpoint, body: T, completion: @escaping (Result) -> Void) {
        //linha abaixo realiza a requisicao
        guard let jsonData = try? JSONEncoder().encode(body) else { return }
        call(path: path, contentType: .json, data: jsonData, completion: completion)
    }
    
    public static func call(path: Endpoint,params: [URLQueryItem], completion: @escaping (Result) -> Void) {
        //linha abaixo realiza a requisicao
        guard let urlRequest = completeUrl(path: path) else { return }
        guard let absoluteURL = urlRequest.url?.absoluteString else { return }
        var components = URLComponents(string: absoluteURL)
        components?.queryItems = params
        call(path: path, contentType: .formUrl, data: components?.query?.data(using: .utf8), completion: completion)
    }
    
    
    static func postUser(request: SignUpRequest, completion: @escaping (Bool?, ErrorResponse?) -> Void){
        call(path: .postUser, body: request) { result in
            switch result {
            case .failure(let error, let data):
                if let data = data {
                    if error == .badRequest {
                        let decoder = JSONDecoder()
                        let response = try? decoder.decode(ErrorResponse.self, from: data)
                        print(response?.detail)
                        completion(nil, response)
                    }
                }
                break
            case .sucess(let data):
                completion(true, nil)
                print(String(data: data, encoding: .utf8))
                break
            }
        }
        
    }
}
