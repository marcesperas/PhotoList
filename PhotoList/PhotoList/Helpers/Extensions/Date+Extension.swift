//
//  Date+Extension.swift
//  PhotoList
//
//  Created by Marc Jardine Esperas on 8/30/22.
//

import Foundation

extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
