//
//  UserCell.swift
//  TestGitHubUsers
//
//  Created by Malkevych Bohdan Ihorovych on 22.04.16.
//  Copyright © 2016 MB. All rights reserved.
//

import UIKit
import SDWebImage

class UserCell: UITableViewCell {
    
    typealias TapAvatarHandler = (user:User) ->Void
    @IBOutlet weak var btnAvatar: UIButton!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var tvHtmlUrl: UITextView!
    var user:User?
    var tapAvatarHandler:TapAvatarHandler?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillCellWith(user:User) -> Void {
        self.user = user
        btnAvatar.sd_setBackgroundImageWithURL(user.getAvatarURL(), forState: .Normal, placeholderImage: UIImage(named: "no_avatar"))
        lblUsername.text = user.login
        tvHtmlUrl.text = user.htmlUrl
    }
    
    @IBAction func onTapOnUserAvatar(sender: AnyObject) {
        if let tapAvatarHandler = tapAvatarHandler {
            tapAvatarHandler(user: self.user!)
        }
    }
}
