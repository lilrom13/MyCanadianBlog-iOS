//
//  TweetsTableViewController.swift
//  MyCanadianBlog
//
//  Created by Romain Margheriti on 19/08/2016.
//  Copyright © 2016 Romain Margheriti. All rights reserved.
//

import UIKit
import TwitterKit

class TweetsTableViewController: TWTRTimelineViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let client = TWTRAPIClient()
        let dataSource = TWTRUserTimelineDataSource(screenName: "Rowm1n", APIClient: client)
        self.dataSource = dataSource
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
