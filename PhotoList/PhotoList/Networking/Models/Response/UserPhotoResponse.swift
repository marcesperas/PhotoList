//
//  UserPhotoResponse.swift
//  PhotoList
//
//  Created by Marc Jardine Esperas on 8/31/22.
//

import Foundation

// MARK: - UserPhotoResponse
struct UserPhotoResponse: Codable {
    let userPhotos: UserPhotos
    let stat: String
    
    enum CodingKeys: String, CodingKey {
        case userPhotos = "photos"
        case stat
    }
}

// MARK: - Photos
struct UserPhotos: Codable {
    let page, pages, perpage, total: Int
    let photoList: [UserPhoto]
    
    enum CodingKeys: String, CodingKey {
        case page, pages, perpage, total
        case photoList = "photo"
    }
}

// MARK: - Photo
struct UserPhoto: Codable {
    let id: String
    let owner: String
    let secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
}

// MARK: - UserPhoto Extension
extension UserPhoto {
    var userPhotoUrl: URL {
        return URL(string: "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg")!
    }
}
