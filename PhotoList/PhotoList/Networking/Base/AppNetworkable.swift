//
//  AppNetworkable.swift
//  PhotoList
//
//  Created by Marc Jardine Esperas on 8/28/22.
//

import Foundation

public enum RequestType : String {
    /// HTTP GET request
    case GET
    /// HTTP POST request
    case POST
}

public protocol AppNetworkable {
    /// `URLRequest` of the request.
    var request: URLRequest { get }
}

public extension AppNetworkable {
    func getRequest(with path: String, parameters: [String: String]?, httpMethod: RequestType) -> URLRequest {
        guard var components = URLComponents(url: API.getURL(with: path), resolvingAgainstBaseURL: true) else {
            return URLRequest(url: API.getURL(with: path))
        }
        
        components.queryItems = parameters?.map({ (key, value) in
            URLQueryItem(name: key, value: value)
        })
        
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        let request = URLRequest(url: components.url!)
        return request
    }
    
    func fetchResponse<V: Decodable>(completion: @escaping ((Result<V, NetworkError>) -> Void)) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(.failure(.unableToCompleteRequest))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.invalidData))
                    return
                }
                
                print("The response is: ", String(data: data, encoding: .utf8)!)
                
                do {
                    if let failureResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                        completion(.failure(.errorResponse(failureResponse)))
                        return
                    }
                
                    let result = try JSONDecoder().decode(V.self, from: data)
                    completion(.success(result))
                    
                } catch let error {
                    print("JSON Decode Error: \(error)")
                    completion(.failure(.jsonDecodingError))
                }
            }
        }
        task.resume()
    }
}
