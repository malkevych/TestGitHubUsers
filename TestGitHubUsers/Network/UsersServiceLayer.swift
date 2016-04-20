//
//  UsersServiceLayer.swift
//  TestGitHubUsers
//
//  Created by Malkevych Bohdan Ihorovych on 19.04.16.
//  Copyright © 2016 MB. All rights reserved.
//

import UIKit

class UsersServiceLayer: NSObject {
    
    typealias CompletionHandler = (portionOfUsers: Array<User>, error: NSError?) -> Void
    
    class func loadUsersSince(since:Int, perPage:Int, handler:CompletionHandler) {
        handler(portionOfUsers: [], error: nil)
    }

}
