//
//  UsersModel.swift
//  TestGitHubUsers
//
//  Created by Malkevych Bohdan Ihorovych on 19.04.16.
//  Copyright © 2016 MB. All rights reserved.
//

import UIKit

class UsersModel: NSObject {
    
    typealias CompletionHandler = (success:Bool, indexPaths:[NSIndexPath]?, error: NSError?) -> Void
    let usersPerPage:Int = 100
    var users:Array<User> = Array<User>()
    var countPortionsLoaded:Int = 0
    
    internal func requestNextPortionOfUsers(needRefresh isRefresh:Bool, handler:CompletionHandler) {
        var userId:Int? = lastLoadedUserId()
        if isRefresh {
            userId = nil
        }
        UsersServiceLayer.loadUsersSince(userId, perPage: usersPerPage) {[weak self]
            (portionOfUsers, error) -> Void in
            if self != nil && error == nil {
                if isRefresh {
                    self!.clearModel()
                }
                self!.users.appendContentsOf(portionOfUsers)
                self!.countPortionsLoaded += 1
                handler(success: true, indexPaths: self!.getIndexPathsFor(portionOfUsers), error: nil)
            } else {
                handler(success: false, indexPaths: nil, error: error)
            }
        }
    }
    
    internal func clearModel() {
        users = Array<User>()
        countPortionsLoaded = 0
    }
    
    
    //MARK: Helpers
    
    private func lastLoadedUserId() -> Int? {
        if let user:User = users.last {
            return user.id
        } else {
            return nil
        }
    }
    
    private func getIndexPathsFor(userPortion:Array<User>) -> Array<NSIndexPath> {
        var indexPaths:Array<NSIndexPath> = Array()
        indexPaths.reserveCapacity(userPortion.count)
        var index:Int = users.count - 1
        for _ in userPortion {
            indexPaths.append(NSIndexPath(forRow: index, inSection: 0))
            index -= 1
        }
        return indexPaths
    }
    
}
