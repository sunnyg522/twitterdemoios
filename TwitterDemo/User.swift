//
//  User.swift
//  TwitterDemo
//
//  Created by Dinesh Gunda on 7/30/16.
//  Copyright © 2016 Dinesh Gunda. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: NSString?
    var screenname: NSString?
    var profileUrl: NSURL?
    var tagLine: NSString?
    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary)
    {
        self.dictionary = dictionary
        name = dictionary["name"] as? NSString
        screenname = dictionary["screen_name"] as? NSString
        let profileUrlString = dictionary["profile_image_url"] as? String
        if let profileUrlString = profileUrlString{ 
            profileUrl = NSURL(string: profileUrlString)
        }
        
        tagLine = dictionary["description"] as? NSString
    }
    static let userDidLogOutNotification = "UserDidLogout"
    static var _currentUser: User?
    
    class var currentUser: User?
    {
        get{
            if _currentUser == nil{
            let defaults = NSUserDefaults.standardUserDefaults()
            let userData = defaults.objectForKey("currentnameData") as? NSData
            if let userData = userData
            {
                  let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
                  _currentUser = User(dictionary: dictionary)
                
            }
                
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            let defaults = NSUserDefaults.standardUserDefaults()
            if let user = user {
                let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                
                defaults.setObject(data, forKey: "currentnameData")
            }else
            {
                defaults.setObject(nil, forKey: "currentnameData")
            }
            
            defaults.synchronize()
        }
        }
    

}
