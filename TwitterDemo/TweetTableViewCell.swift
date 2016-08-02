//
//  TweetTableViewCell.swift
//  TwitterDemo
//
//  Created by Dinesh Gunda on 7/31/16.
//  Copyright © 2016 Dinesh Gunda. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var tweetCount: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBAction func onRetweetImage(sender: AnyObject) {
    }
  
    @IBOutlet weak var replyTweetButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var thumImage: UIImageView!
        var tweet: Tweet!{
        didSet{
            screenNameLabel.text = tweet.user?.screenname as? String
            userNameLabel.text = tweet.user?.name as? String
            tweetText.text = tweet.text
            thumImage.setImageWithURL(tweet.user.profileUrl!)
            if tweet.retweetCount != 0{
            tweetCount.text  = "\(tweet.retweetCount)"
            }else{
                tweetCount.text = ""
            }
            if tweet.retweetCount != 0{
                likesCountLabel.text = "\(tweet.favoritesCount)"
            }
            else
            {
                likesCountLabel.text = ""
            }
            
//            retweetButton.setImage(UIImage(named: "retweet"), forState: UIControlState.Normal)
//            replyTweetButton.setImage(UIImage(named: "retweet"), forState: UIControlState.Normal)
        }
  
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        thumImage.layer.cornerRadius = 3
        thumImage.clipsToBounds = true
        
        tweetText.preferredMaxLayoutWidth = tweetText.frame.size.width
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

   
}
