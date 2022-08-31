//
//  DataProvider.swift
//  PhotoList
//
//  Created by Marc Jardine Esperas on 8/28/22.
//

import Foundation

protocol DataProviderProtocol: AnyObject {
    func fetchRecentPhotos(request: PhotoRequest, completion: @escaping ((Result<PhotoResponse, NetworkError>) -> Void))
    func searchPhotos(request: PhotoRequest, completion: @escaping ((Result<PhotoResponse, NetworkError>) -> Void))
    func fetchPhotoInfo(request: PhotoInfoRequest, completion: @escaping ((Result<PhotoInfoResponse, NetworkError>) -> Void))
    func fetchUserProfile(request: UserProfileRequest, completion: @escaping ((Result<UserProfileResponse, NetworkError>) -> Void))
    func fetchUserPhoto(request: UserPhotoRequest, completion: @escaping ((Result<UserPhotoResponse, NetworkError>) -> Void))
}

public class DataProvider: DataProviderProtocol {
    public init() {}
    
    func fetchRecentPhotos(request: PhotoRequest, completion: @escaping ((Result<PhotoResponse, NetworkError>) -> Void)) {
        API.Photo.recent(request: request).fetchResponse(completion: completion)
    }
    
    func searchPhotos(request: PhotoRequest, completion: @escaping ((Result<PhotoResponse, NetworkError>) -> Void)) {
        API.Photo.search(request: request).fetchResponse(completion: completion)
    }
    
    func fetchPhotoInfo(request: PhotoInfoRequest, completion: @escaping ((Result<PhotoInfoResponse, NetworkError>) -> Void)) {
        API.Photo.photoInfo(request: request).fetchResponse(completion: completion)
    }
    
    func fetchUserProfile(request: UserProfileRequest, completion: @escaping ((Result<UserProfileResponse, NetworkError>) -> Void)) {
        API.Photo.userProfile(request: request).fetchResponse(completion: completion)
    }
    
    func fetchUserPhoto(request: UserPhotoRequest, completion: @escaping ((Result<UserPhotoResponse, NetworkError>) -> Void)) {
        API.Photo.userPhoto(request: request).fetchResponse(completion: completion)
    }
}
