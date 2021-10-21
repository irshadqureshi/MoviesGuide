//
//  UILabel+Extension.swift
//  MoviesGuide
//
//  Created by Irshad Qureshi on 16/10/2021.
//

import Foundation
import UIKit

extension UILabel {
    func textDropShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
    }
}
