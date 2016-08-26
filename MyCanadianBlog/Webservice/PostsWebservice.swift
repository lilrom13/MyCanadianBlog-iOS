//
//  PostsWebservice.swift
//  MyCanadianBlog
//
//  Created by Romain Margheriti on 25/08/2016.
//  Copyright © 2016 Romain Margheriti. All rights reserved.
//

import Foundation

class PostsWebservice {
    
    static func getPosts(callByPullToRefresh: Bool) {
        let api = EVWordPressAPI(wordpressOauth2Settings: Wordpress.wordpressOauth2Settings, site: Wordpress.siteName)
        api.posts([.number(19)]) { result in
            if (result != nil) {
                NSNotificationCenter.defaultCenter().postNotificationName("getPostsSucceed", object: nil, userInfo: ["callByPullToRefresh": callByPullToRefresh, "posts": (result?.posts)!])
            } else {
                NSNotificationCenter.defaultCenter().postNotificationName("getPostsFailed", object: nil, userInfo: ["callByPullToRefresh": callByPullToRefresh, "error": "An errror occured."])
            }
        }

    }
}
