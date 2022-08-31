//
//  RequestProtocol+Extension.swift
//  PhotoList
//
//  Created by Marc Jardine Esperas on 8/31/22.
//

import Foundation

protocol RequestProtocol {
    var format: String { get }
    var noJsonCallback: String { get }
}

extension RequestProtocol {
    var format: String {
        return "json"
    }
    
    var noJsonCallback: String {
        return "1"
    }
}
