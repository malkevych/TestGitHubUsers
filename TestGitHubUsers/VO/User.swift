//
//  User.swift
//  TestGitHubUsers
//
//  Created by Malkevych Bohdan Ihorovych on 19.04.16.
//  Copyright © 2016 MB. All rights reserved.
//

import UIKit
import Gloss

class User: NSObject, Decodable {
    
    var id:Int
    var login:String
    var htmlUrl:String
    var avatarUrl:String?
    
    required init?(json: JSON) {
        
        guard let id: Int = "id" <~~ json else { return nil }
        self.id = id
        
        guard let login: String = "login" <~~ json else { return nil }
        self.login = login
        
        guard let htmlUrl: String = "html_url" <~~ json else { return nil }
        self.htmlUrl = htmlUrl
        
        self.avatarUrl = "avatar_url" <~~ json
    }
    
    internal func getAvatarURL() ->NSURL? {
        if let avatarUrl = avatarUrl {
            return NSURL(string: avatarUrl)
        }
        return nil
    }
    
}
