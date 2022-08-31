//
//  Photo.swift
//  PhotoList
//
//  Created by Marc Jardine Esperas on 8/28/22.
//

import Foundation

extension API {
    enum Photo: AppNetworkable {
        case recent(request: PhotoRequest)
        case search(request: PhotoRequest)
        case photoInfo(request: PhotoInfoRequest)
        case userProfile(request: UserProfileRequest)
        case userPhoto(request: UserPhotoRequest)
        
        public var request: URLRequest {
            switch self {
                case let .recent(request), let .search(request):
                    return getRequest(with: "/services/rest", parameters: request.getParameters(), httpMethod: .GET)
                case let .photoInfo(request):
                    return getRequest(with: "/services/rest", parameters: request.getParameters(), httpMethod: .GET)
                case let .userProfile(request):
                    return getRequest(with: "/services/rest", parameters: request.getParameters(), httpMethod: .GET)
                case let .userPhoto(request):
                    return getRequest(with: "/services/rest", parameters: request.getParameters(), httpMethod: .GET)
            }
        }
    }
}
