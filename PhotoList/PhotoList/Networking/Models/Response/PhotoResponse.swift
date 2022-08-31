//
//  PhotoResponse.swift
//  PhotoList
//
//  Created by Marc Jardine Esperas on 8/28/22.
//

import Foundation

// MARK: - PhotoResponse
struct PhotoResponse: Codable {
    let photos: Photos
    let stat: String
}

// MARK: - Photos
struct Photos: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photo: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
}

extension Photo {
    var profileImageUrl: URL? {
        let url = URL(string: "https://farm\(farm).staticflickr.com/\(server)/buddyicons/\(owner).jpg")
        return url
    }
    
    var coverPhotoUrl: URL? {
        let url = URL(string: "https://farm\(farm).staticflickr.com/\(server)/coverphoto/\(owner).jpg")
        return url
    }
    
    var photoUrl: URL? {
        let url = URL(string: "https://farm\(farm).static.flickr.com/\(server)/\(id)_\(secret).jpg")
        return url
    }
}
