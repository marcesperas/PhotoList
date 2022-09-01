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
    let photoList: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case page, pages, perpage, total
        case photoList = "photo"
    }
}
