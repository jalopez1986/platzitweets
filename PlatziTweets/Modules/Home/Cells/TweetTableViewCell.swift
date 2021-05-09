//
//  TweetTableViewCell.swift
//  PlatziTweets
//
//  Created by Jorge Lopez on 8/05/21.
//

import UIKit
import Kingfisher

class TweetTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var videoButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    //NOTA IMPORTANTE
    //Las celdas NUNCA deben invocar ViewControllers
    
    private var videoURL: URL?
    var needsToShowVideo: ((_ url: URL) -> Void)?
    
    @IBAction func ShowVideo() {
        guard let videoUrl = videoURL else {
            return
        }
        
        needsToShowVideo?(videoUrl)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCellWith(post: Post) {
        videoButton.isHidden = !post.hasVideo
        nameLabel.text = post.author.names
        nicknameLabel.text = post.author.nickname
        messageLabel.text = post.text
        
        if (post.hasImage) {
            tweetImageView.isHidden = false
            tweetImageView.kf.setImage(with: URL(string: post.imageUrl))
        } else {
            tweetImageView.isHidden = true
        }
        
        videoURL = URL(string: post.videoUrl)
        
    }
    
}
