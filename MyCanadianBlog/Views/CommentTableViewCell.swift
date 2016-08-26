//
//  CommentTableViewCell.swift
//  MyCanadianBlog
//
//  Created by Romain Margheriti on 22/08/2016.
//  Copyright © 2016 Romain Margheriti. All rights reserved.
//

import UIKit
import Alamofire
import StringExtensionHTML

class CommentTableViewCell: UITableViewCell {

    var comment: Comment?
    

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var login: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var content: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fill(comment: Comment) {
        self.comment = comment
        
        if let avatarUrl = self.comment!.author?.avatar_URL {
            Alamofire.request(.GET, avatarUrl)
                .responseImage { response in
                    if let image = response.result.value {
                        self.avatar.image = image
                    }
            }
        }
        
        let speudo = self.comment?.author!.login!
        if speudo != "" {
            self.login.text = speudo
        } else {
            self.login.text = self.comment!.author!.name!
        }
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        
        self.date.text = dateFormatter.stringFromDate(self.comment!.date!)
        self.content.text = self.comment!.content!.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil).stringByDecodingHTMLEntities
    }
}
