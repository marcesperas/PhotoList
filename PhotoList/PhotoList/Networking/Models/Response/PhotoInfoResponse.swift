//
//  PhotoInfoResponse.swift
//  PhotoList
//
//  Created by Marc Jardine Esperas on 8/30/22.
//

import Foundation

// MARK: - Welcome
struct PhotoInfoResponse: Codable {
    let photoInfo: PhotoInfo
    let stat: String
    
    enum CodingKeys: String, CodingKey {
        case photoInfo = "photo"
        case stat
    }
}

// MARK: - Photo
struct PhotoInfo: Codable {
    let id, secret, server: String?
    let farm: Int?
    let dateuploaded: String?
    let isfavorite: Int?
    let owner: Owner?
    let title, photoDescription: Description?
    let dates: Dates?
    let views: String?
    let tags: Tags?
    let urls: Urls?
    let media: String?

    enum CodingKeys: String, CodingKey {
        case id, secret, server, farm, dateuploaded, isfavorite
        case owner, title
        case photoDescription = "description"
        case dates, views, tags, urls, media
    }
}

// MARK: - Description
struct Description: Codable {
    let content: String?

    enum CodingKeys: String, CodingKey {
        case content = "_content"
    }
}

// MARK: - Dates
struct Dates: Codable {
    let posted, taken: String?
    let takengranularity: Int?
    let takenunknown, lastupdate: String?
}

// MARK: - Owner
struct Owner: Codable {
    let nsid, username, realname, location: String?
    let iconserver: String?
    let iconfarm: Int?
    let pathAlias: String?

    enum CodingKeys: String, CodingKey {
        case nsid, username, realname, location, iconserver, iconfarm
        case pathAlias = "path_alias"
    }
}

// MARK: - Tags
struct Tags: Codable {
    let tag: [Tag]?
}

// MARK: - Tag
struct Tag: Codable {
    
}

// MARK: - Urls
struct Urls: Codable {
    let url: [URLElement]?
}

// MARK: - URLElement
struct URLElement: Codable {
    let type: String?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case type
        case content = "_content"
    }
}
