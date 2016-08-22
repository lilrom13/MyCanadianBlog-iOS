
//
//  Constants.swift
//  MyCanadianBlog
//
//  Created by Romain Margheriti on 05/08/2016.
//  Copyright © 2016 Romain Margheriti. All rights reserved.
//

import Foundation

class Constants {
    static let stylesheetCell = "<link rel=\"stylesheet\" href=\"PostContentCellStyle.css\" type=\"text/css\">"
    static let stylesheet = "<link rel=\"stylesheet\" href=\"PostContentStyle.css\" type=\"text/css\">"
    static let PostContentStyle = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("PostContentStyle.css", ofType: nil)!)
    static let PostContentCellStyle = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("PostContentCellStyle.css", ofType: nil)!)
}