//
//  PostViewController.swift
//  MyCanadianBlog
//
//  Created by Romain Margheriti on 08/08/2016.
//  Copyright © 2016 Romain Margheriti. All rights reserved.
//

import UIKit
import FBSDKShareKit

class PostViewController: UIViewController {

    var post: Post? = nil
    
    @IBOutlet weak var postContent: UIWebView!
    @IBOutlet weak var facebookShare: FBSDKShareButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
        content.contentURL = NSURL(string: self.post!.URL!)
        content.contentTitle = "My Candadian Blog"
        content.contentDescription = self.post!.title
        
        facebookShare.shareContent = content
        
        self.postContent.loadHTMLString(Constants.stylesheet + self.post!.content!, baseURL: Constants.PostContentStyle)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
