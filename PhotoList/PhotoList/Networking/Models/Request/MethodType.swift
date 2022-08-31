//
//  MethodType.swift
//  PhotoList
//
//  Created by Marc Jardine Esperas on 8/30/22.
//

import Foundation

enum MethodType: String {
    case getRecent = "flickr.photos.getRecent"
    case search = "flickr.photos.search"
    case photoInfo = "flickr.photos.getInfo"
    case userProfile = "flickr.profile.getProfile"
    case userPhotos = "flickr.people.getPublicPhotos"
}
