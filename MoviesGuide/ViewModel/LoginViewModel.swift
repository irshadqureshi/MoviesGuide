//
//  LoginViewModel.swift
//  MoviesGuide
//
//  Created by Irshad Qureshi on 18/10/2021.
//

import UIKit
import FBSDKLoginKit

protocol LoginProtocol: AnyObject {
    var view: LoginViewProtocol? {get set}
    func loginTapped()
}

class LoginViewModel: LoginProtocol {
    
    weak var view: LoginViewProtocol?
    
    init(view: LoginViewProtocol?) {
        self.view = view
    }
    
    func loginTapped() {
        guard let view = self.view as? LoginViewController else { return }
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [], from: view) { [weak self] (result, error) in
            guard error == nil else { return }
            guard let result = result, !result.isCancelled else { return }
            Profile.loadCurrentProfile { (profile, error) in
                self?.view?.navigateToDashboard(userName: Profile.current?.name ?? "")
            }
        }
    }
}
