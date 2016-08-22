//
//  FlickrPhoto.swift
//  MyCanadianBlog
//
//  Created by Romain Margheriti on 21/08/2016.
//  Copyright © 2016 Romain Margheriti. All rights reserved.
//

import Foundation

class FlickrPhoto {
    let id: String
    init(representation: NSDictionary) {
        self.id = representation.valueForKey("id") as! String
    }
}