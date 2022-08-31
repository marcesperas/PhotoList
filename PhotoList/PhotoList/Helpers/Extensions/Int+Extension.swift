//
//  Int+Extension.swift
//  PhotoList
//
//  Created by Marc Jardine Esperas on 8/31/22.
//

import Foundation

extension Int {
    func toDecimalString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let formattedNumber = numberFormatter.string(from: NSNumber(value: self)) else { return "" }
        
        return formattedNumber
    }
}
