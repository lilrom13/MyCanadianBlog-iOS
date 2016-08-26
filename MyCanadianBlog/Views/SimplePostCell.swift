//
//  SimplePostCell.swift
//  MyCanadianBlog
//
//  Created by Romain Margheriti on 25/08/2016.
//  Copyright © 2016 Romain Margheriti. All rights reserved.
//

import UIKit
import Material

class SimplePostCell: UITableViewCell {

    var post: Post?
    var color: UIColor = UIColor.whiteColor()
    @IBOutlet weak var pulseView: MaterialPulseView!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var postContent: UILabel!
    @IBOutlet weak var postTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        preparePulseView()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func preparePulseView() {
        self.pulseView.depth = .Depth2
    }
    
    func fillCell(post: Post) {
        self.post = post
        
        self.postTitle.text = self.post!.title
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        self.postDate.text = self.post!.date
        
        self.postContent.text = self.post!.content?.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil).stringByDecodingHTMLEntities
        
        self.color = Utils.getRandomColor()
        self.pulseView.backgroundColor = self.color
    }

}
