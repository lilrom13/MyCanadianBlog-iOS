//
//  TableViewCell.swift
//  MyCanadianBlog
//
//  Created by Romain Margheriti on 01/08/2016.
//  Copyright © 2016 Romain Margheriti. All rights reserved.
//

import UIKit
import Material

class SimplePost: UITableViewCell {

    @IBOutlet weak var pulseView: MaterialPulseView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var postContent: UIWebView!
    @IBOutlet weak var readMoreBtn: FlatButton!
    
    var post: Post?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        preparePulseView()
        prepareLabels()
        prepareFlatButton()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func preparePulseView() {
        self.pulseView.depth = .Depth2
    }
    
    func prepareLabels() {
        self.postTitle.font = RobotoFont.mediumWithSize(20)
        self.postTitle.textColor = MaterialColor.white
        self.postTitle.text = "This is the title"
        
        self.postDate.font = RobotoFont.mediumWithSize(20)
        self.postDate.textColor = MaterialColor.white
        self.postDate.text = "This is the post's date"
    }
    
    func prepareFlatButton() {
        self.readMoreBtn.titleLabel?.font = RobotoFont.mediumWithSize(20)
        self.readMoreBtn.titleLabel?.textColor = MaterialColor.deepOrange.base
    }
    
    func fillCell(post: Post) {
        self.post = post
        
        self.postTitle.text = post.title
        self.postDate.text = post.date
    }
}
