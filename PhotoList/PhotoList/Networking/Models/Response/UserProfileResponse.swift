//
//  UserProfileResponse.swift
//  PhotoList
//
//  Created by Marc Jardine Esperas on 8/30/22.
//

import Foundation

// MARK: - UserProfileResponse
struct UserProfileResponse: Codable {
    let profile: Profile
    let stat: String
}

// MARK: - Profile
struct Profile: Codable {
    let id, nsid: String
    let joinDate, occupation: String?
    let hometown, showcaseSet, showcaseSetTitle, firstName: String?
    let lastName, profileDescription: String?
    let website: String?
    let city, country, facebook, twitter: String?
    let tumblr, instagram, pinterest: String?

    enum CodingKeys: String, CodingKey {
        case id, nsid
        case joinDate = "join_date"
        case occupation, hometown
        case showcaseSet = "showcase_set"
        case showcaseSetTitle = "showcase_set_title"
        case firstName = "first_name"
        case lastName = "last_name"
        case profileDescription = "profile_description"
        case website, city, country, facebook, twitter, tumblr, instagram, pinterest
    }
}
