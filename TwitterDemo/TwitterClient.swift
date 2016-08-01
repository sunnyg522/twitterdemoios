//
//  TwitterClient.swift
//  TwitterDemo
//
//  Created by Dinesh Gunda on 7/30/16.
//  Copyright © 2016 Dinesh Gunda. All rights reserved.
//

import UIKit
import BDBOAuth1Manager 

class TwitterClient: BDBOAuth1SessionManager {

    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com"), consumerKey: "nKIit9K0zNNYy4eDxjLEDtxHe", consumerSecret: "OWvuHdCTN15wbfaGuMomF79sWGqmmuc1jrXV4BkGCmmm86iRyy")
    
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError)->())?
    
    func homeTimeLine(success: ([Tweet]) -> (), failure: (NSError)-> () )
    {
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) in
            
            let dicts = response as![NSDictionary]
            let tweets = Tweet.tweetsWithArray(dicts)
            //print(response)
            
            success(tweets)
            
            }, failure: { (taks: NSURLSessionDataTask?, error: NSError) in
                failure(error)
        })

        

    }
    func currentAccount(success: (User)-> (), failure: (NSError) -> ())
    {
        
        
        GET("1.1/account/verify_credentials.json", parameters: nil,progress: nil, success: { (taks: NSURLSessionDataTask, response: AnyObject?) in
            print("account : \(response)")
            
            let userDict = response as! NSDictionary
            let user = User(dictionary: userDict)
            print(response)
            
            success(user)
           // print("user: \(user.name)")
           // print("ScreenName: \(user.screenname)")
            
            
            }, failure: { (taks: NSURLSessionDataTask?, error: NSError) in
                failure(error)
        })
            }
    
    func login(success: ()->(), failure: (NSError)->())
    {
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.deauthorize()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterdemo://oauth"), scope: nil , success: { (requestToken:BDBOAuth1Credential!) in
            print("I got one token")
            print("request token : \(requestToken.token)")
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(url!)
            
            
        }) { (error: NSError!) in
            print("error\(error.localizedDescription )")
            self.loginFailure?(error )
        }

    }
    
    func logout()
    {
        User.currentUser = nil
        deauthorize()
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogOutNotification, object: nil)
    }
    
    func handleOpenurl(url: NSURL)
    {
         let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential!) in
            print("I got access token")
                
            self.currentAccount({ (user: User) in
                User.currentUser = user
                self.loginSuccess?()
                }, failure: { (error: NSError) in
                    self.loginFailure?(error)
            })
            
            
//            TwitterClient.sharedInstance.currentAccount()
//            TwitterClient.sharedInstance .homeTimeLine({ (tweets:[Tweet]) in
//                for tweet in tweets
//                {
//                    print(tweet.text)
//                }
//            }) { (error:NSError) in
//                print("\(error.localizedDescription)")
//            }
            
            
        }) { (error: NSError!) in
            print("error \(error.localizedDescription)")
            self.loginFailure?(error )
        }
    }
}
