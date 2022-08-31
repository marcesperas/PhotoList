//
//  PhotoInfoRequest.swift
//  PhotoList
//
//  Created by Marc Jardine Esperas on 8/30/22.
//

import Foundation

// MARK: - PhotoInfoRequest
struct PhotoInfoRequest: RequestProtocol {
    let method: MethodType = .photoInfo
    let photoId: String
    let secret: String
    
    init(photoId: String,
         secret: String) {
        self.photoId = photoId
        self.secret = secret
    }
}

// MARK: - PhotoInfoRequest Extension
extension PhotoInfoRequest {
    var description: String {
        """
            method: \(method)
            apiKey: \(Constants.apiKey)
            photoId: \(photoId)
            secret: \(secret)
            format: \(format)
            noJsonCallback: \(noJsonCallback)
        """
    }
    
    func getParameters() -> [String: String] {
        let parameters: [String: String] = ["method": method.rawValue,
                                            "api_key": Constants.apiKey,
                                            "photo_id": photoId,
                                            "secret": secret,
                                            "format": format,
                                            "nojsoncallback": noJsonCallback]
        return parameters
    }
}
