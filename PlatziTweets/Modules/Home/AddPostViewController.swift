//
//  AddPostViewController.swift
//  PlatziTweets
//
//  Created by Jorge Lopez on 8/05/21.
//

import UIKit
import Simple_Networking
import SVProgressHUD
import NotificationBannerSwift

class AddPostViewController: UIViewController {
    @IBOutlet weak var postTextView: UITextView!
    
    @IBAction func AddPostAction() {
        savePost()
    }
    
    @IBAction func dismissAction() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func savePost() {
        guard let post = postTextView.text, !post.isEmpty else {
            NotificationBanner(title: "Error", subtitle: "Debes especificar un post", style: .warning).show()
            return
        }
        
        let request = PostRequest(text: post, imageUrl: nil, videoUrl: nil, location: nil)
        
        SVProgressHUD.show()
        
        SN.post(endpoint: Endpoints.post, model: request) { (response: SNResultWithEntity<Post, ErrorResponse>) in
            
            SVProgressHUD.dismiss()
            
            switch response {
            case .success:
                self.dismiss(animated: true, completion: nil)
                
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
