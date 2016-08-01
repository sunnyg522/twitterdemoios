//
//  Tweet.swift
//  TwitterDemo
//
//  Created by Dinesh Gunda on 7/30/16.
//  Copyright © 2016 Dinesh Gunda. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: String?
    var timeStamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount:Int = 0
    var user: User!
    
    init(dictionary: NSDictionary)
    {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        let userDict = (dictionary["user"]as! NSDictionary)
        user = User(dictionary: userDict)
        
        let timeStampString = dictionary["created_at"] as? String
        
        
        
        let formatter = NSDateFormatter()
        formatter.dateFormat  = "EEE MMM d HH:mm:ss Z y"
        
        if let timeStampString = timeStampString{
        timeStamp = formatter.dateFromString(timeStampString)
        }
        
    }
    class func tweetsWithArray(dictionaries: [NSDictionary])-> [Tweet]
    {
        var tweets = [Tweet]()
        for dictionary in dictionaries
        {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }

}
