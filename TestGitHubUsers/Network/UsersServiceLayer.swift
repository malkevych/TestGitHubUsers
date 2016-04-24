//
//  UsersServiceLayer.swift
//  TestGitHubUsers
//
//  Created by Malkevych Bohdan Ihorovych on 19.04.16.
//  Copyright © 2016 MB. All rights reserved.
//

import UIKit
import Alamofire
import Gloss

class UsersServiceLayer: NSObject {
    
    typealias CompletionHandler = (portionOfUsers: Array<User>, error: NSError?) -> Void
    
    class func loadUsersSince(since:Int?, perPage:Int, handler:CompletionHandler) {
        var parameters:Dictionary<String,Int> = Dictionary()
        if let since = since {
            parameters["since"] = since
        }
        parameters["per_page"] = perPage
        
        Alamofire.request(.GET, "https://api.github.com/users", parameters:parameters)
            .responseJSON { response in
//                debugPrint(response)
                if let response = response.result.value as? [JSON] {
                    let users = [User].fromJSONArray(response)
                    handler(portionOfUsers: users, error: nil)
                } else {
                    handler(portionOfUsers: [], error: response.result.error)
                }
        }
    }

}
