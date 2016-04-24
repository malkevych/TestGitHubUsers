//
//  LoadingCell.swift
//  TestGitHubUsers
//
//  Created by Malkevych Bohdan Ihorovych on 24.04.16.
//  Copyright © 2016 MB. All rights reserved.
//

import UIKit

class LoadingCell: UITableViewCell {
    
    typealias LoadMoreHandler = () -> Void
    @IBOutlet weak var activeIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var btnAction: UIButton!
    var loadMoreHandler:LoadMoreHandler?
    
    enum Interface: Int {
        case LoadMore
        case Loading
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(onPrtionLoaded), name: Constants.kNCLoadingFinished, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @objc private func onPrtionLoaded() {
        showInterface(.LoadMore)
    }
    
    @IBAction func onTouchBtnAction(sender: AnyObject) {
        if let loadMoreHandler = loadMoreHandler {
            loadMoreHandler()
        }
    }
    
    internal func showInterface(type:Interface) {
        if type == .Loading {
            activeIndicatorView.startAnimating()
            btnAction.hidden = true
        } else {
            activeIndicatorView.stopAnimating()
            btnAction.hidden = false
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        showInterface(.LoadMore)
    }
}
