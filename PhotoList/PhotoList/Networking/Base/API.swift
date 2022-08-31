//
//  API.swift
//  PhotoList
//
//  Created by Marc Jardine Esperas on 8/28/22.
//

import Foundation

enum API {
    static func getURL(with path: String = "") -> URL {
        return URL(string: ("https://www.flickr.com\(path)"))!
    }
}
