//
//  UserPhotoRequest.swift
//  PhotoList
//
//  Created by Marc Jardine Esperas on 8/31/22.
//

import Foundation

// MARK: - UserProfileRequest
struct UserPhotoRequest: RequestProtocol {
    let method: MethodType = .userPhotos
    let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
}

// MARK: - UserProfileRequest Extension
extension UserPhotoRequest {
    var description: String {
        """
            method: \(method)
            apiKey: \(Constants.apiKey)
            userId: \(userId)
            format: \(format)
            noJsonCallback: \(noJsonCallback)
        """
    }
    
    func getParameters() -> [String: String] {
        let parameters: [String: String] = ["method": method.rawValue,
                                            "api_key": Constants.apiKey,
                                            "user_id": userId,
                                            "format": format,
                                            "nojsoncallback": noJsonCallback]
        return parameters
    }
}
