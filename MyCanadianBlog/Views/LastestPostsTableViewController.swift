//
//  TableViewController.swift
//  MyCanadianBlog
//
//  Created by Romain Margheriti on 01/08/2016.
//  Copyright © 2016 Romain Margheriti. All rights reserved.
//

import UIKit
import AlamofireOauth2

class LastestPostsTableViewController: UITableViewController {
    let TAG = "LASTESTPOSTS"
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    let wordpressOauth2Settings = Oauth2Settings(
        baseURL: "https://public-api.wordpress.com/rest/v1.1",
        authorizeURL: "https://public-api.wordpress.com/oauth2/authorize",
        tokenURL: "https://public-api.wordpress.com/oauth2/token",
        redirectURL: "alamofireoauth2://wordpress/oauth_callback",
        clientID: Wordpress.ClientId,
        clientSecret: Wordpress.clientSecret
    )
    
    var posts: [Post] = [Post]()
    
    var selectedCell: Int = 0
    var imageFeatured = UIImage(named: "DrawerBackground")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(featuredImageLoadded),name: "featuredImageLoadded", object: nil)
        
        let api = EVWordPressAPI(wordpressOauth2Settings: self.wordpressOauth2Settings, site: "romainmargheriti.com")
        api.posts([.number(19)]) { result in
            if (result != nil) {
                self.posts = (result?.posts)!
                self.tableView.reloadData()
            } else {
                print("\(self.TAG) : an error occurred")
            }
        }
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
        let cell = tableView.dequeueReusableCellWithIdentifier("SimplePost", forIndexPath: indexPath) as! SimplePostViewCell

        cell.fillCell(self.posts[indexPath.section])

        return cell
    }

    override func tableView(tableView: UITableView,
                   didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedCell = indexPath.section
        performSegueWithIdentifier("showPost", sender: nil)
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showPost") {
            let postVC = segue.destinationViewController as! PostViewController
            
            postVC.post = self.posts[self.selectedCell]
            if let image = imageFeatured {
                postVC.featuredImage = image
            }
        }
    }
    
    // MARK : Callbacks
    func featuredImageLoadded(notification: NSNotification) {
        if let infos = notification.userInfo as? Dictionary<String,AnyObject> {
            if let image = infos["image"] as? UIImage {
                self.imageFeatured = image
            }
        }
    }
}
