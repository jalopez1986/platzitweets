//
//  AddPostViewController.swift
//  PlatziTweets
//
//  Created by Jorge Lopez on 8/05/21.
//

import UIKit

class AddPostViewController: UIViewController {
    @IBOutlet weak var postTextView: UITextView!
    
    @IBAction func AddPostAction() {
    }
    
    @IBAction func dismissAction() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}