//
//  PhotoRequest.swift
//  PhotoList
//
//  Created by Marc Jardine Esperas on 8/28/22.
//

import Foundation

// MARK: - PhotoRequest
struct PhotoRequest: RequestProtocol {
    let method: MethodType
    let searchText: String?
    
    init(method: MethodType = .getRecent,
         searchText: String? = nil) {
        self.method = method
        self.searchText = searchText
    }
}

// MARK: - PhotoRequest Extension
extension PhotoRequest {
    var description: String {
        """
            method: \(method)
            apiKey: \(Constants.apiKey)
            format: \(format)
            noJsonCallback: \(noJsonCallback)
            searchText: \(searchText ?? "Empty")
        """
    }
    
    func getParameters() -> [String: String] {
        var parameters: [String: String] = ["method": method.rawValue,
                                            "api_key": Constants.apiKey,
                                            "format": format,
                                            "nojsoncallback": noJsonCallback]
        
        if let searchText = searchText {
            parameters["text"] = searchText
        }
        
        return parameters
    }
}
