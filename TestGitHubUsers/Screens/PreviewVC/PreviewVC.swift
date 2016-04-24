//
//  PreviewVC.swift
//  TestGitHubUsers
//
//  Created by Malkevych Bohdan Ihorovych on 24.04.16.
//  Copyright © 2016 MB. All rights reserved.
//

import UIKit
import SDWebImage

class PreviewVC: UIViewController {
    
    
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var btnDismiss: UIButton!
    var user:User?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureDismissBtn()
        if let user = user {
            imgAvatar.sd_setImageWithURL(user.getAvatarURL())
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTouchDismiss(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func configureDismissBtn() {
        btnDismiss.layer.cornerRadius = 4
        btnDismiss.layer.borderColor = btnDismiss.titleLabel?.textColor.CGColor
        btnDismiss.layer.borderWidth = 1.2
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
