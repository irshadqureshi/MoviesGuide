//
//  Globals.swift
//  MoviesGuide
//
//  Created by Irshad Qureshi on 16/10/2021.
//

import Foundation
import UIKit

@propertyWrapper struct Capitalized {
    var wrappedValue: String {
        didSet { wrappedValue = wrappedValue.capitalized }
    }

    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue.capitalized
    }
}

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

func loginViewController() -> UIViewController {
    let storyboard = UIStoryboard(name: "Login", bundle: nil)
    let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
    return loginViewController
}

func dashboardViewController(userName: String? = nil) -> UINavigationController {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let dashboardViewController = storyboard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
    dashboardViewController.userName = userName
    let navigationController:UINavigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        navigationController.viewControllers = [dashboardViewController]
    return navigationController
}
