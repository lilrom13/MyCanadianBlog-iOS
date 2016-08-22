//
//  PostViewController.swift
//  MyCanadianBlog
//
//  Created by Romain Margheriti on 08/08/2016.
//  Copyright © 2016 Romain Margheriti. All rights reserved.
//

import UIKit
import Material

class PostViewController: UIViewController, UIScrollViewDelegate {

    private var lastContentOffset: CGFloat = 0
    private var initialHeight: CGFloat = 0
    
    var post: Post? = nil
    
    var featuredImage: UIImage? = nil
    
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var closeBtn: FabButton!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorButton: UIButton!
    @IBOutlet weak var postContentWebView: UIWebView!
    @IBOutlet weak var commentsBtn: FlatButton!

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = true
        self.navigationController?.navigationBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
        self.navigationController?.navigationBar.hidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialHeight = self.height.constant
        
        if (self.featuredImage != nil) {
            self.header.backgroundColor = UIColor(patternImage: self.featuredImage!)
        } else {
            
        }
        
        let img: UIImage? = MaterialIcon.cm.close
        self.closeBtn.setImage(img, forState: .Normal)
        self.closeBtn.setImage(img, forState: .Highlighted)
        self.closeBtn.tintColor = MaterialColor.deepOrange.base
        self.closeBtn.backgroundColor = UIColor.whiteColor()
        self.closeBtn.alpha = 0.5
        
        // Clear the label
        self.categoryLabel.text = ""
        for categorie in self.post!.categories!.categories {
            self.categoryLabel.text! += categorie.name!+" "
        }
        
        self.titleLabel.text = self.post!.title!
        
        self.authorButton.setTitle(self.post!.author!.name, forState: .Normal)
        
        self.postContentWebView.scrollView.delegate = self
        self.postContentWebView.scrollView.showsHorizontalScrollIndicator = false
        self.postContentWebView.scrollView.showsVerticalScrollIndicator = false
        self.postContentWebView.backgroundColor = UIColor.whiteColor()
        self.postContentWebView.loadHTMLString(Constants.stylesheet + self.post!.content!, baseURL: Constants.PostContentStyle)
        
        /*let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
        content.contentURL = NSURL(string: self.post!.URL!)
        content.contentTitle = "My Candadian Blog"
        content.contentDescription = self.post!.title
        
        facebookShare.shareContent = content*/
        
        self.postContentWebView.loadHTMLString(Constants.stylesheet + self.post!.content!, baseURL: Constants.PostContentStyle)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Components interactions
    
    //Scroll
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (self.featuredImage != nil) {
            if (self.lastContentOffset > scrollView.contentOffset.y) {
                if ((self.lastContentOffset <= 0) && (self.height.constant <= self.featuredImage?.height)) {
                    var value = self.lastContentOffset - scrollView.contentOffset.y
                    
                    if ((self.height.constant + value) <= self.featuredImage?.height) {
                        self.height.constant += value
                    } else {
                        value = (self.featuredImage?.height)! - self.height.constant
                        self.height.constant += value
                    }
                }
            } else if (self.lastContentOffset < scrollView.contentOffset.y && lastContentOffset > 0) {
                if (self.height.constant >= self.initialHeight) {
                    var value = scrollView.contentOffset.y - self.lastContentOffset
                    
                    if ((self.height.constant - value) > self.initialHeight) {
                        self.height.constant -= value
                    } else {
                        
                    }
                }
            }
            self.lastContentOffset = scrollView.contentOffset.y
        }
    }

    //closeBtn Clicked
    @IBAction func closeBtnClicked(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showAuthor") {
            let authorVC = segue.destinationViewController as! AuthorViewController
            
            authorVC.author = self.post!.author
        }

    }
}
