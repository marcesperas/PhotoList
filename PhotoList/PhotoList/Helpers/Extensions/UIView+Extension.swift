//
//  UIView+Extension.swift
//  PhotoList
//
//  Created by Marc Jardine Esperas on 8/30/22.
//

import UIKit

extension UIView {
    func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 2.0
        layer.masksToBounds = false
    }
    
    func setRounded() {
        layer.borderWidth = 3
        layer.masksToBounds = false
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }

    func addCornerRadius() {
        layer.cornerRadius = 10
    }
}
