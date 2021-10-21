//
//  AppDelegate+Extension.swift
//  MoviesGuide
//
//  Created by Irshad Qureshi on 19/10/2021.
//

import Foundation
import UIKit

extension UIApplication {
    
    var keyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
    }
    
}
