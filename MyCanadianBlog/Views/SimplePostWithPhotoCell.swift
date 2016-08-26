//
//  TableViewCell.swift
//  MyCanadianBlog
//
//  Created by Romain Margheriti on 01/08/2016.
//  Copyright © 2016 Romain Margheriti. All rights reserved.
//

import UIKit
import Material
import AlamofireImage
import Alamofire

class SimplePostWithPhotoCell: UITableViewCell {
    
    var post: Post?
    var color = UIColor.whiteColor()
    
    @IBOutlet weak var pulseView: MaterialPulseView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var postContent: UILabel!
    @IBOutlet weak var lowerPulseView: MaterialPulseView!
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
        
        if (self.post?.featured_image!.URLString != "") {
            Alamofire.request(.GET, (self.post!.featured_image?.URLString)!)
                .responseImage { response in
                    if let image = response.result.value {
                        self.pulseView.image = image.alpha(Constants.mainAlpha)
                    }
            }
        }
        
        self.color = Utils.getRandomColor()
        self.lowerPulseView.backgroundColor = self.color
    }
}
