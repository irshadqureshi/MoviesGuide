//
//  BaseViewController.swift
//  MoviesGuide
//
//  Created by Irshad Qureshi on 16/10/2021.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    public func showAlertMessage(vc: UIViewController, title: String?, message: String?, actionTitles:[String?], actions:[((UIAlertAction) -> Void)?]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions[index])
            alert.addAction(action)
        }
        vc.present(alert, animated: true, completion: nil)
    }

}
