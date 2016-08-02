//
//  TweetViewViewController.swift
//  TwitterDemo
//
//  Created by Dinesh Gunda on 7/30/16.
//  Copyright © 2016 Dinesh Gunda. All rights reserved.
//

import UIKit



class TweetViewViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   

    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.rowHeight = UITableViewAutomaticDimension
        //tableView.estimatedRowHeight = 102
        
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        TwitterClient.sharedInstance.homeTimeLine({ (tweets:[Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
            for tweet in tweets
            {
                //print(tweet.text)
                //print(tweet.text)
                //print(tweet.user?.profileUrl)
            }
            
        }) { (error:NSError) in
                print("Error:\(error.localizedDescription)")
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath)as! TweetTableViewCell
        cell.tweet = tweets[indexPath.row]
                return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tweets != nil
        {
            return tweets.count
        }
        else{
            return 0;
        }
        
    }

    @IBAction func onLogOutButton(sender: AnyObject) {
    TwitterClient.sharedInstance.logout()
    }
    
//    func onRefresh() {
//        print("Begining of on refresh")
//        TwitterClient.sharedInstance.homeTimeLine({ (tweets:[Tweet]) in
//            self.tweets = tweets
//            self.tableView.reloadData()
//            print("Inside reloading")
//            for tweet in tweets
//            {
//                //print(tweet.text)
//                //print(tweet.text)
//                //print(tweet.user?.profileUrl)
//            }
//            
//        }) { (error:NSError) in
//            print("Error:\(error.localizedDescription)")
//        }
//        delay(2, closure: {
//            self.refreshControl.endRefreshing()
//        })
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailTweetViewSegue"{
            print("insider Detail View Seguea")
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell);
            let tweet = tweets![indexPath!.row]
                print(tweet.text)
            let tweetDetailViewController = segue.destinationViewController as! DetailsTweetViewController
            tweetDetailViewController.tweet = tweet
        }else if segue.identifier == "composeViewController"
        {
            segue.destinationViewController as! ComposeTweetViewController
        }
        
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        TwitterClient.sharedInstance.homeTimeLine({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            refreshControl.endRefreshing()
//            for tweet in tweets{
//                print(tweet.text)
//            }
            
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
        })
        
        
        
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        let navigationController = segue.destinationViewController as! UINavigationController
//        let composeTweetController = navigationController.topViewController as! ComposeTweetViewController
//       // composeTweetController.delegate = self
//        
//    }
    
}
