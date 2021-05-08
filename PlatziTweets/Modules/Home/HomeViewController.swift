//
//  HomeViewController.swift
//  PlatziTweets
//
//  Created by Jorge Lopez on 8/05/21.
//

import UIKit
import Simple_Networking
import SVProgressHUD
import NotificationBannerSwift

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let cellId = "TweetTableViewCell"
    private var dataSource = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getPosts()
    }
    
    private func setupUI() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    private func getPosts() {
        SVProgressHUD.show()
        
        SN.get(endpoint: Endpoints.getPosts) { (response: SNResultWithEntity<[Post], ErrorResponse>) in
            SVProgressHUD.dismiss()
            
            switch response {
            case .success(let posts):
                self.dataSource = posts
                self.tableView.reloadData()
                
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

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        if let cell = cell as? TweetTableViewCell {
            cell.setupCellWith(post: dataSource[indexPath.row])
        }
        
        return cell
    }
    
    
}
