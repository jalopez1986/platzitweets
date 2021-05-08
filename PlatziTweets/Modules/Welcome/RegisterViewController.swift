//
//  RegisterViewController.swift
//  PlatziTweets
//
//  Created by Jorge Lopez on 3/05/21.
//

import UIKit
import NotificationBannerSwift
import Simple_Networking
import SVProgressHUD

class RegisterViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBAction func registerButtonAction() {
        view.endEditing(true)
        performRegister()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        registerButton.layer.cornerRadius = 25
    }
    
    private func performRegister() {
        guard let email = emailTextField.text, !email.isEmpty else {
            NotificationBanner(title: "Error", subtitle: "Debes especificar un correo", style: .warning).show()
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            NotificationBanner(title: "Error", subtitle: "Debes especificar una contraseña.", style: .warning).show()
            return
        }
        
        guard let names = nameTextField.text, !names.isEmpty else {
            NotificationBanner(title: "Error", subtitle: "Debes especificar tu nombre y apellido", style: .warning).show()
            return
        }
        
        let request = RegisterRequest(email: email, password: password, names: names)
        
        SVProgressHUD.show()
        
        SN.post(endpoint: Endpoints.register, model: request) { (response: SNResultWithEntity<LoginResponde, ErrorResponse>) in
            
            SVProgressHUD.dismiss()
            
            switch response {
            case .success(let user):
                //NotificationBanner(subtitle: "Bienvenido \(user.user.names)", style: .success).show()
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
