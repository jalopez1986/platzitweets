//
//  LoginViewController.swift
//  PlatziTweets
//
//  Created by Jorge Lopez on 3/05/21.
//

import UIKit
import NotificationBannerSwift
import Simple_Networking
import SVProgressHUD

class LoginViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: -IBActions
    @IBAction func LoginButtonAction() {
        view.endEditing(true)
        performLogin()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    //MARK: - Private Methods
    
    private func setupUI() {
        loginButton.layer.cornerRadius = 25
    }
    
    private func performLogin() {
        guard let email = emailTextField.text, !email.isEmpty else {
            NotificationBanner(title: "Error", subtitle: "Debes especificar un correo", style: .warning).show()
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            NotificationBanner(title: "Error", subtitle: "Debes especificar una contraseña.", style: .warning).show()
            return
        }
        
        let request = LoginRequest(email: email, password: password)
        
        SVProgressHUD.show()
        
        SN.post(endpoint: Endpoints.login, model: request) { (response: SNResultWithEntity<LoginResponde, ErrorResponse>) in
            
            SVProgressHUD.dismiss()
            
            switch response {
            case .success(let user):
                //NotificationBanner(subtitle: "Bienvenido \(user.user.names)", style: .success).show()
                SimpleNetworking.setAuthenticationHeader(prefix: "", token: user.token)
                self.performSegue(withIdentifier: "showHome", sender: nil)
                
            case .error(let error):
                NotificationBanner(subtitle: "Error: \(error.localizedDescription)", style: .danger).show()
                return
                
            case .errorResult(let entity):
                NotificationBanner(subtitle: "Error Result: \(entity.error)", style: .danger).show()
                return
                
            }
            
        }
    }
}
