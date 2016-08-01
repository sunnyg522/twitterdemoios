//
//  TweetTableViewCell.swift
//  TwitterDemo
//
//  Created by Dinesh Gunda on 7/31/16.
//  Copyright © 2016 Dinesh Gunda. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
  
    @IBOutlet weak var thumbImageView: UIImageView!
        var tweet: Tweet!{
        didSet{
            screenNameLabel.text = tweet.user?.screenname as? String
            userNameLabel.text = tweet.user?.name as? String
            tweetText.text = tweet.text
            let url = NSURL(fileURLWithPath: "http://pbs.twimg.com/profile_images/615598832726970372/jsK-gBSt_normal.png")
            thumbImageView.setImageWithURL(url)
            //thumbImageView.setImageWithURL(business!.imageURL!)
        }
  
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

   
}
