//
//  CommentsTableViewController.swift
//  MyCanadianBlog
//
//  Created by Romain Margheriti on 22/08/2016.
//  Copyright © 2016 Romain Margheriti. All rights reserved.
//

import UIKit
import Material
import DGElasticPullToRefresh

class CommentsTableViewController: UITableViewController {
    private let TAG = "CommentsTableViewController"
    
    var postId: Int? = nil
    var comments: [Comment] = [Comment]()
    var color: UIColor?
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = Constants.mainColor
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor.whiteColor()
        tableView.dg_addPullToRefreshWithActionHandler({ () -> Void in
            self.tableView.dg_stopLoading()
        }, loadingView: loadingView)
        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
        
        if let color = self.color {
            self.navigationController?.navigationBar.barTintColor = color
            tableView.dg_setPullToRefreshFillColor(color)
            //addCommentBtn.backgroundColor = color
        } else {
            tableView.dg_setPullToRefreshFillColor(Constants.mainColor)
        }
        
        tableView.estimatedRowHeight = 115
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let api = EVWordPressAPI(wordpressOauth2Settings: Wordpress.wordpressOauth2Settings, site: Wordpress.siteName)
        api.replies(String(postId!), parameters: [.number(19)]) { result in
            if (result != nil) {
                self.comments = result!.comments!
                self.comments = self.comments.reverse()
                self.tableView.reloadData()
            } else {
                print("\(self.TAG) : an error occurred")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return comments.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell", forIndexPath: indexPath) as! CommentTableViewCell

        cell.fill(self.comments[indexPath.section])

        return cell
    }
    
    override func tableView(tableView: UITableView,  heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
}
