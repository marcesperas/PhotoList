//
//  Double+Extension.swift
//  PhotoList
//
//  Created by Marc Jardine Esperas on 8/31/22.
//

import Foundation

extension Double {
    func unixDate() -> Date? {
        return NSDate(timeIntervalSince1970: self) as Date
    }
}
