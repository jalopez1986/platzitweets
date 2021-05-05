//
//  WelcomeViewController.swift
//  PlatziTweets
//
//  Created by Jorge Lopez on 3/05/21.
//

import UIKit

class WelcomeViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - IBAction

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        loginButton.layer.cornerRadius = 25
        
    }
    


    

}
