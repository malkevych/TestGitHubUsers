//
//  UsersModel.swift
//  TestGitHubUsers
//
//  Created by Malkevych Bohdan Ihorovych on 19.04.16.
//  Copyright © 2016 MB. All rights reserved.
//

import UIKit

class UsersModel: NSObject {
    
    typealias CompletionHandler = (success:Bool, error: NSError?) -> Void
    let USERS_PER_PAGE:Int = 100
    var users:Array<User> = Array<User>()
    
    internal func requestNextPortionOfUsers(handler:CompletionHandler) {
        UsersServiceLayer.loadUsersSince(lastLoadedIndex(), perPage: USERS_PER_PAGE) {[weak self] (portionOfUsers, error) -> Void in
            if self != nil && error == nil {
                self!.users.appendContentsOf(portionOfUsers)
                handler(success: true, error: nil)
            } else {
                handler(success: false, error: error)
            }
        }
    }
    
    
    //MARK: Helpers
    
    private func lastLoadedIndex() ->Int {
        return users.count
    }
    
}
