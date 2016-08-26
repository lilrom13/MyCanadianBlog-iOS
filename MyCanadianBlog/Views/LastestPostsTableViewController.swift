//
//  TableViewController.swift
//  MyCanadianBlog
//
//  Created by Romain Margheriti on 01/08/2016.
//  Copyright © 2016 Romain Margheriti. All rights reserved.
//

import UIKit
import AlamofireOauth2
import DGElasticPullToRefresh

class LastestPostsTableViewController: UITableViewController {
    let TAG = "LASTESTPOSTS"
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var posts: [Post] = [Post]()
    
    var lastSelectedCell: SelectedCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LastestPostsTableViewController.getPostsSucceed(_:)), name: "getPostsSucceed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LastestPostsTableViewController.getPostsFailed(_:)), name: "getPostsFailed", object: nil)
        
        PostsWebservice.getPosts(false)
        
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor.whiteColor()
        tableView.dg_addPullToRefreshWithActionHandler({ () -> Void in
            self.tableView.allowsSelection = false
            PostsWebservice.getPosts(true)
        }, loadingView: loadingView)
        tableView.dg_setPullToRefreshFillColor(Constants.mainColor)
        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.posts.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (self.posts[indexPath.section].featured_image != "") {
            let cell = tableView.dequeueReusableCellWithIdentifier("SimplePostWithPhotoCell", forIndexPath: indexPath) as! SimplePostWithPhotoCell
            cell.fillCell(self.posts[indexPath.section])
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("SimplePostCell", forIndexPath: indexPath) as! SimplePostCell
            cell.fillCell(self.posts[indexPath.section])
            return cell
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell: UITableViewCell
        var image: UIImage? = nil
        var color: UIColor
        
        if (self.tableView.cellForRowAtIndexPath(indexPath)?.reuseIdentifier == "SimplePostWithPhotoCell") {
            cell = self.tableView.cellForRowAtIndexPath(indexPath) as! SimplePostWithPhotoCell
            image = (cell as! SimplePostWithPhotoCell).pulseView.image
            color = (cell as! SimplePostWithPhotoCell).color
        } else {
            cell = self.tableView.cellForRowAtIndexPath(indexPath) as! SimplePostCell
            color = (cell as! SimplePostCell).color
        }
        self.lastSelectedCell = SelectedCell(cell: cell, section: indexPath.section, color: color, featuredImage: image)
        performSegueWithIdentifier("showPost", sender: nil)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (self.posts[indexPath.section].featured_image != "") {
            return 250.0
        } else {
            return 153.0
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showPost") {
            let postVC = segue.destinationViewController as! PostViewController
            
            if let post = sender as? Post {
               postVC.post = post
            } else {
                postVC.post = self.posts[self.lastSelectedCell!._section]
                
                if (self.lastSelectedCell?._cell is SimplePostWithPhotoCell) {
                    postVC.featuredImage = self.lastSelectedCell!._featuredImage!
                }
                postVC.color = self.lastSelectedCell!._color
            }
        }
    }
    
    // MARK : CallBacks
    
    func getPostsSucceed(notification: NSNotification) {
        if let posts = notification.userInfo!["posts"] as? [Post] {
            if (posts != self.posts) {
                self.posts = posts
                self.tableView.reloadData()
            }
            if let callByPullToRefresh = notification.userInfo!["callByPullToRefresh"] as? Bool {
                if (callByPullToRefresh) {
                    self.tableView.dg_stopLoading()
                    self.tableView.allowsSelection = true
                }
            }
        }
    }
    
    func getPostsFailed(notification: NSNotification) {
        let errorMessage = notification.userInfo!["error"] as? String
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
        if let callByPullToRefresh = notification.userInfo!["callByPullToRefresh"] as? Bool {
            if (callByPullToRefresh) {
                self.tableView.dg_stopLoading()
                self.tableView.allowsSelection = true
            }
        }
    }
}
