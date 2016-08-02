//
//  ComposeTweetViewController.swift
//  TwitterDemo
//
//  Created by Dinesh Gunda on 8/1/16.
//  Copyright © 2016 Dinesh Gunda. All rights reserved.
//

import UIKit

@objc protocol ComposeTweetViewControllerDelegate {
    optional func composeViewController(composeViewController: ComposeTweetViewController, didUpdateTweet tweets: [String: AnyObject] )
}

class ComposeTweetViewController: UIViewController {

    @IBOutlet weak var tweetViewText: UITextView!
    @IBOutlet weak var profileImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.setImageWithURL((User.currentUser?.profileUrl)!)
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
