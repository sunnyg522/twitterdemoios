//
//  DetailsTweetViewController.swift
//  TwitterDemo
//
//  Created by Dinesh Gunda on 8/1/16.
//  Copyright © 2016 Dinesh Gunda. All rights reserved.
//

import UIKit

class DetailsTweetViewController: UIViewController {

    @IBAction func onBackButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBOutlet weak var likesCountLabel: UILabel!
    @IBOutlet weak var reTweetCountLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    var tweet: Tweet!
    override func viewDidLoad() {
        super.viewDidLoad()
        screenNameLabel.text = tweet.user?.screenname as? String
        userNameLabel.text = tweet.user?.name as? String
        tweetTextLabel.text = tweet.text
        profileImage.setImageWithURL(tweet.user.profileUrl!)
        if tweet.retweetCount != 0{
            reTweetCountLabel.text  = "\(tweet.retweetCount)"
        }else{
            reTweetCountLabel.text = ""
        }
        if tweet.retweetCount != 0{
            likesCountLabel.text = "\(tweet.favoritesCount)"
        }
        else
        {
            likesCountLabel.text = ""
        }
        profileImage.layer.cornerRadius = 3
        profileImage.clipsToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
