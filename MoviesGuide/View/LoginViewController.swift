//
//  LoginViewController.swift
//  MoviesGuide
//
//  Created by Irshad Qureshi on 18/10/2021.
//

import UIKit
import FBSDKLoginKit

protocol LoginFlowHandler {
    func handleLogin(withWindow window: UIWindow?)
    func handleLogout(withWindow window: UIWindow?)
}

extension LoginFlowHandler {
    
    func handleLogin(withWindow window: UIWindow?) {
        if let _ = AccessToken.current {
            self.showMainApp(withWindow: window)
        } else {
            self.showLogin(withWindow: window)
        }
    }
    
    func handleLogout(withWindow window: UIWindow?) {
        let loginManager = LoginManager()
        loginManager.logOut()
        showLogin(withWindow: window)
    }
    
    func showLogin(withWindow window: UIWindow?) {
        guard let window = window else { return }
        window.subviews.forEach { $0.removeFromSuperview() }
        window.rootViewController = nil
        window.rootViewController = loginViewController()
        window.makeKeyAndVisible()
    }
    
    func showMainApp(withWindow window: UIWindow?) {
        guard let window = window else { return }
        window.rootViewController = nil
        window.rootViewController = dashboardViewController()
        window.makeKeyAndVisible()
    }
}

protocol LoginViewProtocol: AnyObject {
    func navigateToDashboard(userName: String)
}

class LoginViewController: BaseViewController {
 
    @IBOutlet weak var titleLabel: UILabel!
    
    lazy var viewModel:LoginProtocol = LoginViewModel(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    func setUpViews() {
        titleLabel.textDropShadow()
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        viewModel.loginTapped()
    }
}

typealias LoginRouter = LoginViewController
extension LoginRouter: LoginViewProtocol {
    func navigateToDashboard(userName: String){
        UIApplication.shared.keyWindow?.rootViewController = dashboardViewController(userName: userName)
        self.present(dashboardViewController(userName: userName), animated: true, completion: nil)
    }
}
