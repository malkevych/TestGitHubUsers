//
//  UserListTVC.swift
//  TestGitHubUsers
//
//  Created by Malkevych Bohdan Ihorovych on 19.04.16.
//  Copyright © 2016 MB. All rights reserved.
//

import UIKit
import SVProgressHUD

class UserListTVC: UITableViewController {
    
    let model:UsersModel = UsersModel()
    let userCellIdentifier:String = "UserCell"
    let loadingCellIdentifier:String = "LoadingCell"
    let heightDataCell:CGFloat = 116
    let heightLoadingCell:CGFloat = 44
    
    private enum SectionType: Int {
        case Data
        case Loader
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = true
        self.loadNextUsers(needRefresh: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onNeedRefresh(sender: AnyObject) {
        loadNextUsers(needRefresh: true)
    }
    
    private func loadNextUsers(needRefresh isRefresh:Bool) {
        model.requestNextPortionOfUsers(needRefresh: isRefresh) {[weak self] (success, indexPaths, error) in
            if self == nil {return}
            if success {
                self!.addToTableUsersWith(indexPaths!)
            } else {
                SVProgressHUD.showErrorWithStatus(error?.localizedDescription)
                self!.tableView.reloadData()
            }
            NSNotificationCenter.defaultCenter()
                .postNotificationName(Constants.kNCLoadingFinished, object: nil)
            self!.refreshControl?.endRefreshing()
        }
    }

    // MARK: - UITableViewDataSource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == SectionType.Data.rawValue {
            return model.users.count
        } else {
            return isNeedShowLoadingCell() ? 1 : 0
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == SectionType.Data.rawValue {
            return configureDataCell(indexPath)
        } else {
            return configureLoadingCell(indexPath)
        }
    }
    
    private func configureDataCell(indexPath:NSIndexPath) ->UITableViewCell {
        let cell:UserCell = tableView.dequeueReusableCellWithIdentifier(userCellIdentifier, forIndexPath: indexPath) as! UserCell
        let user:User = model.users[indexPath.row]
        cell.fillCellWith(user)
        cell.tapAvatarHandler = { [weak self] (user:User) -> Void in
            if self == nil {return}
            self!.performSegueWithIdentifier("ShowUserPreview", sender: user)
        }
        return cell
    }
    
    private func configureLoadingCell(indexPath:NSIndexPath) ->UITableViewCell {
        let cell:LoadingCell = tableView.dequeueReusableCellWithIdentifier(loadingCellIdentifier, forIndexPath: indexPath) as! LoadingCell
        cell.loadMoreHandler = { [weak self] () -> Void in
            if self == nil {return}
            self!.loadNextUsers(needRefresh: false)
            cell.showInterface(.Loading)
        }
        return cell
    }
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == SectionType.Data.rawValue {
            return heightDataCell
        } else {
            return heightLoadingCell
        }
    }
    
    
    // MARK: - Helpers
    
    private func addToTableUsersWith(indexPaths:Array<NSIndexPath>) {
        if model.countPortionsLoaded == 1 {
            tableView.reloadData()
        } else {
            tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Bottom)
        }
    }
    
    private func isNeedShowLoadingCell() ->Bool {
        return model.countPortionsLoaded > 0
    }


    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowUserPreview" {
            let previewVC:PreviewVC = segue.destinationViewController as! PreviewVC
            previewVC.user = sender as? User
        }
    }

}
