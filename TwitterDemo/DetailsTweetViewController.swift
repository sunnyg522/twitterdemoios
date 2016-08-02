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
  
    @IBOutlet weak var profileImageLabel: UIImageView!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var screenNameLable: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var tweet: Tweet!
    override func viewDidLoad() {
        super.viewDidLoad()
        screenNameLable.text = tweet.user?.screenname as? String
        userNameLabel.text = tweet.user?.name as? String
        tweetTextLabel.text = tweet.text
        profileImageLabel.setImageWithURL(tweet.user.profileUrl!)
        if tweet.retweetCount != 0{
            tweetCountLabel.text  = "\(tweet.retweetCount)"
        }else{
            tweetCountLabel.text = ""
        }
        if tweet.retweetCount != 0{
            likeCountLabel.text = "\(tweet.favoritesCount)"
        }
        else
        {
            likeCountLabel.text = ""
        }

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
